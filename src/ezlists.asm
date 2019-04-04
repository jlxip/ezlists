BITS 64

section .text

; EXTERNAL METHODS
extern malloc

; DEFINITIONS
global ezlnew:function
global ezlpush:function
global ezladdb:function
global ezlgetl:function
global ezlgetf:function
global ezlgetsize:function
global ezlget:function

; METHODS

; Private.
; Allocates the memory for a new node.
ezlalloc:
	; 4 bytes -> integer
	; 8 bytes -> next node
	mov edi, 12
	call malloc

	; Fill the next address with zeros.
	; There's no need to clear the value, as it will be set later.
	mov qword [rax+4], 0
	ret

; Public.
; Creates a new list.
ezlnew:
	; 8 bytes -> start
	; 8 bytes -> end
	; 4 bytes -> size
	mov edi, 20
	call malloc

	; Again, fill with zeros.
	mov qword [rax], 0
	mov qword [rax+8], 0
	mov dword [rax+16], 0
	ret

; Public.
; Adds a new node to the end of the list.
ezlpush:
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
	ret
	.keepgoing:

	; Otherwise, set it as the next to the last.
	mov rbx, qword [rdi+8]
	mov qword [rbx+4], rax
	inc dword [rdi+16]

	; And as the last
	mov [rdi+8], rax
	ret

; Public.
; Adds a new node at the beginning of the list.
ezladdb:
	; Create a new node.
	push rsi
	push rdi
	call ezlalloc
	pop rdi
	pop rsi

	; Set the value
	mov dword [rax], esi
	; Set the next address to the current start.
	mov rbx, qword [rdi]
	mov qword [rax+4], rbx
	; Overwrite the start.
	mov qword [rdi], rax

	; If there's no end node, set it.
	mov rbx, qword [rdi+8]
	test rbx, rbx
	jnz .keepgoing
	mov qword [rdi+8], rax
	.keepgoing:

	inc dword [rdi+16]
	ret

; Public.
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

; Public.
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

; Public.
; Returns the number of nodes.
ezlgetsize:
	mov eax, dword [rdi+16]
	ret

; Private.
; Gets the address of the n-th node.
; If the n-th node doesn't exists, returns 0.
; It is assumed:
; 	rdi = list
; 	rsi = index
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
	mov eax, dword [rax]
	ret

; Public.
; Gets the value of the n-th node.
ezlget:
	; Get the address
	call ezlgetaddr
	ret

	; If it's invalid, exit.
	test rax, rax
	jnz .keepgoing
	dec eax
	ret
	.keepgoing:

	; If it's valid, return the value.
	mov eax, dword [rax]
	ret
