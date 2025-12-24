# 💻 Practice: Makefile


### 📖 Overview
---
### (1) Learning Make
**Make** is a build automation tool used to manage and maintain groups of programs.
* **Purpose:** When a file is modified, Make detects the change and rebuilds only the files related to that modification.
* **Makefile Components:** A Makefile consists of three main components:
    * **Target:** The file to be generated (e.g., executable or object file).
    * **Dependency:** The files required to create the target.
    * **Command:** The shell command to execute (must be preceded by a **Tab**).


### (2) Writing a Makefile
* Programs are divided into multiple source files (e.g., `main.c`, `gugu.c`).
* Multiple source files are compiled and linked using a Makefile.
* **Basic Makefile syntax:**
    ```makefile
    target: dependency
    [tab] command
    ```

### (3) Writing a buildable Makefile
* Practice writing Makefiles that can successfully build projects with various directory structures.
<br/>


### 📖 개요
---
3주차에서 수행한 내용은 다음과 같습니다.   
(1) **Make 배우기**
- Make란? 프로그램들의 그룹들을 유지시키기 위한 도구
- 목적: 어떤 파일이 수정되더라도, 그걸 감지하고 수정된 것과 관련된 파일들을 업데이트 시켜준다.
- 3가지 구성 요소: target, dependency, command
 
(2) **makefile 작성 방식**
- 프로그램을 여러 소스 파일로 분리 
- `makefile`로 다중 파일을 컴파일하고 링크  
- 기본 작성 형식:
  ```bash
  target: dependency
  [tab] command
  ```
 
(3) **build 가능한 Makefile 작성**
- 파일구조가 다양할 때 makefile 작성해보기

<br/>

### 📘 Example Descriptions
---
The details of each example are as follows:  

- **math**  
  - A Math program that takes two integers as input and performs addition, subtraction, multiplication, and division.
  - A buildable Makefile is provided for this program.v
  - Directory Structure:
    ```
    math/ 
    ├── include/
    │   └── mathops.h
    ├── src/
    │   ├── main.c
    │   └── mathops.c
    └── Makefile
    ```
- **stu**  
  - A program that takes student names and scores as input, then calculates and outputs the average score.  
  - A buildable Makefile is provided for this program. 
  - Directory Structure: 
    ```
    stu/ 
    ├── include/
    │   └── student.h
    ├── src/
    │   ├── main.c
    │   └── student.c
    └── Makefile
    ```
    
<br/>

### 📘 예제별 내용
---
각 예제에 대한 내용은 다음과 같습니다.  
- **math**  
  - 두 정수를 입력받아 덧셈, 뺄셈, 곱셈, 나눗셈을 수행하는 Math 프로그램.
  - 이에 대해 build 가능한 `Makefile` 작성할 것.
  - 파일 구조는 다음과 같다:
    ```
    math/ 
    ├── include/
    │   └── mathops.h
    ├── src/
    │   ├── main.c
    │   └── mathops.c
    └── Makefile
    ```
- **stu**  
  - 학생 이름과 점수를 입력받아 평균 점수를 계산하고 출력하는 프로그램.  
  - 이에 대해 build 가능한 `Makefile` 작성할 것.
  - 파일 구조는 다음과 같다:
    ```
    stu/ 
    ├── include/
    │   └── student.h
    ├── src/
    │   ├── main.c
    │   └── student.c
    └── Makefile
    ```
