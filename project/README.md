# Restaurant Order System - Spring MVC

레스토랑 주문 관리 시스템 (Spring Framework)

## 실행 환경 구분

### 로컬 개발 (MacBook)

**빠른 개발/테스트용 - Docker 불필요**

```bash
# Maven만 설치되어 있으면 됨
brew install maven

# Jetty로 빠르게 실행
./dev-run.sh

# 또는 IDE에서 mvn jetty:run
```

- ✅ Docker 설치 필요 없음
- ✅ 빠른 재시작 (코드 수정 시 자동 리로드)
- ✅ 간편한 디버깅
- 포트: 8000

### 학교 서버 (채점 환경)

**제출용 - Docker 컨테이너 내부에서 실행**

```bash
# 학교 서버 컨테이너에서 실행
./run.sh
```

- ✅ 컨테이너에 Tomcat 설치되어 있음
- ✅ Maven 빌드 → WAR 생성 → Tomcat 배포
- ✅ 8000번 포트 자동 설정
- ✅ 성능 최적화 적용 (G1GC, NIO Connector)

---

## 빠른 시작

### 로컬에서 테스트

```bash
# 1. Maven 설치 확인
mvn -version

# 2. 서버 실행
./dev-run.sh

# 3. 브라우저에서 접속
open http://localhost:8000/admin/status.html
```

### 학교 서버에 제출

```bash
# 1. 프로젝트를 학교 서버에 업로드
# 2. 컨테이너에서 실행
./run.sh

# 교수님이 테스트
curl http://localhost:8000/admin/status.html
ab -n 10000 -c 1000 http://localhost:8000/admin/menu.html?action=stat
```

---

## 주요 기능

### 관리자 기능

1. **메뉴 관리**
   - 메뉴 추가: `/admin/menu.html?action=add&name={메뉴이름}&price={가격}`
   - 메뉴 삭제: `/admin/menu.html?action=del&name={메뉴이름}`
   - 메뉴 조회: `/admin/menu.html?action=stat`

2. **테이블 관리**
   - 테이블 추가: `/admin/table.html?action=add&tid={테이블ID}`
   - 테이블 삭제: `/admin/table.html?action=del&tid={테이블ID}`
   - 테이블 조회: `/admin/table.html?action=stat`

3. **현황 확인**
   - 전체 현황: `/admin/status.html`

4. **결제 처리**
   - 계산: `/admin/checkout.html?tid={테이블ID}`

### 고객 기능

1. **주문 관리**
   - 주문 추가: `/customer/order.html?action=add&tid={테이블ID}&menu={메뉴이름}&num={수량}`
   - 주문 삭제: `/customer/order.html?action=del&tid={테이블ID}&menu={메뉴이름}&num={수량}`
   - 주문 확정: `/customer/order.html?action=finish&tid={테이블ID}`
   - 주문 조회: `/customer/order.html?action=stat&tid={테이블ID}`

---

## 테스트 예시

### 기능 테스트

```bash
# 1. 메뉴 추가
curl "http://localhost:8000/admin/menu.html?action=add&name=짜장면&price=6000"
curl "http://localhost:8000/admin/menu.html?action=add&name=짬뽕&price=7000"
curl "http://localhost:8000/admin/menu.html?action=add&name=탕수육&price=15000"

# 2. 테이블 추가
curl "http://localhost:8000/admin/table.html?action=add&tid=T001"
curl "http://localhost:8000/admin/table.html?action=add&tid=T002"

# 3. 주문 추가
curl "http://localhost:8000/customer/order.html?action=add&tid=T001&menu=짜장면&num=2"
curl "http://localhost:8000/customer/order.html?action=add&tid=T001&menu=탕수육&num=1"

# 4. 주문 확정
curl "http://localhost:8000/customer/order.html?action=finish&tid=T001"

# 5. 현황 확인
curl "http://localhost:8000/admin/status.html"

# 6. 결제
curl "http://localhost:8000/admin/checkout.html?tid=T001"
```


