# table_system/core/views.py
from django.http import HttpResponse
from . import storage

# 템플릿 사용
from django.shortcuts import render

# Create your views here.

# 메뉴 캐싱해서 사용
_price_map_cache = None

def _get_price_map():
    """
    메뉴 이름 -> 가격 딕셔너리를 캐싱해서 돌려줌.
    관리자가 메뉴를 수정하면 캐시를 날려서 다시 만들도록 함.
    """
    global _price_map_cache
    if _price_map_cache is None:
        menus = storage.load_menus()
        _price_map_cache = {m['name']: m['price'] for m in menus}
    return _price_map_cache

def _admin_menu_stat(request, menus):
    # 메뉴 목록을 템플릿으로 렌더링
    return render(request, "admin_menu_stat.html", {"menus": menus})

# 테이블 캐싱해서 사용
_tables_cache = None

def _get_tables():
    """
    tables.json 내용을 메모리에 캐싱해서 사용.
    처음 요청 시 한 번만 파일에서 읽고,
    이후에는 메모리에서 바로 반환.
    """
    global _tables_cache
    if _tables_cache is None:
        _tables_cache = storage.load_tables()
    return _tables_cache


def _save_tables(tables):
    """
    tables 데이터를 파일 + 캐시에 동시에 반영.
    (쓰기 작업이 있을 때만 파일 I/O 발생)
    """
    global _tables_cache
    _tables_cache = tables           # 캐시 갱신
    storage.save_tables(tables)      # 파일에 저장

# -----------------------
# 관리자: 메뉴
# -----------------------
def admin_menu(request):
    global _price_map_cache   

    action = request.GET.get('action')
    menus = storage.load_menus()

    # 1. 메뉴 추가
    if action == 'add':
        name = request.GET.get('name')
        price = request.GET.get('price')
        for m in menus:
            if m['name'] == name:
                return HttpResponse("menu add error")
        menus.append({"name": name, "price": int(price)})
        storage.save_menus(menus)

        # 메뉴가 바뀌었으니 캐시 무효화
        _price_map_cache = None

        return _admin_menu_stat(request, menus)

    # 2. 메뉴 삭제
    elif action == 'del':
        name = request.GET.get('name')
        found = False
        new_list = []
        for m in menus:
            if m['name'] == name:
                found = True
            else:
                new_list.append(m)
        if not found:
            return HttpResponse("menu del error")
        storage.save_menus(new_list)

        # 메뉴가 바뀌었으니 캐시 무효화
        _price_map_cache = None

        return _admin_menu_stat(request, new_list)

    # 3. 현재 사용 가능한 메뉴이름, 가격 표시
    elif action == 'stat':
        return _admin_menu_stat(request, menus)

    else:
        return HttpResponse("invalid action")

# -----------------------
# 관리자: 테이블
# -----------------------
def admin_table(request):
    action = request.GET.get('action')
    tid = request.GET.get('tid')
    tables = _get_tables()

    # 4. 테이블 추가
    if action == 'add':
        if tid in tables:
            return HttpResponse("table add error")
        tables[tid] = {
            "orders": [],
            "finished": False,
            "checked_out": False,
        }
        _save_tables(tables)
        return _admin_table_stat(request, tables)

    # 5. 테이블 삭제
    elif action == 'del':
        if tid not in tables:
            return HttpResponse("table del error")
        if not tables[tid].get("checked_out", False):
            return HttpResponse("table del error2")
        del tables[tid]
        _save_tables(tables)
        return _admin_table_stat(request, tables)

# 6. 테이블 상태 표시
    elif action == 'stat':
        return _admin_table_stat(request, tables)

    else:
        return HttpResponse("invalid action")


def _admin_table_stat(request, tables: dict):
    # 각 테이블의 총 주문 금액 계산 (성능 최적화: 직접 딕셔너리에 추가)
    tables_dict = {}
    for tid, data in tables.items():
        total_amount = 0
        for o in data.get("orders", []):
            total_amount += o["price"] * o["num"]
        # 기존 데이터를 복사하고 total_amount만 추가
        tables_dict[tid] = {
            "orders": data.get("orders", []),
            "finished": data.get("finished", False),
            "checked_out": data.get("checked_out", False),
            "total_amount": total_amount
        }
    
    return render(request, "admin_table_stat.html", {"tables": tables_dict})

