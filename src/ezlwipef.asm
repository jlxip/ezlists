; Frees the first node.
; rdi -> list
ezlwipef:
	call saveRegisters
	; Get the first node and check it exists.
	mov rax, qword [rdi]
	test rax, rax
	jnz .keepgoing
	call restoreRegisters
	ret
	.keepgoing:

	; If the first and the last node are the same,
	; 	set the last one to zero.
	mov rbx, qword [rdi+8]
	cmp rax, rbx
	jnz .keepgoing2
	mov qword [rdi+8], 0
	.keepgoing2:

	; Save the next node.
	mov rbx, qword [rax+4]

	; Free the first one.
	push rbx
	push rdi
	mov rdi, rax
	; --- WARNING ---
	; The following instruction used to crash until magically it worked
	; 	without changing anything (that I remember). I don't know what's going on.
	call free WRT ..plt
	pop rdi
	pop rbx

	; Set the beginning to the stored one.
	mov qword [rdi], rbx

	; Decrement the size
	dec dword [rdi+16]
	call restoreRegisters
	ret
