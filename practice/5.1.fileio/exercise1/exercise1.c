#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

// Exercise(1): 파일명을 인자로 받아서 읽고 쓰기
// 프로그램 실행시 인자가 2개라는 조건의 파일 복사 프로그램
int main(int argc, char *argv[]){
	int rfd, wfd, n;
	char buf[20];
	
	// 첫 번째 명령행 인자는 읽어올 원본 파일
	rfd = open(argv[1], O_RDONLY);
	if(rfd==-1){
		perror("open fail");
		exit(1);
	}

	// 두 번째 명령행 인자는 복사할 새로운 파일
	wfd = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
	if(wfd == -1){
		perror("file error");
		exit(1);
	}
  
	while((n=read(rfd,buf,6))>0)
		if(write(wfd,buf,n)!=n)
			perror("Write");

	if(n==-1)
		perror("Read");

	close(rfd);
	close(wfd);

	return 0;
}  
