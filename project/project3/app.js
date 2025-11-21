const express = require('express');
const path = require('path');
const morgan = require('morgan');

const storage = require('./storage');

const app = express();
const PORT = 8000; // 컨테이너에서는 8000 -> 호스트 3010 매핑

// 데이터 파일 준비 + 메모리 캐시 로딩
storage.ensureFiles();

// 로그 출력 (개발 편하도록) - 프로덕션에서는 비활성화
if (process.env.NODE_ENV !== 'production') {
  app.use(morgan('dev'));
}

// 정적 파일 (선택: 스타일 적용용)
/*
app.use(express.static(path.join(__dirname, 'public')));
*/

// Pug 설정
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');
// 프로덕션 모드에서 Pug 템플릿 캐싱 활성화 (성능 향상)
if (process.env.NODE_ENV === 'production') {
  app.set('view cache', true);
}

// 루트: 관리자 현황 페이지로 리다이렉트
app.get('/', (req, res) => {
  res.redirect('/admin/status.html');
});


// ---------------------- 관리자: 메뉴 ----------------------
/**
 * 1. /admin/menu.html?action=add&name=메뉴이름&price=가격
 *    - 이미 존재하는 메뉴 추가시 "menu add error"
 *    - 완료 후 stat 페이지로
 * 2. /admin/menu.html?action=del&name=메뉴이름
 *    - 없는 메뉴 삭제시 "menu del error"
 *    - 완료 후 stat 페이지로
 * 3. /admin/menu.html?action=stat
 *    - 메뉴 이름, 가격 표시 (pug)
 */
app.get('/admin/menu.html', (req, res) => {
  const action = req.query.action;
  const name = req.query.name;
  const price = req.query.price;

  let menus = storage.getMenus();

  // 메뉴 추가
  if (action === 'add') {
    // 둘 중 하나라도 입력이 안되어 있으면 에러
    if (!name || !price) {
      return res.type('text/plain').send('menu add error');
    }
    // 메뉴 중복 체크
    const exists = menus.find((m) => m.name === name);
    if (exists) {
      return res.type('text/plain').send('menu add error');
    }
    // 가격 형식 체크
    const intPrice = parseInt(price, 10);
    if (Number.isNaN(intPrice)) {
      return res.type('text/plain').send('menu add error');
    }
    // 문제 없으면 메뉴 추가
    menus.push({ name, price: intPrice });
    storage.saveMenus(menus);

    return res.redirect('/admin/menu.html?action=stat');

  }
  // 메뉴 삭제
  if (action === 'del') {
    if (!name) {
      return res.type('text/plain').send('menu del error');
    }

    // 메뉴 존재 여부 체크 - 없는 메뉴면 삭제 에러 
    const idx = menus.findIndex((m) => m.name === name);
    if (idx === -1) {
      return res.type('text/plain').send('menu del error');
    }

    // 해당 인덱스의 메뉴를 배열에서 제거하고 저장
    menus.splice(idx, 1);
    storage.saveMenus(menus);

    return res.redirect('/admin/menu.html?action=stat');
  }

  // stat 또는 그 외 → 메뉴 목록 표시
  return res.render('admin/menu', {
    title: '메뉴 관리',
    menus,
  });
});

// ---------------------- 관리자: 테이블 ----------------------
/**
 * 4. /admin/table.html?action=add&tid=테이블아이디
 *    - 이미 존재하는 테이블 추가시 "table add error"
 *    - 완료 후 stat
 *
 * 5. /admin/table.html?action=del&tid=테이블아이디
 *    - 없는 테이블 삭제시 "table del error"
 *    - 계산이 완료되지 않은 테이블 삭제시 "table del error2"
 *    - 완료 후 stat
 *
 * 6. /admin/table.html?action=stat
 *    - 현재 사용 가능한 테이블아이디 표시
 */

