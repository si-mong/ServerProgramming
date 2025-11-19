// storage.js
// 성능을 위해: 서버 시작 시 한 번만 파일에서 읽고,
// 이후에는 메모리에 캐시해두고 쓰기 작업 때만 파일에 저장.

const fs = require('fs');
const path = require('path');

const dataDir = path.join(__dirname, 'data');
const menuFile = path.join(dataDir, 'menus.json');
const tableFile = path.join(dataDir, 'tables.json');
const orderFile = path.join(dataDir, 'orders.json');

let menusCache = [];
let tablesCache = [];
let ordersCache = {}; // { [tid]: { items: [ {menu, num, price} ], finished: bool } }

function ensureFiles() {
  if (!fs.existsSync(dataDir)) {
    fs.mkdirSync(dataDir, { recursive: true });
  }

  if (!fs.existsSync(menuFile)) {
    fs.writeFileSync(menuFile, '[]', 'utf-8');
  }
  if (!fs.existsSync(tableFile)) {
    fs.writeFileSync(tableFile, '[]', 'utf-8');
  }
  if (!fs.existsSync(orderFile)) {
    fs.writeFileSync(orderFile, '{}', 'utf-8');
  }

  // 초기 캐시 로딩
  try {
    menusCache = JSON.parse(fs.readFileSync(menuFile, 'utf-8') || '[]');
  } catch (e) {
    console.error('menus.json parse error, reset []', e);
    menusCache = [];
  }

  try {
    tablesCache = JSON.parse(fs.readFileSync(tableFile, 'utf-8') || '[]');
  } catch (e) {
    console.error('tables.json parse error, reset []', e);
    tablesCache = [];
  }

  try {
    ordersCache = JSON.parse(fs.readFileSync(orderFile, 'utf-8') || '{}');
  } catch (e) {
    console.error('orders.json parse error, reset {}', e);
    ordersCache = {};
  }
}

// 내부적으로만 사용하는 저장 함수 (동기식으로 빠르게 저장)
// 성능을 위해 JSON 포맷팅 제거 (공백 제거)
function saveMenusInternal() {
  fs.writeFileSync(menuFile, JSON.stringify(menusCache), 'utf-8');
}

function saveTablesInternal() {
  fs.writeFileSync(tableFile, JSON.stringify(tablesCache), 'utf-8');
}

function saveOrdersInternal() {
  fs.writeFileSync(orderFile, JSON.stringify(ordersCache), 'utf-8');
}

// 외부에서 사용할 getter/setter
function getMenus() {
  return menusCache;
}

function saveMenus(menus) {
  menusCache = menus;
  saveMenusInternal();
}

function getTables() {
  return tablesCache;
}

function saveTables(tables) {
  tablesCache = tables;
  saveTablesInternal();
}

function getOrders() {
  return ordersCache;
}

function saveOrders(orders) {
  ordersCache = orders;
  saveOrdersInternal();
}

module.exports = {
  ensureFiles,
  getMenus,
  saveMenus,
  getTables,
  saveTables,
  getOrders,
  saveOrders,
};