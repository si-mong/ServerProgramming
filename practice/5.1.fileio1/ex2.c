#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

// 삼각형2: 파일 오프셋 사용하기
int main(void) {

	int fd, n;

	off_t start, cur;
	char buf[256];
	
	// 읽기용으로 지정
	fd = open("unix.txt", O_RDONLY);

	if (fd ==-1) {
		perror("Open unix.txt");
		exit(1);
	}
	
	// start: 파일의 시작 위치 -> 아직 읽어오기 전이어서 시작위치임
	start = lseek(fd, 0, SEEK_CUR);

	// 255바이트 까지 읽어서 buf에 저장
	// 실제로 읽어온 바이트 개수를 리턴한다.
	n = read(fd, buf, 255);
	buf[n] = '\0';
	
	// start는 0이고 n은 현재까지 읽어온 바이트
	printf("Offset start=%d, Read Str=%s, n=%d\n", (int)start, buf, n);
	
	// cur:  현재 위치 (바이트 기준)-> 끝까지 읽었으니까 n과 동일함
	cur = lseek(fd, 0, SEEK_CUR);
	printf("Offset cur=%d\n", (int)cur);
	
	// start 갱신 파일의 시작위치로부터 5바이트 떨어진 곳에서 시작
	start = lseek(fd, 5, SEEK_SET);
	n =read(fd, buf, 255);
	buf[n]='\0';
	
	printf("Offset start = %d, Read Str=%s", (int)start, buf);

	close(fd);

	return 0;
}
