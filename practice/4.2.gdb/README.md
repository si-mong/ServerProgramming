# 💻 Practice: GNU DeBugger (GDB)

### 📖 Overview  
---
GDB? 
GDB (GNU Debugger) is a debugging tool for C/C++ programs that allows developers to
control program execution and inspect variables and memory states in order to analyze runtime errors.


### 📘 Course Content  
---
The following topics were covered in Week 4.
(1) **Learning Basic GDB Commands**
- Program execution and termination (run, kill)
- Setting and removing breakpoints (break, clear)
- Controlling execution flow (step, next, continue)

(2) **Debugging with GDB**
- Inspecting variable states and memory values
- Analyzing the causes of segmentation faults


### 📘 Example Descriptions  
---
Each example covers the following contents.
- a1: factorial
	•	Debugging a factorial calculation program
	•	Fixing errors caused by uninitialized variables
- a2: segfault_string
	•	Analyzing segmentation faults caused by modifying string literals
- a3: memory_alloc
	•	Identifying errors caused by excessive memory allocation
- a4: input_loop & buffer
	•	Debugging infinite loops and array boundary issues during input processing
- a5: array_overflow
	•	Analyzing errors caused by out-of-bounds array access


### 📖 개요
---
GDB란?
GDB(GNU Debugger) 는 C/C++ 프로그램의 실행 흐름을 제어하고, 변수·메모리 상태를 확인하여
런타임 오류를 분석할 수 있는 GNU 디버깅 도구이다.


### 📘 수업 내용  
---
4주차에서 수행한 내용은 다음과 같습니다.   
(1) **GDB 기본 사용법 익히기**
- 프로그램 실행 및 종료 (run, kill)
- 중단점 설정 및 해제 (break, clear)
- 코드 흐름 제어 (step, next, continue)

(2) **GDB를 통해 디버깅 해보기**
- 변수 상태 및 메모리 값 확인
- Segmentation Fault 발생 원인 분석



### 📘 예제별 내용  
---
각 예제에 대한 내용은 다음과 같습니다.  
- **a1: factorial**  
    - 팩토리얼 계산 프로그램 디버깅
	- 초기화되지 않은 변수로 인한 오류 
- **a2: segfault_string**  
    - 문자열 리터럴 수정 시 발생하는 Segmentation Fault 오류 분석
- **a3: mamory_alloc** 
    - 과도한 메모리 할당으로 인한 오류
- **a4: input_loop & buffer**  
    - 입력 처리 과정에서 발생하는 무한 루프 및 배열 범위 문제
- **a5: array_overflow** 
    - 배열 인덱스 초과 접근에 대한 오류
