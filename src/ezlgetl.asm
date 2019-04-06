; Gets the last value of the list.
ezlgetl:
	; Check if the list is initialized.
	; If it's not the case, return -1.
	mov rax, qword [rdi+8]
	test rax, rax
	jnz .keepgoing
	mov eax, -1
	ret
	.keepgoing:

	; Return the value
	mov rax, qword [rdi+8]
	mov eax, dword [rax]
	ret
