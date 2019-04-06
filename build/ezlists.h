#ifndef EZLISTS_H
#define EZLISTS_H

// Data type
typedef void* Ezlist;

// Methods
Ezlist ezlnew();
void ezlpush(Ezlist start, int value);
void ezladdb(Ezlist start, int value);
int ezlgetl(Ezlist start);
int ezlgetf(Ezlist start);
int ezlgetsize(Ezlist start);
int ezlget(Ezlist start, int index);
void ezladd(Ezlist start, int index, int value);
void ezlwipef(Ezlist start);
void ezlwipel(Ezlist start);
void ezlwipe(Ezlist start, int index);
void ezlwipeall(Ezlist start);

#endif
