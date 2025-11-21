#!/bin/bash

# === Configuration ===
PORT=8000
BASE="http://localhost:${PORT}"

N=1000   # 총 요청 수
C=50     # 동시 접속 수

echo "==============================="
echo " Full Order System Benchmark "
echo " N=$N, C=$C"
echo "==============================="


# ---------------------------
# 0) 초기 세팅
# ---------------------------
echo "[SETUP] 메뉴 / 테이블 기본 세팅"

curl -s "${BASE}/admin/menu.html?action=add&name=ramen&price=7000"  >/dev/null || true
curl -s "${BASE}/admin/menu.html?action=add&name=donkatsu&price=9000" >/dev/null || true
curl -s "${BASE}/admin/menu.html?action=add&name=kimchi&price=6000" >/dev/null || true

curl -s "${BASE}/admin/table.html?action=add&tid=T001" >/dev/null || true
curl -s "${BASE}/admin/table.html?action=add&tid=T002" >/dev/null || true


# ---------------------------
# 1) 메뉴 기능 테스트
# ---------------------------
echo
echo "=== [1] 메뉴 추가 성능 ==="
ab -n $N -c $C "${BASE}/admin/menu.html?action=add&name=testmenu&price=5000"

echo
echo "=== [2] 메뉴 삭제 성능 ==="
ab -n $N -c $C "${BASE}/admin/menu.html?action=del&name=testmenu"

echo
echo "=== [3] 메뉴 stat ==="
ab -n $N -c $C "${BASE}/admin/menu.html?action=stat"


# ---------------------------
# 2) 테이블 기능 테스트
# ---------------------------
echo
echo "=== [4] 테이블 stat ==="
ab -n $N -c $C "${BASE}/admin/table.html?action=stat"

echo
echo "=== [5] 테이블 삭제 테스트 ==="
ab -n $N -c $C "${BASE}/admin/table.html?action=del&tid=T002"


# ---------------------------
# 3) 고객 주문 기능 테스트
# ---------------------------
echo
echo "=== [6] 주문 추가(add) 테스트 ==="
ab -n $N -c $C "${BASE}/customer/order.html?action=add&tid=T001&menu=ramen&num=1"

echo
echo "=== [7] 주문 삭제(del) 테스트 ==="
ab -n $N -c $C "${BASE}/customer/order.html?action=del&tid=T001&menu=ramen&num=1"

echo
echo "=== [8] 주문 완료(finish) 성능 ==="
ab -n $N -c $C "${BASE}/customer/order.html?action=finish&tid=T001"

echo
echo "=== [9] 주문 stat 성능 ==="
ab -n $N -c $C "${BASE}/customer/order.html?action=stat&tid=T001"


# ---------------------------
# 4) 관리자 전체 현황
# ---------------------------
echo
echo "=== [10] admin status ==="
ab -n $N -c $C "${BASE}/admin/status.html"

echo
echo "==============================="
echo " 모든 테스트 완료 "
echo "==============================="