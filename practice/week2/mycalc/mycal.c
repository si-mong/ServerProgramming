#include <stdio.h>
#include <stdlib.h>

void add_num(int a, int b){
	printf("%d + %d = %d\n", a, b, a+b); 
}
void sub_num(int a, int b){
	printf("%d - %d = %d\n", a, b, a-b); 
}
void div_num(int a, int b){
	if(b == 0){
		printf("You can't be divide anything by 0.\n");
	}
	printf("%d / %d = %d\n", a, b, a/b); 
}
void mul_num(int a, int b){
	printf("%d x %d = %d\n", a, b, a*b); 
}
