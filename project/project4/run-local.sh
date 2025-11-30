#!/bin/bash
# 로컬 개발용 실행 스크립트 (MacBook)
# Docker 불필요, Maven만 있으면 됨

echo "============================================"
echo "🏠 로컬 개발 서버 (Jetty)"
echo "============================================"

# Maven 확인
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven이 설치되어 있지 않습니다."
    echo "   설치: brew install maven"
    exit 1
fi

echo ""
echo "📊 서버 정보:"
echo "  - 포트: 8000"
echo "  - 관리자 현황: http://localhost:8000/admin/status.html"
echo "  - 메뉴 관리: http://localhost:8000/admin/menu.html?action=stat"
echo ""
echo "🛑 서버 종료: Ctrl+C"
echo ""
echo "🚀 Jetty 서버 시작 중..."
echo "============================================"
echo ""

# 데이터 디렉토리 생성
mkdir -p data

# Jetty로 실행 (빠르고 가벼움)
mvn jetty:run

