 #define MAX_STUDENTS 100
 #define NAME_LEN 50
 typedef struct {
	 char name[NAME_LEN];
	 int score;
 } Student;

int input_students(Student students[], int max);
double average_score(Student students[], int count);
void print_students(Student students[], int count);

