# ezlists
A small but complete linked lists library made in assembly.

## Introduction
**ezlists** is a library which helps you using linked lists.

It is written in x86_64 assembly, so that the performance is optimal.

It's tiny: 4KB when compiled using *tcc*. However, it has a pretty decent set of methods that will eventually come handy at a given moment.

ezlists is intented to be used on assembly, C or C++ projects, so a header file is given. In this header file a data type is defined, `Ezlist`, which will have to be used when making a program in C or C++.

## Compilation
ezlists require the following dependences:
+ NASM
+ TCC (or GCC)
+ Valgrind (optional)

ezlists can be compiled, installed and tested with just one command: `make test`.

This will compile and link the library (with TCC by default, but you can change it in the Makefile), install it (along with the header file), and then compile and execute a test program which checks whether the methods work properly. By default, `make test` will launch the test program with *Valgrind*, in order to make sure that there are no memory leaks; but, if you don't want to install it, just modify the Makefile.

## Methods
| Name | Arguments | Returns | Explanation |
| --- | --- | --- | --- |
| `ezlnew` | None | (`Ezlist`) list | Creates a new linked list. |
| `ezlpush` | (`Ezlist`) list, (`int`) value | Nothing | Adds a node at the end of the list. |
| `ezladdb` | (`Ezlist`) list, (`int`) value | Nothing | Adds a node at the beginning of the list. |
| `ezladd` | (`Ezlist`) list, (`int`) index, (`int`) value | Nothing | Adds a node at a given position. |
| `ezlgetsize` | (`Ezlist`) list | (`int`) size | Returns the size of the list. |
| `ezlgetl` | (`Ezlist`) list | (`int`) value | Returns the value of the last node. |
| `ezlgetf` | (`Ezlist`) list | (`int`) value | Returns the value of the first node. |
| `ezlget` | (`Ezlist`) list, (`int`) index | (`int`) value | Returns the value of the node at a given position. |
| `ezlwipef` | (`Ezlist`) list | Nothing | Deletes and frees the first node. |
| `ezlwipel` | (`Ezlist`) list | Nothing | Deletes and frees the last node. |
| `ezlwipe` | (`Ezlist`) list, (int) index | Nothing | Deletes and frees the node at a given position. |
| `ezlwipeall` | (`Ezlist`) list | Nothing | Deletes and frees all the nodes as well as the list itself. |
| `ezl2arr` | (`Ezlist`) list | (`int*`) array | Creates an array with the elements of a list. |
| `ezl2arrw` | (`Ezlist`) list | (`int*`) array | Same as above but also wipes the list. |
| `arr2ezl` | (`int*`) array, (`int`) size | (`Ezlist`) list | Creates a list with the elements of an array. |
| `arr2ezlw` | (`int*`) array, (`int`) size | (`Ezlist`) list | Same as above but frees the array. |

## Example
A simple example could be the following:
```
#include <stdio.h>
#include <ezlists.h>
#include <stdlib.h>

int main() {
	printf("Give me a bunch of integers.\n");
	printf("(Finish with -1)\n");
	
	Ezlist numbers = ezlnew();
	int n;
	do {
		printf(">: ", n);
		scanf("%d", &n);
		ezlpush(numbers, n);
	} while(n != -1);

	ezlwipel(numbers);

	printf("These are the numbers:\n");
	int size = ezlgetsize(numbers);
	for(int i=0; i<size; i++) {
		printf("%d ", ezlget(numbers, i));
	}

	printf("\n\nThese are also the numbers:\n");
	int* array = ezl2arrw(numbers);
	for(int i=0; i<size; i++) {
		printf("%d ", array[i]);
	}
	printf("\n\n");

	free(array);
	return 0;
}
```

Let's compile it:
```
tcc example.c -o example -lezlists
```
Or if you prefer GCC:
```
gcc example.c -o example -lezlists
```

Now, let's run it with Valgrind so we can see if the memory is freed:
```
$ valgrind ./example
==9394== Memcheck, a memory error detector
==9394== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==9394== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==9394== Command: ./example
==9394== 
Give me a bunch of integers.
(Finish with -1)
>: 1
>: 2
>: 3
>: -1
These are the numbers:
1 2 3 

These are also the numbers:
1 2 3 

==9394== 
==9394== HEAP SUMMARY:
==9394==     in use at exit: 0 bytes in 0 blocks
==9394==   total heap usage: 8 allocs, 8 frees, 2,128 bytes allocated
==9394== 
==9394== All heap blocks were freed -- no leaks are possible
==9394== 
==9394== For counts of detected and suppressed errors, rerun with: -v
==9394== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```
