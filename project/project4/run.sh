#!/bin/bash
# 학교 서버 컨테이너용 실행 스크립트 (Jetty 기반)

set -e

echo "============================================"
echo "Restaurant Order System - Spring MVC"
echo "채점 환경 실행 스크립트 (Jetty)"
echo "============================================"

# 프로젝트 루트 디렉토리
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

echo ""
echo "[1/3] 프로젝트 위치: $BASE_DIR"

# 1. Maven 확인
echo ""
echo "[2/3] Maven 빌드 및 실행 준비..."
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven이 설치되어 있지 않습니다."
    exit 1
fi

# 옵션: 빌드 한 번 돌려서 컴파일 에러 먼저 잡기
mvn clean package -q
if [ $? -ne 0 ]; then
    echo "ERROR: Maven 빌드 실패"
    exit 1
fi
echo "빌드 완료: target/restaurant.war"

# 2. 데이터 디렉토리 생성 (파일 저장용)
mkdir -p "$BASE_DIR/data"
echo "데이터 디렉토리: $BASE_DIR/data"

# 3. Jetty 서버 실행
echo ""
echo "[3/3] Jetty 서버 시작 (포트 8000)"
echo "============================================"
echo "  - URL: http://localhost:8000"
echo "  - 관리자 현황: http://localhost:8000/admin/status.html"
echo "============================================"
echo ""

# 메모리/GC 튜닝 (Jetty를 띄우는 JVM에 적용)
export MAVEN_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -Djava.security.egd=file:/dev/./urandom"

# 포그라운드 실행 (컨테이너가 살아있도록)
exec mvn jetty:run