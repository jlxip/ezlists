; Allocates the memory for a new node.
ezlalloc:
	; 4 bytes -> integer
	; 8 bytes -> next node
	mov edi, 12
	call malloc WRT ..plt

	; Fill the next address with zeros.
	; There's no need to clear the value, as it will be set later.
	mov qword [rax+4], 0
	ret

; Gets the address of the n-th node.
; If the n-th node doesn't exist, returns 0.
; It is assumed:
; 	rdi = list
; 	esi = index
ezlgetaddr:
	; Check if the list is initialized.
	cmp qword [rdi], 0
	jz .failed

	; ¿n < 0?
	cmp esi, 0
	jl .failed

	; ¿n >= size?
	cmp esi, dword [rdi+16]
	jge .failed

	jmp .keepgoing
	.failed:
		xor eax, eax
		ret
	.keepgoing:

	; Now look for it.
	mov rax, qword [rdi]	; rax <- start
	xor ecx, ecx	; counter
	.L:
		mov rbx, qword [rax+4]	; rbx <- next
		cmp ecx, esi
		jge .L_end
		mov rax, rbx
		inc ecx
		jmp .L
	.L_end:
	ret

; Saves all the registers but "rax", which is often use to return values.
saveRegisters:
	pop r9
	push rsi
	push rdi
	push rdx
	push rcx
	push rbx
	jmp r9

restoreRegisters:
	pop r9
	pop rbx
	pop rcx
	pop rdx
	pop rdi
	pop rsi
	jmp r9
