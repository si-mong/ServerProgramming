#include<stdio.h>
void printgugu();
void printgugu(){
	int result = 0;

	for(int i=0; i<10;i++)
	{
		for(int j =0;j<10;j++){
			result = i * j;
			printf("%d X %d = %d\n",i,j,result);
		}
	}
}

