#include <stdio.h>
#include <stdlib.h>
#include <ezlists.h>

int main() {
	printf("\n");

	Ezlist start = ezlnew();

	for(int i=0; i<10; i++) {
		ezlpush(start, i);
		printf("%d\n", ezlgetl(start));
	}

	printf("\n");
	return 0;
}
