#ifndef EZLISTS_H
#define EZLISTS_H

// Data type
typedef void* Ezlist;

// Methods
Ezlist ezlnew();
void ezlpush(Ezlist start, int value);
int ezlgetl(Ezlist start);

#endif
