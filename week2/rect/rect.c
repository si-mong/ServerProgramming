#include<stdio.h>

/* 03.devenv1 - Ex5: 삼각형 각변의 길이 3개를 입력 받아 
삼각형이 구성될 수 있는지 아닌지 판별하는 프로그램을 작성하시오. */

int main(){

	int rec[3] = {0};
	int a = 0;
	int b = 0;
	int result = 0;
	int max_ind = 0;

	for(int i =0;i<3;i++)
		scanf("%d",&rec[i]);

	int max = rec[0];
	
	// 삼각형 조건: 가장 긴 변은 다른 두 변의 합보다 작아야함.
	// 1. max 길이 찾기
	for(int i =1;i<3;i++){
		if(max<rec[i]){
			max = rec[i];
			max_ind = i;
		}
	}
	
	// 2.max 길이를 제외한 나머지 길이의 합을 구한다. 
	for(int i=0;i<3;i++){
	
		if(max_ind == i)
			continue;

		else{
			result = rec[i] + result;
		}
	}

	// 3. 삼각형 만족 결과 출력
	if(result > max)
		printf("삼각형을 만들 수 있습니다.\n");
	else
		printf("삼각형을 만들 수 없습니다.\n");

}
