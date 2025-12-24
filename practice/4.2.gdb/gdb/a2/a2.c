#include <stdio.h>
 void main()
 {
	// 리터럴 문자열은 수정 불가능
	// 좀 더 정확하게는
	// 포인터로 문자열 저장시 포인터에 대한 공간만 할당하게 되고
	// 포인터로 리터럴 문자열을 저장(할당)하게 되면, read-only 만 가능함 
 	// Program received signal SIGSEGV, Segmentation fault.
	// main () at a2.c:13
	// 13		temp[0]='F';
	// (gdb) bt
	// #0  main () at a2.c:13

	
	// char *temp= "Paras";
	
 	char temp[10]="Paras";
	int i;
 	i=0;
	temp[0]='F';
	for (i=0 ; i < 5 ; i++ )
 		printf("%c\n", temp[i]);
 }

