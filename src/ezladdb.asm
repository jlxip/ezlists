; Adds a new node at the beginning of the list.
ezladdb:
	call saveRegisters
	; Create a new node.
	push rsi
	push rdi
	call ezlalloc
	pop rdi
	pop rsi

	; Set the value
	mov dword [rax], esi
	; Set the next address to the current start.
	mov rbx, qword [rdi]
	mov qword [rax+4], rbx
	; Overwrite the start.
	mov qword [rdi], rax

	; If there's no end node, set it.
	mov rbx, qword [rdi+8]
	test rbx, rbx
	jnz .keepgoing
	mov qword [rdi+8], rax
	.keepgoing:

	inc dword [rdi+16]
	call restoreRegisters
	ret
