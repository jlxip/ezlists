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

#endif