app.get('/admin/table.html', (req, res) => {
  const action = req.query.action;
  const tid = req.query.tid;

  // 테이블과 주문 내역 목록 
  let tables = storage.getTables();
  let orders = storage.getOrders();

  // 테이블 추가
  if (action === 'add') {
    if (!tid) {
      return res.type('text/plain').send('table add error');
    }

    // 테이블 중복 체크
    const exists = tables.find((t) => t.tid === tid);
    if (exists) {
      return res.type('text/plain').send('table add error');
    }

    // 파일로 저장
    tables.push({ tid });
    storage.saveTables(tables);

    return res.redirect('/admin/table.html?action=stat');
  }

  // 테이블 삭제
  if (action === 'del') {

    // tid가 없으면 에러
    if (!tid) {
      return res.type('text/plain').send('table del error');
    }

    // 테이블 존재 여부 체크
    const idx = tables.findIndex((t) => t.tid === tid);
    if (idx === -1) {
      return res.type('text/plain').send('table del error');
    }

    // 주문 내역이 있으면 에러
    const order = orders[tid];
    if (order && order.items && order.items.length > 0) {
      return res.type('text/plain').send('table del error2');
    }

    // 테이블 삭제
    tables.splice(idx, 1);
    storage.saveTables(tables);

    // 테이블 삭제 완료 후 stat 페이지로 리다이렉트
    return res.redirect('/admin/table.html?action=stat');
  }

  // stat 또는 그 외
  // 테이블 목록 표시 
  return res.render('admin/table', {
    title: '테이블 관리',
    tables,
  });
});


// ---------------------- 관리자: 전체 현황 ----------------------
/**
 * 7. /admin/status.html
 *    - 모든 테이블에 대해서 주문이 뭐뭐 있는지 표시
 *    - 각 테이블 별 주문내용, 가격, 총합계 표시
 *    - 각 테이블 별 결제하기 버튼 -> 8번으로 이동
 */
app.get('/admin/status.html', (req, res) => {
  const tables = storage.getTables();
  const orders = storage.getOrders();

  // 테이블 별 주문 내역 표시
  const statusList = tables.map((t) => {
    const o = orders[t.tid] || { items: [], finished: false };
    const items = o.items || [];
    const total = items.reduce((sum, it) => sum + it.price * it.num, 0);

    // 테이블 별 주문 내역 반환
    return {
      tid: t.tid,
      items,
      total,
      finished: !!o.finished,
    };
  });

  // 전체 테이블 현황 표시
  res.render('admin/status', {
    title: '전체 테이블 현황',
    statusList,
  });
});


// ---------------------- 관리자: 결제 (stub) ----------------------
/**
 * 8. /admin/checkout.html?tid=테이블아이디
 *    - 해당 테이블의 계산을 완료함
 *    - 없는 테이블 계산시 "table checkout error"
 *    - 완료 후 7번(status)으로 이동
 */
app.get('/admin/checkout.html', (req, res) => {
  const tid = req.query.tid;
  const tables = storage.getTables();
  const orders = storage.getOrders();

  // tid가 없으면 에러
  if (!tid) {
    return res.type('text/plain').send('table checkout error');
  }

  // 테이블 존재 여부 체크
  const exists = tables.find((t) => t.tid === tid);
  if (!exists) {
    return res.type('text/plain').send('table checkout error');
  }

  // 이 테이블의 주문 내역을 완전히 정리 (계산 완료된 상태로 간주)
  if (orders[tid]) {
    delete orders[tid];
    storage.saveOrders(orders);
  }

  return res.redirect('/admin/status.html');
});

// ---------------------- 고객: 주문 ----------------------
/**
 * 고객 기능
 * 1. /customer/order.html?action=add&tid=테이블아이디&menu=메뉴이름&num=수량
 *    - 없는 메뉴 주문시 "customer order add menu error"
 *    - 없는 테이블에서 주문시 "customer order table error"
 *    - 완료 후 4번(stat)으로 이동
 *
 * 2. /customer/order.html?action=del&tid=테이블아이디&menu=메뉴이름&num=수량
 *    - 없는 메뉴 삭제시 "customer order del menu error"
 *      (해당 테이블 주문 내역에 그 메뉴가 없을 때)
 *    - 없는 테이블에서 삭제시 "customer order table error"
 *    - 완료 후 4번(stat)으로 이동
 *
 * 3. /customer/order.html?action=finish&tid=테이블아이디
 *    - 주문이 완료되어 확정 (요리 준비 시작)
 *    - 완료 후 4번(stat)으로 이동
 *
 * 4. /customer/order.html?action=stat&tid=테이블아이디
 *    - 해당 테이블의 현재 주문 상태 표시 (pug)
 */

