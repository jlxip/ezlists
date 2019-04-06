; Gets the value of the n-th node.
ezlget:
	; Get the address
	call ezlgetaddr

	; If it's invalid, exit.
	test rax, rax
	jnz .keepgoing
	dec eax
	ret
	.keepgoing:

	; If it's valid, return the value.
	mov eax, dword [rax]
	ret
