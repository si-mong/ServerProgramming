#!/bin/bash
BASE_URL="http://127.0.0.1:8000"

M1="ganjjajang"
M2="jjamppong"
T1="T001"
T2="L0003"

req() {
    local title="$1"
    local path="$2"
    echo
    echo "===== $title ====="
    curl -s "${BASE_URL}${path}"
    echo
}

echo "### 관리자 메뉴 테스트 ###"

req "메뉴 추가1" "/admin/menu.html?action=add&name=${M1}&price=8000"
req "메뉴 중복 추가" "/admin/menu.html?action=add&name=${M1}&price=8000"
req "없는 메뉴 삭제" "/admin/menu.html?action=del&name=${M2}"
req "메뉴 추가2" "/admin/menu.html?action=add&name=${M2}&price=9000"
req "메뉴 조회" "/admin/menu.html?action=stat"

echo "### 관리자 테이블 테스트 ###"

req "테이블 추가1" "/admin/table.html?action=add&tid=${T1}"
req "테이블 중복 추가" "/admin/table.html?action=add&tid=${T1}"
req "없는 테이블 삭제" "/admin/table.html?action=del&tid=NO_SUCH_TABLE"
req "결제 안 된 테이블 삭제" "/admin/table.html?action=del&tid=${T1}"
req "테이블 추가2" "/admin/table.html?action=add&tid=${T2}"
req "테이블 조회" "/admin/table.html?action=stat"

echo "### 고객 주문 테스트 ###"

req "주문 추가 정상" "/customer/order.html?action=add&tid=${T1}&menu=${M1}&num=2"
req "없는 메뉴 주문" "/customer/order.html?action=add&tid=${T1}&menu=NO_SUCH_MENU&num=1"
req "없는 테이블 주문" "/customer/order.html?action=add&tid=NO_SUCH_TABLE&menu=${M1}&num=1"
req "주문 상태 조회" "/customer/order.html?action=stat&tid=${T1}"
req "주문 삭제1" "/customer/order.html?action=del&tid=${T1}&menu=${M1}&num=1"
req "없는 메뉴 삭제" "/customer/order.html?action=del&tid=${T1}&menu=NO_SUCH_MENU&num=1"
req "없는 테이블 삭제" "/customer/order.html?action=del&tid=NO_SUCH_TABLE&menu=${M1}&num=1"
req "주문 확정" "/customer/order.html?action=finish&tid=${T1}"
req "확정 후 상태 조회" "/customer/order.html?action=stat&tid=${T1}"

echo "### 관리자 status/checkout 테스트 ###"

req "전체 현황 조회" "/admin/status.html"
req "없는 테이블 checkout" "/admin/checkout.html?tid=NO_SUCH_TABLE"
req "T2 주문 추가" "/customer/order.html?action=add&tid=${T2}&menu=${M2}&num=1"
req "T2 checkout" "/admin/checkout.html?tid=${T2}"
req "checkout 후 전체 현황" "/admin/status.html"

echo "### 성능 테스트(ab) ###"

if command -v ab >/dev/null 2>&1; then
    ab -n 200 -c 20 "${BASE_URL}/customer/order.html?action=stat&tid=${T1}"
    ab -n 200 -c 20 "${BASE_URL}/admin/status.html"
    ab -n 200 -c 20 "${BASE_URL}/admin/table.html?action=stat"
else
    echo "ab 명령어가 설치되어 있지 않습니다."
fi

echo "### abtest.sh 완료 ###"