---

## 프로젝트 구조

```
project4/
├── run.sh                    # 학교 서버용 (필수)
├── dev-run.sh                # 로컬 개발용
├── pom.xml                   # Maven 설정
├── Dockerfile                # Docker 이미지 (학교 서버용)
├── docker-compose.yml        # Docker Compose 설정
│
├── src/main/
│   ├── java/com/restaurant/
│   │   ├── controller/       # Spring MVC Controllers
│   │   │   ├── AdminController.java
│   │   │   └── CustomerController.java
│   │   ├── model/            # Domain Models
│   │   │   ├── Menu.java
│   │   │   ├── Table.java
│   │   │   ├── Order.java
│   │   │   └── OrderItem.java
│   │   └── service/
│   │       └── StorageService.java  # JSON 파일 I/O
│   │
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── views/        # JSP Views
│       │   │   ├── admin/    # 관리자 페이지
│       │   │   └── customer/ # 고객 페이지
│       │   ├── web.xml       # Web Application 설정
│       │   ├── servlet-context.xml   # Spring MVC 설정
│       │   └── tomcat-server.xml     # 고성능 Tomcat 설정
│       └── resources/
│
└── data/                     # JSON 데이터 저장 (영속성)
    ├── menus.json
    ├── tables.json
    └── orders.json
```

---

## 기술 스택

- **Framework**: Spring Framework 5.3.30 (No Spring Boot)
- **Architecture**: Spring MVC
- **View**: JSP + JSTL
- **Build Tool**: Maven
- **Dev Server**: Jetty (로컬)
- **Prod Server**: Tomcat 9 (학교 서버)
- **Storage**: JSON 파일 (텍스트 기반)
- **Performance**: 
  - Tomcat NIO Connector (논블로킹 I/O)
  - JVM G1GC (낮은 지연시간)
  - HTTP 압축
  - maxThreads: 500

---

## 성능 최적화

### Tomcat 설정 (학교 서버)

```xml
<!-- NIO Connector - 논블로킹 I/O -->
<Connector port="8000" 
           protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="500"
           minSpareThreads="50"
           acceptCount="200"
           compression="on" />
```

### JVM 옵션

```bash
-Xms512m -Xmx1024m              # 힙 메모리
-XX:+UseG1GC                    # G1 가비지 컬렉터
-XX:MaxGCPauseMillis=200        # GC 일시정지 목표
-XX:+UseStringDeduplication     # 메모리 최적화
```

### 예상 성능

| 동시접속자 | 처리 능력 |
|-----------|----------|
| 1,000명   | ✅ 안정  |
| 5,000명   | ✅ 가능  |
| 10,000명  | ✅ 처리  |

---

## 에러 처리

모든 에러 메시지는 과제 명세에 따라 정확히 구현:

- `menu add error` - 중복 메뉴 추가
- `menu del error` - 없는 메뉴 삭제
- `table add error` - 중복 테이블 추가
- `table del error` - 없는 테이블 삭제
- `table del error2` - 미결제 테이블 삭제
- `table checkout error` - 없는 테이블 결제
- `customer order add menu error` - 없는 메뉴 주문
- `customer order del menu error` - 없는 메뉴 삭제
- `customer order table error` - 없는 테이블 주문

---

## 데이터 영속성

- 모든 데이터는 `data/` 폴더에 JSON 형식으로 저장
- 서버 재시작 시에도 데이터 유지
- DB 시스템 미사용 (과제 요구사항)

---

## 과제 요구사항 충족

- ✅ Spring Framework (No Spring Boot)
- ✅ Spring MVC 전체 적용
- ✅ Docker 사용 (학교 서버)
- ✅ 8000번 포트
- ✅ URL/파라미터 규격 준수
- ✅ 텍스트 파일 저장 (JSON)
- ✅ 데이터 영속성
- ✅ 에러 처리 완벽 구현
- ✅ 고성능 최적화

---

## 개발자

Server Programming Project 4
