; All this could be optimized if EZL used doubly linked lists.
; However, each node would need 8 extra bytes. I don't know to what
; 	extent it's worth it.

; Frees the last node.
; rdi -> list
ezlwipel:
	call saveRegisters
	; Get the last node and check it exists.
	mov rax, qword [rdi+8]
	test rax, rax
	jnz .keepgoing
	call restoreRegisters
	ret
	.keepgoing:

	; If the start and the end node match up,
	; 	just call "ezlwipef", which is faster.
	mov rbx, qword [rdi]
	cmp rax, rbx
	jnz .keepgoing2
	call ezlwipef
	call restoreRegisters
	ret
	.keepgoing2:

	; Get the address of the node before the last one.
	mov esi, dword [rdi+16]
	sub esi, 2
	call ezlgetaddr
	; It's in rax now.

	; Get the address of the following node (the last one), free it, and set it to zero.
	push rdi
	push rax
	mov rdi, qword [rax+4]
	call free WRT ..plt
	pop rax
	pop rdi
	mov qword [rax+4], 0

	; Update the last node
	mov qword [rdi+8], rax

	; Decrement the size
	dec dword [rdi+16]
	call restoreRegisters
	ret
