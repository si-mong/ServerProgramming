#!/bin/bash
# Simple run.sh - Django 프로젝트 실행 스크립트 (foreground)
set -e

# run.sh의 실제 위치로 이동
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

PYTHON=python3

echo "[run.sh] Starting..."

# 1) 가상환경 생성
if [ ! -d "venv" ]; then
    echo "[run.sh] Creating venv..."
    $PYTHON -m venv venv
fi

# 2) venv 활성화
# shellcheck disable=SC1091
source venv/bin/activate

# 3) Django 설치 (없을 때만)
$PYTHON -c "import django" 2>/dev/null || (
    echo "[run.sh] Installing Django..."
    pip install "Django==5.2.8"
)

# 4) migrate 실행 (DB 초기화)
$PYTHON manage.py migrate --noinput

echo "[run.sh] Starting Django server (foreground mode)..."

# 5) 서버를 포그라운드로 실행 (출력 그대로 표시됨)
$PYTHON manage.py runserver 0.0.0.0:8000