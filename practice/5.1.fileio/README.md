# 💻 File I/O in Unix using System Calls

### 📖 Overview  
---
**What is File I/O?**  
In Unix systems, file input and output are based on file descriptors and are handled  
using low-level system calls such as `open`, `read`, `write`, and `close`, which allow direct control over files.


<br/>

### 📘 Course Content  
---
The following topics were covered in Week 5.

(1) **Understanding Low-Level File I/O**
- Concept and role of file descriptors
- Standard input (0), standard output (1), and standard error (2)

(2) **File Creation, Opening, and Closing**
- Using the `open()` system call and file open flags (`O_RDONLY`, `O_WRONLY`, `O_CREAT`, etc.)
- Setting file access permissions (mode)
- Releasing file resources with `close()`

(3) **File Reading and Writing**
- Byte-level file I/O using `read()` and `write()`
- Understanding basic file copy mechanisms

(4) **File Offset and File Management**
- Moving file offsets using `lseek()`
- Deleting files using `unlink()` and `remove()`

(5) **Binary Data I/O**
- Writing data to binary files
- Reading binary data from files
- Understanding data transfer between memory and files

<br/>

### 📘 Example Descriptions   
- **ex1: File Read & Write**   
  - Copies data from one file to another using `read()` and `write()`
  - Demonstrates basic file copy using low-level file I/O system calls

- **ex2: File Offset Handling**   
  - Reads file contents and checks the current file offset using `lseek()`
  - Demonstrates how file offsets change during read operations

- **exercise1: File Copy with Command-Line Arguments**  
  - Copies a file specified by command-line arguments
  - Takes one source file and one destination file as input

- **exercise2: File Copy with Multiple Destination Files**  
  - Copies one source file to multiple destination files
  - Demonstrates handling multiple command-line arguments and resetting file offsets

<br/>

### 📖 개요  
---
**File I/O란?**   
Unix 환경에서의 파일 입출력은 파일 기술자(file descriptor)를 기반으로 하며,  
`open`, `read`, `write`, `close` 등의 **저수준 시스템 콜**을 통해 파일을 직접 제어하는 방식이다.

<br/>

### 📘 수업 내용    
---
5주차에서 수행한 내용은 다음과 같습니다.   
(1) **저수준 파일 입출력 개념 이해**
- 파일 기술자(file descriptor)의 개념과 역할
- 표준 입력(0), 표준 출력(1), 표준 오류(2)의 의미

(2) **파일 생성 및 열기/닫기**
- `open()` 시스템 콜과 파일 열기 옵션(`O_RDONLY`, `O_WRONLY`, `O_CREAT` 등)
- 파일 접근 권한(mode) 설정
- `close()`를 이용한 파일 자원 해제

(3) **파일 읽기와 쓰기**
- `read()`와 `write()`를 이용한 바이트 단위 입출력
- 파일 복사 구조 이해

(4) **파일 오프셋 및 파일 관리**  
- `lseek()`을 이용한 파일 오프셋 이동
- `unlink()`, `remove()`를 이용한 파일 삭제

(5) **바이너리 데이터 입출력**  
- 바이너리 파일에 데이터 저장 및 읽기
- 메모리와 파일 간 데이터 처리 방식 이해

<br/>

### 📘 예제별 내용  
---
각 예제에 대한 내용은 다음과 같습니다.  
- **ex1: 파일 읽기 및 쓰기**  
  - `read()`와 `write()`를 이용하여 파일 내용을 다른 파일로 복사
  - 저수준 파일 입출력을 이용한 기본적인 파일 복사 예제

- **ex2: 파일 오프셋 처리**  
  - `lseek()`을 사용하여 파일의 현재 오프셋 위치 확인
  - 파일 읽기 과정에서 오프셋이 어떻게 변경되는지 확인

- **exercise1: 명령행 인자를 이용한 파일 복사**  
  - 명령행 인자로 전달받은 파일을 읽어 다른 파일로 복사
  - 입력 파일 1개와 출력 파일 1개를 처리하는 프로그램

- **exercise2: 여러 파일로 복사하기**  
  - 하나의 원본 파일을 여러 개의 대상 파일로 복사
  - 여러 개의 명령행 인자를 처리하고 파일 오프셋을 재설정하는 방식 이해
