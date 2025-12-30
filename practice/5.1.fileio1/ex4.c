#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>	// 파일 권한 모드
#include <fcntl.h>	// open(), O_WRONRY 같은 거

// 바이너리 파일 읽어서 쓰기
// 예제3을 진행한 후 할 것!!
int main(int argc, char *argv[]){

	if(argc < 2){
		perror("argument");
	}
	//const char *filename = "array.bin";

	int fd;
	const int NUM_DATA = 500;
	int *buffer = malloc(sizeof(int)*NUM_DATA);

	if(!buffer){
		perror("malloc");
		free(buffer);
		return 1;
	}

	// 입력받은 파일명(array.bin)으로 파일 열기
	fd = open(argv[1], O_RDONLY);
	if(fd==-1){
		perror("open for read");
		free(buffer);
		return 1;
	}

	// 읽어온 바이트 저장
	ssize_t read_bytes = read(fd, buffer, sizeof(int)*NUM_DATA);
	
	if(read_bytes == -1){	//읽기 실패시 에러처리
		perror("read");
		close(fd);
		free(buffer);
		return 1;
	
	}

	printf("배열 읽기 완료 (%zd 바이트)\n", read_bytes);

	//읽은 데이터 일부 출력(앞 10개만)
	//바이너리 파일은 바이트 단위로 읽어서 별도의 stoi같은 거 필요 없고 배열 사용도 가능:
	for(int i=0; i<10;i++){
		printf("buffer[%d] = %d\n",i,buffer[i]);
	}

	close(fd);	
	free(buffer);
	return 0;

}