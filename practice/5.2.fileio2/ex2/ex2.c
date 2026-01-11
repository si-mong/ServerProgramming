#include<stdio.h>
#include<stdlib.h>
#include<string.h>

// Execise(1): txt에서 4의 배수인 경우 찾아서 bin파일로 저장
int main(int argc, char* argv[]){

	FILE *rfp, *wfp;
	char buf[BUFSIZ];
	char ofile[50]="/tmp/";

	// int n=0;
	int num =0;
	int cnt =0;
	
	// 커맨드 라인 인자 개수 확인
    	if (argc < 2) {
        	fprintf(stderr, "사용법: %s <입력 파일 이름>\n", argv[0]);
        	exit(1);
    	}
	
	// 입력으로 들어오는 파일 이름을 절대경로로 붙여준다.
	// 예제 요구조건임...
	strcat(ofile,argv[1]);

	// 파일 열기
	if((rfp=fopen(ofile,"r"))==NULL){
		perror("fopen fail");
		exit(1);
	}
	if((wfp=fopen("four.bin","ab"))==NULL){
		perror("fopen fail");
		exit(1);
	}
	
	// 파일 전체 읽기
	while(fgets(buf,sizeof(buf),rfp)!=NULL){
	
		// 정수로 변환해서 4의 배수인지 확인
		num=atoi(buf);
	
		if(num%4==0){
			// 4의 배수만 파일에 write
			fwrite(&num, sizeof(int), 1, wfp);
			cnt++;
		}
	}
	printf("%d\n", cnt);
	fclose(rfp);
	fclose(wfp);

	return 0;

}
