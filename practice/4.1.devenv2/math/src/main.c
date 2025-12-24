 #include <stdio.h>
 #include "mathops.h"
 int main() {
	 int x, y;
	 printf("두 정수를 입력하세요: ");
	 scanf("%d %d", &x, &y);
	 printf("%d + %d = %d\n", x, y, add(x, y));
	 printf("%d -%d = %d\n", x, y, subtract(x, y));
	 printf("%d * %d = %d\n", x, y, multiply(x, y));
	 printf("%d / %d = %.2f\n", x, y, divide(x, y));
	 return 0;
 }


