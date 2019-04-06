#ifndef EZLISTS_H
#define EZLISTS_H

// Data type
typedef void* Ezlist;

// Methods
Ezlist ezlnew();

void ezlpush(Ezlist start, int value);
void ezladdb(Ezlist start, int value);
void ezladd(Ezlist start, int index, int value);

int ezlgetsize(Ezlist start);
int ezlgetl(Ezlist start);
int ezlgetf(Ezlist start);
int ezlget(Ezlist start, int index);

void ezlwipef(Ezlist start);
void ezlwipel(Ezlist start);
void ezlwipe(Ezlist start, int index);
void ezlwipeall(Ezlist start);

int* ezl2arr(Ezlist start);
int* ezl2arrw(Ezlist start);
Ezlist arr2ezl(int* arr, int size);
Ezlist arr2ezlw(int* arr, int size);
#endif
