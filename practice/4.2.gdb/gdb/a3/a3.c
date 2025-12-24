#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 int main(int argc, char **argv)
 {
 	char *buf;

	// buf가큰 2^31만큼의 메모리를 할당받지 못함
	// 공간 할당이 되지 않으면 malloc에서 null포인터를 반환함
	// null 포인터에 문자열 복사(대입)을 시도하므로 
	// 따라서 segmentation fault 발생

 	//buf = malloc(1<<31);
 	buf = malloc(31);
	strcpy(buf, "This is Test");
 	printf("%s\n", buf);
 	return 0;
}
