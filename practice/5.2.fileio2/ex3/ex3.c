#include <stdio.h>
#include <stdlib.h>

// 구조체 정의
typedef struct {
	int id;
	char name[32];
	int age;
} person;

int main(){
	// 예제 데이터 준비
	FILE *rfp,*wfp;
	const int NUM_PEOPLE = 1000; 
	person buf;

	if((wfp=fopen("student.bin","ab"))==NULL){
		perror("fopen");
		exit(1);
	}

	// 1000명 학생의 메모리 할당	
	person *people = malloc(sizeof(person) * NUM_PEOPLE);

	if (!people) {
		perror("malloc");
		return 1;
	}
	// 학생 데이터 초기화
	for (int i = 0; i < NUM_PEOPLE; i++) {
		people[i].id = i + 1;
		snprintf(people[i].name, sizeof(people[i].name), "person_%d", i + 1);
		people[i].age = 20 + (i % 50);
		
		// 데이터 초기화할 때마다 파일에 저장한다.
		fwrite(&people[i],sizeof(person),1,wfp);	
	}
	fclose(wfp);

	if((rfp=fopen("student.bin", "rb"))==NULL){
		perror("fopen");
		exit(1);
	}

	// 학생 정보 다 저장했으면 읽어서 출력
	for(int i =0; i<NUM_PEOPLE;i++){
		fread(&buf,sizeof(buf),1,rfp);		
		printf("%d, %s, %d\n",buf.id, buf.name, buf.age);
	}
	fclose(rfp);
	free(people);
	return 0;	
}
