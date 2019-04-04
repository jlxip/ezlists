all: build/libezlists.so

build/libezlists.so: obj/ezlists.o
	tcc obj/ezlists.o -o build/libezlists.so -shared

obj/ezlists.o: src/ezlists.asm
	nasm src/ezlists.asm -o obj/ezlists.o -f elf64

install: build/libezlists.so
	sudo cp build/libezlists.so /usr/lib/libezlists.so
	sudo cp build/ezlists.h /usr/include/ezlists.h

test_compile: install
	gcc test/test.c -o test/test -lezlists
test_no_remove: test_compile
	test/test
test: test_no_remove
	rm test/test
valgrind: test_compile
	valgrind --leak-check=full test/test


clean:
	rm obj/*.o build/*.so
