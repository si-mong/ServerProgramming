#!/bin/bash
# stop.sh - run.sh로 실행한 Django 서버 종료 스크립트

set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

PID_FILE="runserver.pid"

echo "[stop.sh] Stopping Django server..."

if [ ! -f "$PID_FILE" ]; then
    echo "[stop.sh] No PID file found ($PID_FILE). Server may not be running."
    exit 0
fi

PID="$(cat $PID_FILE)"

if ! kill -0 "$PID" 2>/dev/null; then
    echo "[stop.sh] PID $PID is not running. Removing stale PID file."
    rm -f "$PID_FILE"
    exit 0
fi

echo "[stop.sh] Killing process $PID ..."
kill "$PID"

sleep 1

if kill -0 "$PID" 2>/dev/null; then
    echo "[stop.sh] Force killing $PID ..."
    kill -9 "$PID"
fi

rm -f "$PID_FILE"

echo "[stop.sh] Django server stopped."