; Adds a node in the n-th place.
; rdi = list
; esi = index
; edx = value
ezladd:
	call saveRegisters
	; Check if the index is valid.
	; If it's 0, we just call ezladdb.
	; If it's lower, do nothing.
	cmp esi, 0
	jl .donothing
	jnz .keepgoing
	mov esi, edx
	call ezladdb
	call restoreRegisters
	ret
	.keepgoing:

	; If the index is the size, call ezlpush.
	; If it's greater, do nothing.
	mov eax, dword [rdi+16]
	cmp esi, eax
	jg .donothing
	jnz .keepgoing2
	mov esi, edx
	call ezlpush
	call restoreRegisters
	ret

	.donothing:
		call restoreRegisters
		ret
	.keepgoing2:

	; Create the new node and set the value.
	push rdx
	push rsi
	push rdi
	call ezlalloc
	pop rdi
	pop rsi
	pop rdx
	mov dword [rax], edx

	; Get the address of the index-1 @ rbx.
	push rax
	dec esi
	call ezlgetaddr
	mov rbx, rax
	pop rax

	; Get the next address of index-1.
	mov rcx, qword [rbx+4]
	; Copy it to the next of the new.
	mov qword [rax+4], rcx
	; Set the new next to the preceding one.
	mov qword [rbx+4], rax

	; Increment the size
	inc dword [rdi+16]
	call restoreRegisters
	ret
