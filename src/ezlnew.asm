; Creates a new list.
ezlnew:
	; 8 bytes -> start
	; 8 bytes -> end
	; 4 bytes -> size
	mov edi, 20
	call malloc

	; Again, fill with zeros.
	mov qword [rax], 0
	mov qword [rax+8], 0
	mov dword [rax+16], 0
	ret
