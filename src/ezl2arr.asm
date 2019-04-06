; Converts an ezlist to an array.
; rdi -> list
ezl2arr:
	call saveRegisters
	; Get the size and allocate the memory.
	mov ebx, dword [rdi+16]	; ebx <- size
	push rdi
	push rbx
	; 4*size bytes
	mov rax, 4
	mul ebx
	mov edi, eax
	call malloc WRT ..plt
	pop rbx
	pop rdi
	mov rsi, rax	; rsi <- array

	; Copy the value of each node to the array.
	xor ecx, ecx	; ecx -> current position of the array
	mov rdi, qword [rdi]	; rdi -> current node
	.L:
		cmp ecx, ebx	; n < size
		jge .L_end
		; It's not necessary to check whether rdi is zero, assuming
		; 	the rest of the code has no bugs and the size is managed properly.

		; Get the address of the current element of the array.
		mov rax, 4
		mul ecx
		add rax, rsi
		; Get the value of the current node.
		mov edx, dword [rdi]
		; Copy it to the array.
		mov dword [rax], edx

		; Go to the next one.
		inc ecx
		mov rdi, qword [rdi+4]
		jmp .L
	.L_end:

	; Return the pointer to the array
	mov rax, rsi
	call restoreRegisters
	ret
