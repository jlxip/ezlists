; Gets the value of the n-th node.
; rdi -> list
; esi -> index
ezlget:
	call saveRegisters
	; Get the address
	call ezlgetaddr

	; If it's invalid, exit.
	test rax, rax
	jnz .keepgoing
	dec eax
	call restoreRegisters
	ret
	.keepgoing:

	; If it's valid, return the value.
	mov eax, dword [rax]
	call restoreRegisters
	ret
