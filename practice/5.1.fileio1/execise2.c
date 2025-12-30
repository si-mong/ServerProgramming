#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

// Exercise(2): 명령행 인자 여러개 받기
// 명령행 인자를 2개가 아닌 여러개 받을 수 있음
// 첫번 째 인자는 읽을 대상이고, 이후 파일명들로 모두 복사해서 생성해야함
int main(int argc, char* argv[]){

	int rfd, wfd, n;
	char buf[20];
	// char ofile[20]={0};
	// char wfile[20]={0};
	int i=0;

	rfd = open(argv[1], O_RDONLY);

	if(rfd == -1){
		perror("open fail");
		exit(1);
	}

	for(i=2;i<argc;i++){
		//strcat(wfile, argc[i]);
		wfd=open(argv[i],O_CREAT|O_WRONLY|O_TRUNC,0644);
		
		if(wfd == -1){
			perror("file error");
			exit(1);
		}
	
		while((n=read(rfd,buf,6))>0)
			if(write(wfd,buf,n)!=n)
				perror("Write");
		if(n==-1)
			perror("Read");

		lseek(rfd,0,SEEK_SET);
		close(wfd);

	}
	close(rfd);
	
	return 0;
}
