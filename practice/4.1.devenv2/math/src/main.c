 #include <stdio.h>
 #include "mathops.h"
 /*
include/mathops.h: 함수 선언(프로토타입) 제공, 컴파일러가 타입/인자 체크 가능
src/mathops.c: 그 함수들의 정의(실제 코드) 
src/main.c: main()이 있고, mathops 함수들을 호출
 */
 /*
 <처리 과정>
 1. 전처리: mathops.h 찾아서 main.c 에 붙여넣는다.
 -> Makefile에서 CFLAGS = -Wall -O -g -Iinclude # 'include'
 -> -Iinclude는 헤더 검색 경로에 include/ 폴더를 추가하라는 뜻.
 2. 컴파일: obj = src/main.o src/mathops.o
 -> 각각에는 참조 정보와 정의 심볼이 존재함
 3. 링크: .o를 하나로 묶어 "실행파일 hello" 생성
 -> $(bin): $(obj)
		$(CC) $(obj) -o $@
 -> 이 의미는 "cc src/main.o src/mathops.o -o hello" 와 같음
 */

 int main() {
	 int x, y;
	 printf("두 정수를 입력하세요: ");
	 scanf("%d %d", &x, &y);
	 printf("%d + %d = %d\n", x, y, add(x, y));
	 printf("%d -%d = %d\n", x, y, subtract(x, y));
	 printf("%d * %d = %d\n", x, y, multiply(x, y));
	 printf("%d / %d = %.2f\n", x, y, divide(x, y));
	 return 0;
 }