app.get('/customer/order.html', (req, res) => {
  const action = req.query.action;
  const tid = req.query.tid;
  const menuName = req.query.menu;
  const numStr = req.query.num;

  // 메뉴와 테이블 목록, 테이블 별 주문 내역
  const menus = storage.getMenus();
  const tables = storage.getTables();
  const orders = storage.getOrders();

  // 테이블 존재 여부 확인 함수
  const findTable = () => tables.find((t) => t.tid === tid);

  // 공통: stat 화면 렌더
  const renderStat = () => {
    const tableExists = findTable();
    if (!tableExists) {
      return res.type('text/plain').send('customer order table error');
    }

    const order = orders[tid] || { items: [], finished: false };
    const items = order.items || [];
    const total = items.reduce((sum, it) => sum + it.price * it.num, 0);

    // 테이블 별 주문 내역 표시
    return res.render('customer/order', {
      title: `테이블 ${tid} 주문 현황`,
      tid,
      items,
      total,
      finished: order.finished || false,
      menus,
    });
  };

  // ---- action별 처리 ----
  // 4. stat
  if (action === 'stat') {
    if (!tid) {
      return res.type('text/plain').send('customer order table error');
    }
    return renderStat();
  }

  // 나머지 액션(add/del/finish)은 모두 tid가 필수
  if (!tid) {
    return res.type('text/plain').send('customer order table error');
  }

  // 테이블 체크 (add/del/finish 공통)
  if (!findTable()) {
    return res.type('text/plain').send('customer order table error');
  }

  // 1. add
  if (action === 'add') {
    if (!menuName || !numStr) {
      return res.type('text/plain').send('customer order add menu error');
    }

    // 메뉴 존재 여부 체크
    const menuInfo = menus.find((m) => m.name === menuName);
    if (!menuInfo) {
      return res.type('text/plain').send('customer order add menu error');
    }

    // 수량 형식 체크
    const num = parseInt(numStr, 10);
    if (Number.isNaN(num) || num <= 0) {
      // 수량 이상하면 그냥 메뉴 에러로 처리 (스펙에 별도 에러 없음)
      return res.type('text/plain').send('customer order add menu error');
    }

    // 주문 내역이 없으면 초기화
    if (!orders[tid]) {
      orders[tid] = { items: [], finished: false };
    }
    const order = orders[tid];

    // 주문 내역에 해당 메뉴가 없으면 추가
    let item = order.items.find((it) => it.menu === menuName);
    if (!item) {
      item = { menu: menuName, num: 0, price: menuInfo.price };
      order.items.push(item);
    }
    item.num += num;

    storage.saveOrders(orders);

    // 완료 후 stat
    return res.redirect(
      `/customer/order.html?action=stat&tid=${encodeURIComponent(tid)}`
    );
  }

  // 2. del
  if (action === 'del') {
    if (!menuName || !numStr) {
      return res.type('text/plain').send('customer order del menu error');
    }

    // 주문 내역이 없으면 에러
    const order = orders[tid];
    if (!order || !order.items) {
      return res.type('text/plain').send('customer order del menu error');
    }

    // 수량 형식 체크
    const num = parseInt(numStr, 10);
    if (Number.isNaN(num) || num <= 0) {
      return res.type('text/plain').send('customer order del menu error');
    }

    // 주문 내역에 해당 메뉴가 없으면 에러
    const idx = order.items.findIndex((it) => it.menu === menuName);
    if (idx === -1) {
      return res.type('text/plain').send('customer order del menu error');
    }

    // 주문 내역에 해당 메뉴 수량 감소
    const item = order.items[idx];
    item.num -= num;
    if (item.num <= 0) {
      order.items.splice(idx, 1);
    }

    // items가 비면 orders[tid]를 지워줘도 되고, 빈 상태로 두어도 됨
    if (!order.items.length) {
      delete orders[tid];
    }

    storage.saveOrders(orders);

    return res.redirect(
      `/customer/order.html?action=stat&tid=${encodeURIComponent(tid)}`
    );
  }

  // 3. finish
  if (action === 'finish') {
    if (!orders[tid]) {
      // 주문이 없었다면 빈 주문 + finished 상태로 만들어 둠
      // 굳이 필요한가? 그냥 다 finished 처리하면 될 거 같기도 함
      orders[tid] = { items: [], finished: true };
    } else {
      orders[tid].finished = true;
    }

    storage.saveOrders(orders);

    return res.redirect(
      `/customer/order.html?action=stat&tid=${encodeURIComponent(tid)}`
    );
  }

  // 정의되지 않은 action
  return res.type('text/plain').send('not implemented');
});


// ---------------------- 서버 시작 ----------------------
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});