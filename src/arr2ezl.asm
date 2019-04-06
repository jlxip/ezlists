; Converts an array to an ezlist.
; rdi -> array
; esi -> size
arr2ezl:
	call saveRegisters
	; Create the new ezlist.
	call ezlnew
	mov rdx, rax
	; The list is now in rdx.

	; Here we go.
	xor ecx, ecx	; counter
	.L:
		push rsi
		push rdi
		; while ecx < size
		cmp ecx, esi
		jge .L_end
		
		; Get the element from the array in esi.
		lea rax, [4*ecx]
		add rax, rdi
		mov esi, dword [rax]

		; Push it to the list.
		mov rdi, rdx	; rdi <- list
		call ezlpush

		; To the next one.
		pop rdi
		pop rsi
		inc ecx
		jmp .L

	.L_end:
	pop rdi
	pop rsi

	; Return the list.
	mov rax, rdx
	call restoreRegisters
	ret
