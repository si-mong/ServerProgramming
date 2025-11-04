#include <stdio.h>

void calculate(int n);

void calculate(int n){

	int i =0;
	int sum = 0;
	int result = 0;

	for(i=0;i<n;i++){
		result =  i*i;
		sum = sum + result;
	}
	printf("%d\n",result);

}

