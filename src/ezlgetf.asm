; Gets the first value of the list.
ezlgetf:
	; Check if the list is initialized.
	mov rax, qword [rdi]
	test rax, rax
	jnz .keepgoing
	mov eax, -1
	ret
	.keepgoing:

	; Return the value
	mov rax, qword [rdi]
	mov eax, dword [rax]
	ret
