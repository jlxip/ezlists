; Adds a new node to the end of the list.
; rdi -> list
; esi -> value
ezlpush:
	call saveRegisters
	; Create a new one.
	; malloc smashes rsi and rdi, so I save them.
	push rsi
	push rdi
	call ezlalloc
	pop rdi
	pop rsi

	; Set the value
	mov dword [rax], esi

	; If there's no start and end node, set it as both.
	mov rbx, qword [rdi]
	test rbx, rbx
	jnz .keepgoing
	mov qword [rdi], rax
	mov qword [rdi+8], rax
	inc dword [rdi+16]
	call restoreRegisters
	ret
	.keepgoing:

	; Otherwise, set it as the next to the last.
	mov rbx, qword [rdi+8]
	mov qword [rbx+4], rax
	inc dword [rdi+16]

	; And as the last
	mov [rdi+8], rax
	call restoreRegisters
	ret
