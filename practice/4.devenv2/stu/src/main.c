#include <stdio.h>
#include "student.h"

int main() {
	 Student students[MAX_STUDENTS];
	 int count = input_students(students, MAX_STUDENTS);

	 print_students(students, count);

	 double avg = average_score(students, count);
	 printf("\n평균 점수: %.2f\n", avg);

	 return 0; 
}
