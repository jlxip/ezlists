#include <stdio.h>
#include <stdlib.h>
#include <ezlists.h>

int main() {
	printf("\n");

	// Create a new list, push an element and print it.
	printf("TEST NO. 1\n");
	printf("Theoretical:\t0 1 2 3 4 5 6 7 8 9 \n");
	printf("Experimental:\t");
	Ezlist test1 = ezlnew();
	for(int i=0; i<10; i++) {
		ezlpush(test1, i);
		printf("%d ", ezlgetl(test1));
	}
	printf("\n\n");

	// Create a new list, add an element at the beginning and print it.
	printf("TEST NO. 2\n");
	printf("Theoretical:\t0 1 2 3 4 5 6 7 8 9 \n");
	printf("Experimental:\t");
	Ezlist test2 = ezlnew();
	for(int i=0; i<10; i++) {
		ezladdb(test2, i);
		printf("%d ", ezlgetf(test2));
	}
	ezlwipeall(test2);
	printf("\n\n");

	// Add a zero at position 2 to the first list and print all the elements.
	printf("TEST NO. 3\n");
	printf("Theoretical:\t0 1 0 2 3 4 5 6 7 8 9 \n");
	printf("Experimental:\t");
	ezladd(test1, -1, 0);	// Should do absolutely nothing
	ezladd(test1, 123, 0);	// The same
	ezladd(test1, 2, 0);
	for(int i=0; i<ezlgetsize(test1); i++) printf("%d ", ezlget(test1, i));
	printf("\n\n");

	// Remove the element recently added and print the list.
	printf("TEST NO. 4\n");
	printf("Theoretical:\t1 2 3 4 5 6 7 8 \n");
	printf("Experimental:\t");
	ezlwipef(test1);
	ezlwipe(test1, 1);
	ezlwipel(test1);
	for(int i=0; i<ezlgetsize(test1); i++) printf("%d ", ezlget(test1, i));
	printf("\n\n");

	printf("\nAll tests finished.\n\n");
	return 0;
}
