#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

// 삼각형1: 파일 읽고 쓰기
int main(){

	int rfd, wfd, n;
	char buf[10];

	rfd = open("unix.txt", O_RDONLY);
	if(rfd == -1){
		perror("open fail:  unix.txt");
		exit(1);
	}
	// 파일 권한
	// O_TRUNC면 파일 생성시 이미 있는 파일이면 내용 지우고 길이 0으로 변경
	// 즉, 파일 생성하고 쓰기 전용으로 여는 것, 파일이 이미 존재하면 새로 만드는 느낌으로?
	wfd = open("unix2.txt",O_CREAT | O_WRONLY | O_TRUNC, 0644);
	if(wfd == -1){
		perror("Open fail: unix2.txt");
		exit(1);
	}
	// 6바이트씩 읽어온다.
	while((n=read(rfd,buf,6))>0)
		if(write(wfd, buf,n)!=n)
			perror("Write");

	if(n==-1)
		perror("Read");

	close(rfd);
	close(wfd);

	return 0;	
}
