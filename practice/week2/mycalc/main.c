#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void add_num(int, int);
void sub_num(int, int);
void div_num(int, int);
void mul_num(int, int);

// additional exercise:
// 덧셈, 뺄셈, 곱셈, 나눗셈 기능 구현
// Command argument option 처리하기!!
int main(int argc, char *argv[]){

	char opt;
	char opt_sw;
	int num1, num2;
	int opt_cnt = 0;

	while((opt = getopt(argc, argv, "asmd")) != -1){
	
		num1 = atoi(argv[optind]);
		num2 = atoi(argv[optind+1]);
		
		// while문을 탈출하는 경우는 옵션 2개 입력했을 때 또는
		// opt에 -1값이 할당되었을 때임
		// 이럴 경우에 switch문에서 제대로 된 옵션 문자를 사용할 수 없으므로 변수를 하나더 사용하기로 함.
		opt_sw = opt;
		opt_cnt++;
		if(opt_cnt > 1){
			printf("You can't use more than 2 option\n\n.");
			return 0;
		}

	}
	// 원래 while 안에 switch문을 작성했으나 옵션 두 개 입력했을때, 두 옵션을 모두 실행해버림
	// 따라서 옵션 두 개 입력했을 때는 실행조차 안되게 검사 먼저하고 switch 문 실행되게 했음
	switch(opt_sw){
		case 'a':
			add_num(num1, num2);
			break;
		case 's':
			sub_num(num1, num2);
			break;	
		case 'd':
			div_num(num1, num2);
			break;
		case 'm':
			mul_num(num1, num2);
			break;	
		default:
			printf("It is not available option.\n\n");
			return 0;
	}
	return 0;
}
