# 💻 Practice: Vi Editor & Compile Multi-File C Program using `gcc`


### 📖 Overview
The following activities were completed in **Week 2**.  
(1) **Learning Vi Editor**  
- Write C programs using the `vi` editor  


(2) **Learning gcc Compilation**  
- Compile and link multiple C files using `gcc`  
- Separate program logic into multiple source files (e.g., `main.c`, `gugu.c`)  

(3) **Additional Task: Understanding Command-Line Arguments & Options**  
- Implement a program that performs different functions based on provided options  
- Pass arguments and process them according to the selected operation  
- Example execution:  
  ```bash
  ./mycalc -a 5 8

  
### 📖 개요
2주차에서 수행한 내용은 다음과 같습니다.
(1) **Vi 기능 익히기**
- `vi` 편집기를 사용하여 C 코드 작성  
 
(2) **gcc 컴파일 익히기**
- 프로그램을 여러 소스 파일(`main.c`, `gugu.c` 등)로 분리 
- `gcc`로 다중 파일을 컴파일하고 링크  
 
(3) **추가과제: 명령행 인자 및 옵션 익히기**
- 옵션에 따라 다른 함수 수행하는 프로그램 작성
- 인자를 받아서 각 함수에 맞게 수행
- 실행예시:     
  ```bash
  ./mycalc -a 5 8

  
### 📘 Example Descriptions
The details of each example are as follows:  

- **calc**  
  - Print the 5-times multiplication table using the `vi` editor  

- **gugu**  
  - Write a program to print the full 99 multiplication table  
  - Compile two source files: `main.c` and `gugu.c`  

- **mycalc**  
  - Handle command-line arguments  
  - Handle command-line options  
  - Example execution:  
    ```bash
    ./mycalc -a 5 8
    ```

   
### 📘 예제별 내용
각 예제에 대한 내용은 다음과 같습니다.  
- **calc**  
  - `vi` 편집기를 이용하여 구구단 5단 출력  

- **gugu**  
  - 99단을 출력하는 프로그램 작성  
  - `main.c`, `gugu.c` 두 개의 소스 파일을 컴파일  

- **mycalc**  
  - 명령행 인자 처리  
  - 명령행 옵션 처리  
  - 실행 예시:  
    ```bash
    ./mycalc -a 5 8
