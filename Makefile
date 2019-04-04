all: build/libezlists.so

build/libezlists.so: obj/ezlists.o
	tcc obj/ezlists.o -o build/libezlists.so -shared

obj/ezlists.o: src/ezlists.asm
	nasm src/ezlists.asm -o obj/ezlists.o -f elf64

install: build/libezlists.so
	sudo cp build/libezlists.so /usr/lib/libezlists.so
	sudo cp build/ezlists.h /usr/include/ezlists.h

test_no_remove: install
	gcc test/test.c -o test/test -lezlists
	test/test

test: test_no_remove
	rm test/test

clean:
	rm obj/*.o build/*.so
