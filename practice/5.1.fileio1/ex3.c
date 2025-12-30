#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>	// 파일 권한 모드
#include <fcntl.h>	// open(), O_WRONRY 같은 거


// 삼각형3: 바이너리 파일에 쓰기
int main(){

	int fd;
	const char *filename = "array.bin";

	const int NUM_DATA = 500;
	int *numbers = malloc(sizeof(int)*NUM_DATA);

	if(!numbers){
		perror("malloc");
		return 1;
	}

	// 배열에 숫자 채워넣기
	for(int i =0;i<NUM_DATA; i++){
		numbers[i] = i*10;
	}

	// 바이너리 파일명으로 파일 만들기
	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);

	if(fd==-1){
		perror("open for write");
		free(numbers);
		return 1;
	}

	ssize_t written = write(fd, numbers, sizeof(int)*NUM_DATA);
	
	
	if(written == -1){	//쓰기 실패시 에러처리
		perror("write");
		close(fd);
		free(numbers);
		return 1;
	
	}
	close(fd);
	printf("배열 %d개 저장완료 (%zd 바이트)\n", NUM_DATA, written);

	return 0;

}