# include <stdio.h>
void main()
{
 	int i, num, j;
 	printf("Enter the number: ");
 	scanf("%d", &num);

	// 변수 j가 초기화 되지 않음 
	// (gdb) p j
	// $2 = -44304

	i = 1;
	j = 1;

	for (i=1; i<=num; i++)
 		j=j*i;    

	printf("The factorial of %d is %d\n", num, j);
} 

