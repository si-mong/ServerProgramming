#include <stdio.h>
#include "student.h"

int input_students(Student students[], int max){

	int num=0;
	printf("학생 수를 입력해주세요: ");
	scanf("%d", &num);
	
	if(num > MAX_STUDENTS){
		printf("100명 이상 입력받을 수 없습니다.\n");
		return 0;
	}

	for(int i=0;i<num;i++){
		printf("학생이름: ");
		scanf("%s",students[i].name);
		printf("점수: ");
		scanf("%d",&students[i].score);
	}	
	printf("\n");
	return num;
	
}
double average_score(Student students[], int count){
	int i;
	int sum=0;
	double avg=0.0;

	for(i=0;i<count;i++){
		sum+=students[i].score;
	}
	avg = (double)sum/count;

	return avg;
}
void print_students(Student students[], int count){
	int i;
	for(i=0;i<count;i++){
		printf("이름: %s, 점수: %d\n",students[i].name,students[i].score);

	}
}