# -----------------------
# 관리자: 상태/status
# -----------------------
# 7. 현황 확인 
def admin_status(request):
    tables = _get_tables()
    view = []
    for tid, data in tables.items():
        total = 0
        items = []
        for o in data["orders"]:
            sub = o["price"] * o["num"]
            total += sub
            items.append({"menu": o["menu"], "num": o["num"], "subtotal": sub})
        view.append({"tid": tid, "orders": items, "total": total})
    return render(request, "admin_status.html", {"tables": view})

# def admin_status(request):
#     tables = storage.load_tables()
#     lines = ["<h1>All Table Status</h1>"]
#     for tid, data in tables.items():
#         lines.append(f"<h2>Table {tid}</h2>")
#         total = 0
#         for o in data["orders"]:
#             subtotal = o["price"] * o["num"]
#             total += subtotal
#             lines.append(f"{o['menu']} x {o['num']} = {subtotal}<br>")
#         lines.append(f"Total: {total}<br>")
#         lines.append(f'<a href="/admin/checkout.html?tid={tid}">결제하기</a><hr>')
#     return HttpResponse("".join(lines))

# -----------------------
# 관리자: 결제
# -----------------------
# 8. 테이블 결제
def admin_checkout(request):
    tid = request.GET.get('tid')
    tables = _get_tables()
    if tid not in tables:
        return HttpResponse("table checkout error")
    tables[tid]["orders"] = []
    tables[tid]["checked_out"] = True
    tables[tid]["finished"] = False
    _save_tables(tables)
    return admin_status(request)

# -----------------------
# 고객: 주문
# -----------------------
def customer_order(request):
    action = request.GET.get('action')
    tid = request.GET.get('tid')

    # menus = storage.load_menus()  
    # tables = storage.load_tables()
    tables = _get_tables()   # 캐시에서 가져오기

    # 테이블이 없으면 공통 에러
    if tid not in tables:
        return HttpResponse("customer order table error")

    # 매번 다시 만들지 말고, 캐시에서 가져오기
    price_map = _get_price_map()

    # 1. 메뉴 주문 (같은 메뉴는 수량만 증가)
    if action == 'add':
        menu = request.GET.get('menu')
        num = int(request.GET.get('num', 1))
        if menu not in price_map:
            return HttpResponse("customer order add menu error")

        orders = tables[tid]["orders"]
        found = False
        for o in orders:
            if o["menu"] == menu:
                o["num"] += num   # 수량만 증가
                found = True
                break

        if not found:
            orders.append({
                "menu": menu,
                "num": num,
                "price": price_map[menu],
            })

        _save_tables(tables)
        return _customer_order_stat(request, tid, tables[tid])

    # 2. 주문 취소 (여러 줄에 흩어져 있어도 합쳐서 삭제)
    elif action == 'del':
        menu = request.GET.get('menu')
        num = int(request.GET.get('num', 1))

        orders = tables[tid]["orders"]
        found = False
        remain = num
        new_orders = []

        for o in orders:
            if o["menu"] == menu and remain > 0:
                found = True
                if o["num"] > remain:
                    # 일부만 줄이고 남김
                    o["num"] -= remain
                    remain = 0
                    new_orders.append(o)
                elif o["num"] == remain:
                    # 딱 맞게 삭제 → 이 줄은 사라짐
                    remain = 0
                else:
                    # 이 줄 수량 < 남은 삭제 수량 → 전부 삭제하고 계속
                    remain -= o["num"]
            else:
                new_orders.append(o)

        if not found:
            return HttpResponse("customer order del menu error")

        tables[tid]["orders"] = new_orders
        _save_tables(tables)
        return _customer_order_stat(request, tid, tables[tid])

    # 3. 주문 확정(서빙완료)
    elif action == 'finish':
        tables[tid]["finished"] = True
        _save_tables(tables)
        return _customer_order_stat(request, tid, tables[tid])

    # 4. 해당 테이블의 현재 주문 상태 표시
    elif action == 'stat':
        return _customer_order_stat(request, tid, tables[tid])

    else:
        return HttpResponse("invalid action")

def _customer_order_stat(request, tid: str, table_data: dict):
    # 주문 내역 계산 (성능 최적화: get 호출 최소화)
    orders_list = table_data.get("orders", [])
    orders = []
    total = 0
    for o in orders_list:
        subtotal = o["price"] * o["num"]
        total += subtotal
        orders.append({
            "menu": o["menu"],
            "num": o["num"],
            "price": o["price"],
            "subtotal": subtotal
        })
    
    context = {
        "tid": tid,
        "orders": orders,
        "total": total,
        "finished": table_data.get("finished", False)
    }
    return render(request, "customer_stat.html", context)