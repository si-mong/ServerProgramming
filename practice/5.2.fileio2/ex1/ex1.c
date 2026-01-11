#include <stdlib.h>
#include <stdio.h>

//삼각형1: fread, fwrite 예시
int main(void){

	FILE *rfp, *wfp;
	char buf[BUFSIZ];
	int n;

	if((rfp=fopen("unix.txt","r"))==NULL){
		perror("fopen: unix.txt");
		exit(1);
	}
	if((wfp=fopen("unix.out","a"))==NULL){
		perror("fopen: unix.out");
		exit(1);
	}

	// 항목크기가 char크기의 2배, 이걸 3개씩 읽는다
	// 즉 2*3=6	바이트씩 읽어서 출력
	// n에 리턴해주는 값은 성공적으로 읽어온 데이터 항목의 개수
	while((n=fread(buf,sizeof(char)*2,3,rfp))>0){
		fwrite(buf,sizeof(char)*2,n,wfp);
	}

	fclose(rfp);
	fclose(wfp);
	return 0;
}
