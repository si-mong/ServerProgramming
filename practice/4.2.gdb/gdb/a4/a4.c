#include <stdio.h>
 int main () {
 	int x = 0;
	 int inp = 0;
	 int nums[20];
	 int idx = 0;

	 // 문자열을 입력받으면 무한루프 발생
	 // 버퍼에 문자열이 남아있으면 scanf는 입력을 받을 수 없고
	 // 0을 반환하게 됨
	 // 따라서 if(inp == 0) 때문에 무한루프 발생하게 된다.

	 // (gdb) p inp
	 // $2 = 0
	 
	 for (;;){
		 printf("Enter an integer: ");
		 inp= scanf("%d", &x);
		 if (inp == 0) {
			printf ("Error: not an integer\n");
			char c;

			// 오류 해결: 버퍼 비워주기
			while((c=getchar())!='\n' && c!=EOF){}

		 }else {

 			if (idx< 20) {
				 nums[idx] = x;
				 idx++;
 			}
			else{
				printf("complation of allocation.\n ");
				break;
			}
 		}
	 }
 	return 0;
 }
