# Change it to GCC if you want.
COMPILER=tcc

all: build/libezlists.so

build/libezlists.so: obj/ezlists.o
	$(COMPILER) obj/ezlists.o -o build/libezlists.so -shared

obj/ezlists.o: src/*.asm
	nasm src/ezlists.asm -o obj/ezlists.o -f elf64

install: build/libezlists.so
	sudo cp build/libezlists.so /usr/lib/libezlists.so
	sudo cp build/ezlists.h /usr/include/ezlists.h

uninstall:
	sudo rm /usr/lib/libezlists.so
	sudo rm /usr/include/ezlists.h

test: install
	$(COMPILER) test/test.c -o test/test -lezlists
	valgrind --leak-check=full test/test
	rm test/test

clean:
	rm obj/*.o build/*.so
