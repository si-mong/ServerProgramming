#!/bin/bash

# Restaurant Order System - API Test Script
# 기능 테스트를 위한 샘플 스크립트

BASE_URL="http://localhost:8000"

echo "============================================"
echo "Restaurant Order System - API Test"
echo "============================================"
echo ""

echo "📋 [관리자 기능 테스트]"
echo ""

# 1. 메뉴 추가
echo "1. 메뉴 추가 테스트..."
curl -s "${BASE_URL}/admin/menu.html?action=add&name=짜장면&price=6000"
echo ""
curl -s "${BASE_URL}/admin/menu.html?action=add&name=짬뽕&price=7000"
echo ""
curl -s "${BASE_URL}/admin/menu.html?action=add&name=탕수육&price=15000"
echo ""
echo "✅ 메뉴 추가 완료"
echo ""

# 2. 메뉴 현황
echo "2. 메뉴 현황 조회..."
curl -s "${BASE_URL}/admin/menu.html?action=stat" | grep -o "짜장면\|짬뽕\|탕수육" | head -3
echo "✅ 메뉴 조회 완료"
echo ""

# 3. 테이블 추가
echo "3. 테이블 추가 테스트..."
curl -s "${BASE_URL}/admin/table.html?action=add&tid=T001"
echo ""
curl -s "${BASE_URL}/admin/table.html?action=add&tid=T002"
echo ""
curl -s "${BASE_URL}/admin/table.html?action=add&tid=T003"
echo ""
echo "✅ 테이블 추가 완료"
echo ""

# 4. 테이블 현황
echo "4. 테이블 현황 조회..."
curl -s "${BASE_URL}/admin/table.html?action=stat" | grep -o "T001\|T002\|T003" | head -3
echo "✅ 테이블 조회 완료"
echo ""

echo "🛒 [고객 기능 테스트]"
echo ""

# 5. 주문 추가
echo "5. 주문 추가 테스트 (T001 테이블)..."
curl -s "${BASE_URL}/customer/order.html?action=add&tid=T001&menu=짜장면&num=2"
echo ""
curl -s "${BASE_URL}/customer/order.html?action=add&tid=T001&menu=탕수육&num=1"
echo ""
echo "✅ 주문 추가 완료"
echo ""

# 6. 주문 현황
echo "6. 주문 현황 조회 (T001 테이블)..."
curl -s "${BASE_URL}/customer/order.html?action=stat&tid=T001" | grep -o "짜장면\|탕수육" | head -2
echo "✅ 주문 조회 완료"
echo ""

# 7. 주문 확정
echo "7. 주문 확정 (T001 테이블)..."
curl -s "${BASE_URL}/customer/order.html?action=finish&tid=T001"
echo ""
echo "✅ 주문 확정 완료"
echo ""

# 8. 전체 현황
echo "8. 전체 현황 조회..."
curl -s "${BASE_URL}/admin/status.html" > /dev/null
echo "✅ 전체 현황 조회 완료"
echo ""

# 9. 결제
echo "9. 결제 테스트 (T001 테이블)..."
curl -s "${BASE_URL}/admin/checkout.html?tid=T001"
echo ""
echo "✅ 결제 완료"
echo ""

echo "============================================"
echo "❌ [에러 케이스 테스트]"
echo "============================================"
echo ""

# 중복 메뉴 추가 에러
echo "1. 중복 메뉴 추가 에러..."
curl -s "${BASE_URL}/admin/menu.html?action=add&name=짜장면&price=6000"
echo ""

# 없는 메뉴 삭제 에러
echo "2. 없는 메뉴 삭제 에러..."
curl -s "${BASE_URL}/admin/menu.html?action=del&name=존재하지않는메뉴"
echo ""

# 없는 메뉴 주문 에러
echo "3. 없는 메뉴 주문 에러..."
curl -s "${BASE_URL}/customer/order.html?action=add&tid=T001&menu=존재하지않는메뉴&num=1"
echo ""

# 없는 테이블 주문 에러
echo "4. 없는 테이블 주문 에러..."
curl -s "${BASE_URL}/customer/order.html?action=add&tid=T999&menu=짜장면&num=1"
echo ""

echo ""
echo "============================================"
echo "✅ 테스트 완료!"
echo "============================================"
echo ""
echo "웹 브라우저로 확인:"
echo "  - 전체 현황: ${BASE_URL}/admin/status.html"
echo "  - 메뉴 현황: ${BASE_URL}/admin/menu.html?action=stat"
echo "  - 테이블 현황: ${BASE_URL}/admin/table.html?action=stat"
echo ""

