#include <stdio.h>
#include <stdlib.h>
#include <ezlists.h>

#define ANSI_WHITE   "\x1b[1;37m"
#define ANSI_RED     "\x1b[1;31m"
#define ANSI_GREEN   "\x1b[1;32m"
#define ANSI_YELLOW  "\x1b[1;33m"
#define ANSI_RESET   "\x1b[0m"

void printTest(int n) {
	printf(ANSI_WHITE "TEST %d:" ANSI_RESET "\t", n);
}
void printPassed() {
	printf(ANSI_GREEN "[PASSED]" ANSI_RESET "\n");
}
void printFailed() {
	printf(ANSI_RED "[FAILED]" ANSI_RESET "\n\n");
}

int checkState(int state) {
	switch(state) {
		case 0:
			printPassed();
			return 1;
		case 1:
			printFailed();
			printf(ANSI_RED "ERROR: sizes do not match." ANSI_RESET "\n");
			return 0;
		case 2:
			printFailed();
			printf(ANSI_RED "ERROR: contents do not match." ANSI_RESET "\n");
			return 0;
	}
}

int main() {
	printf("\n");
	printf(ANSI_YELLOW "  EZLIST TESTS" ANSI_RESET "\n");
	int state = 0;	// 0: all good.

	// TEST 1
	// Create a new list, push an element and get it in the same iteration.
	// Checks ezlnew, ezlpush, ezlgetl, ezlgetsize and ezlwipeall.
	printTest(1);
	int TT1_sz = 10;
	int TT1[TT1_sz];
	for(int i=0; i<TT1_sz; i++) TT1[i] = i;

	Ezlist test1 = ezlnew();
	for(int i=0; i<TT1_sz && state == 0; i++) {
		ezlpush(test1, i);
		if(TT1[i] != ezlgetl(test1)) state = 2;
	}
	if(TT1_sz != ezlgetsize(test1)) state = 1;
	ezlwipeall(test1);

	if(!checkState(state)) return state;

	// TEST 2
	// Create a new list, add an element at the beginning and print it.
	// Checks ezladdb and ezlgetf.
	printTest(2);
	// It is used the same array as TT1.
	Ezlist test2 = ezlnew();
	for(int i=0; i<TT1_sz && state == 0; i++) {
		ezladdb(test2, i);
		if(TT1[i] != ezlgetf(test2)) state = 2;
	}
	if(TT1_sz != ezlgetsize(test2)) state = 1;
	ezlwipeall(test2);

	if(!checkState(state)) return state;

	// TEST 3
	// Add a zero at position 2.
	// Checks ezladd and ezlget.
	printTest(3);
	int TT3_sz = 11;
	int TT3[] = {0, 1, 0, 2, 3, 4, 5, 6, 7, 8, 9};

	Ezlist test3 = ezlnew();
	for(int i=0; i<TT1_sz; i++) ezlpush(test3, i);
	ezladd(test3, -1, 0);	// Should do absolutely nothing.
	ezladd(test3, 123, 0);	// Same.
	ezladd(test3, 2, 0);
	if(TT3_sz != ezlgetsize(test3)) state = 1;
	for(int i=0; i<TT3_sz && state == 0; i++) {
		if(TT3[i] != ezlget(test3, i)) state = 2;
	}

	if(!checkState(state)) return state;

	// TEST 4
	// Remove some elements to the test 3.
	// Checks ezlwipef, ezlwipe and ezlwipel.
	printTest(4);
	int TT4_sz = 8;
	int TT4[] = {1, 2, 3, 4, 5, 6, 7, 8};

	ezlwipef(test3);
	ezlwipe(test3, 1);
	ezlwipel(test3);
	if(TT4_sz != ezlgetsize(test3)) state = 1;
	for(int i=0; i<TT4_sz && state == 0; i++) {
		if(TT4[i] != ezlget(test3, i)) state = 2;
	}
	ezlwipeall(test3);

	if(!checkState(state)) return state;

	// TEST 5
	// Convert an ezlist to an array.
	// Checks ezl2arrw (and, of course, ezl2arr).
	printTest(5);
	int TT5_sz = 10;
	int TT5[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

	Ezlist test5 = ezlnew();
	for(int i=0; i<TT5_sz; i++) ezlpush(test5, i);
	// Should not be necessary to check the size at this point.
	int* arr = ezl2arrw(test5);
	for(int i=0; i<TT5_sz && state == 0; i++) {
		if(TT5[i] != arr[i]) state = 1;
	}
	free(arr);

	if(!checkState(state)) return state;

	// TEST 6
	// Converts a local array to an ezlist.
	// Checks: arr2ezl.
	printTest(6);
	int TT6_sz = 10;
	int TT6[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

	Ezlist test6 = arr2ezl(TT6, TT6_sz);
	if(TT6_sz != ezlgetsize(test6)) state = 1;
	for(int i=0; i<TT6_sz && state == 0; i++) {
		if(TT6[i] != ezlget(test6, i)) state = 2;
	}
	ezlwipeall(test6);

	if(!checkState(state)) return state;

	// TEST 7
	// Convert an array based on dynamic memory to an ezlist.
	// Checks: arr2ezlw.
	printTest(7);
	int TT7_sz = 10;
	int* TT7 = malloc(sizeof(int)*TT7_sz);
	for(int i=0; i<TT7_sz; i++) TT7[i] = i;

	Ezlist test7 = arr2ezlw(TT7, TT7_sz);
	if(TT7_sz != ezlgetsize(test7)) state = 1;
	for(int i=0; i<TT7_sz && state == 0; i++) {
		if(i != ezlget(test7, i)) state = 2;
	}
	ezlwipeall(test7);

	if(!checkState(state)) return state;

	printf("\n" ANSI_YELLOW "All tests passed." ANSI_RESET "\n\n");
	return 0;
}
