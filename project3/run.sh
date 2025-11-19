#!/bin/bash

# run.sh가 있는 디렉토리로 이동
cd "$(dirname "$0")"

# node_modules가 없으면 한 번만 설치 (성능 고려)
if [ ! -d "node_modules" ]; then
  npm install
fi

# production 모드로 서버 실행
NODE_ENV=production node app.js