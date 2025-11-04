
// Ex1: gcc 사용법을 익혀봅시다.
// main.c 에서는 printgugu 함수를 call
// gugu.c 에서는 printgugu를 구현하여 99단을 출력
// Compile: gcc -o gugu.out main.c gugu.c

void printgugu();
int main(){
	printgugu();
	return 0;
}

