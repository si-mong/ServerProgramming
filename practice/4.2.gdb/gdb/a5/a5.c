#include <stdio.h>

double fun(int i) {
	// fun 내부에는 a 배열은 두 칸만 사용하고 있는데,
	// 메인에서 반복문을 통해 인덱스 6까지 사용하고 있으므로
	// 오류가 발생하고 있음
	volatile double d[1] = {3.14};
	volatile long int a[2];
	a[i] = 1073741824; 
	return d[0];
}
int main () {
	 int i;
	 double k;

	 // for(i=0;i<6;i++)
	 // 오류 해결: 루프 범위 줄이기
	 for (i=0; i<2 ; i++)
	 {
		 k=fun(i);
		 printf("%f \n", k);
 	 }
	 return 0;
 }
