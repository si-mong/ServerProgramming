# 💻 High-Level File I/O in Unix using Standard I/O Library

### 📖 Overview  
---
**What is High-Level File I/O?**  
High-level file I/O in Unix uses the standard I/O library (`stdio.h`) and operates on  
file pointers (`FILE *`), providing convenient and structured functions for file input and output.

<br/>

### 📘 Course Content  
---
The following topics were covered in Week 6.

(1) **File Pointers and Standard I/O**
- Concept of file pointers (`FILE *`)
- Differences between file descriptors and file pointers

(2) **Opening and Closing Files**
- Opening files using `fopen()` with various modes
- Closing files using `fclose()`

(3) **Character and String-Based I/O**
- Character-based I/O functions (`fgetc`, `fputc`)
- String-based I/O functions (`fgets`, `fputs`)

(4) **Buffered and Formatted I/O**
- Buffered I/O using `fread()` and `fwrite()`
- Formatted I/O using `scanf`, `printf`, `fscanf`, and `fprintf`

(5) **File Offset Control**
- Managing file offsets using `fseek()`, `ftell()`, and `rewind()`

(6) **Conversion Between File Descriptors and File Pointers**
- Converting file descriptors to file pointers using `fdopen()`
- Converting file pointers to file descriptors using `fileno()`

<br/>

### 📘 Example Descriptions  
---
(Example descriptions will be added later)

<br/>

### 📖 개요  
---
**고수준 파일 입출력이란?**  
고수준 파일 입출력은 표준 입출력 라이브러리(`stdio.h`)를 기반으로 하며,  
파일 포인터(`FILE *`)를 사용해 보다 편리하고 구조적인 방식으로 파일을 처리한다.

<br/>

### 📘 수업 내용  
---
6주차에서 수행한 내용은 다음과 같습니다.

(1) **파일 포인터 개념 이해**
- `FILE *` 자료형과 파일 포인터의 역할
- 파일 기술자와 파일 포인터의 차이점

(2) **파일 열기와 닫기**
- `fopen()`을 이용한 파일 열기
- `fclose()`를 이용한 파일 닫기

(3) **문자 및 문자열 기반 입출력**
- 문자 단위 입출력 함수 (`fgetc`, `fputc`)
- 문자열 단위 입출력 함수 (`fgets`, `fputs`)

(4) **버퍼 및 형식 기반 입출력**
- `fread()`, `fwrite()`를 이용한 버퍼 기반 입출력
- `scanf`, `printf`, `fscanf`, `fprintf`를 이용한 형식 기반 입출력

(5) **파일 오프셋 제어**
- `fseek()`, `ftell()`, `rewind()`를 이용한 파일 위치 제어

(6) **저수준·고수준 입출력 간 변환**
- `fdopen()`과 `fileno()`를 이용한 입출력 방식 변환

<br/>

### 📘 예제별 내용  
---
(예제별 내용은 추후 작성)