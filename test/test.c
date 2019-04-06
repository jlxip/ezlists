#include <stdio.h>
#include <stdlib.h>
#include <ezlists.h>

int main() {
	printf("\n");

	Ezlist test1 = ezlnew();
	for(int i=0; i<10; i++) {
		ezlpush(test1, i);
		printf("%d ", ezlgetl(test1));
	}
	printf("\n");
	printf("Size: %d\n\n", ezlgetsize(test1));


	Ezlist test2 = ezlnew();
	for(int i=0; i<10; i++) {
		ezladdb(test2, i);
		printf("%d ", ezlgetf(test2));
	}
	printf("\n");

	ezladd(test1, -1, 0);	// Should do absolutely nothing
	ezladd(test1, 123, 0);	// The same
	ezladd(test1, 1, 0);
	for(int i=0; i<ezlgetsize(test1); i++) printf("%d ", ezlget(test1, i));
	printf("\n\n\n");


	printf("All tests finished.\n\n");
	return 0;
}
