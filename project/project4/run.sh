#!/bin/bash
# 학교 서버 컨테이너용 실행 스크립트
# 이 스크립트는 학교 서버의 Docker 컨테이너 내부에서 실행됩니다.

set -e

echo "============================================"
echo "Restaurant Order System - Spring MVC"
echo "채점 환경 실행 스크립트"
echo "============================================"

# 프로젝트 루트 디렉토리
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

echo ""
echo "[1/4] 프로젝트 위치: $BASE_DIR"

# 1. Maven 빌드
echo ""
echo "[2/4] Maven 빌드 중..."
if ! command -v mvn &> /dev/null; then
    echo "❌ ERROR: Maven이 설치되어 있지 않습니다."
    exit 1
fi

mvn clean package -q
if [ $? -ne 0 ]; then
    echo "❌ ERROR: Maven 빌드 실패"
    exit 1
fi

WAR_FILE="$BASE_DIR/target/restaurant.war"
if [ ! -f "$WAR_FILE" ]; then
    echo "❌ ERROR: $WAR_FILE 파일을 찾을 수 없습니다."
    exit 1
fi
echo "✅ 빌드 완료: target/restaurant.war"

# 2. 데이터 디렉토리 생성 (영속성)
mkdir -p "$BASE_DIR/data"
echo "✅ 데이터 디렉토리: $BASE_DIR/data"

# 3. CATALINA_HOME 설정
echo ""
echo "[3/4] Tomcat 환경 설정..."

# 학교 서버 컨테이너의 Tomcat 경로 자동 감지
if [ -z "$CATALINA_HOME" ]; then
    if [ -d "/usr/local/tomcat" ]; then
        export CATALINA_HOME="/usr/local/tomcat"
    elif [ -d "/usr/share/tomcat" ]; then
        export CATALINA_HOME="/usr/share/tomcat"
    elif [ -d "/usr/share/tomcat9" ]; then
        export CATALINA_HOME="/usr/share/tomcat9"
    elif [ -d "/opt/tomcat" ]; then
        export CATALINA_HOME="/opt/tomcat"
    else
        echo "❌ ERROR: Tomcat을 찾을 수 없습니다."
        echo "   CATALINA_HOME 환경변수를 설정하거나 Tomcat을 설치하세요."
        exit 1
    fi
fi

export CATALINA_BASE="$CATALINA_HOME"
echo "✅ CATALINA_HOME: $CATALINA_HOME"

# 4. WAR 파일 배포
echo ""
echo "[4/4] WAR 파일 배포 및 Tomcat 시작..."

# 기존 webapps 정리
rm -rf "$CATALINA_HOME/webapps"/*
mkdir -p "$CATALINA_HOME/webapps"

# ROOT로 배포 (context path = /)
cp "$WAR_FILE" "$CATALINA_HOME/webapps/ROOT.war"
echo "✅ WAR 배포 완료: $CATALINA_HOME/webapps/ROOT.war"

# 5. 커스텀 server.xml 적용 (성능 최적화)
CUSTOM_SERVER_XML="$BASE_DIR/src/main/webapp/WEB-INF/tomcat-server.xml"
if [ -f "$CUSTOM_SERVER_XML" ]; then
    echo "✅ 고성능 server.xml 적용"
    cp "$CUSTOM_SERVER_XML" "$CATALINA_HOME/conf/server.xml"
else
    # 기본 server.xml의 포트만 8000으로 변경
    sed -i 's/port="8080"/port="8000"/g' "$CATALINA_HOME/conf/server.xml" 2>/dev/null || true
fi

# 6. JVM 옵션 설정 (성능 최적화)
export JAVA_OPTS="-Xms512m -Xmx1024m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UseStringDeduplication -Djava.security.egd=file:/dev/./urandom"
echo "✅ JVM 옵션 설정 완료"

# 7. Tomcat 실행
echo ""
echo "============================================"
echo "🚀 Tomcat 서버 시작 (포트 8000)"
echo "============================================"
echo ""

# 포그라운드로 실행 (컨테이너가 종료되지 않도록)
exec "$CATALINA_HOME/bin/catalina.sh" run
