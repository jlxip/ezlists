BITS 64

section .text

; EXTERNAL METHODS
extern malloc

; DEFINITIONS
global ezlnew:function
global ezlpush:function
global ezlgetl:function

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
; Creates an uninitialized list (first node with next address 1).
ezlnew:
	call ezlalloc
	mov qword [rax+4], 1
	ret

; Private.
; Gets the address of the last node, first addr @ rdi, last addr @ rax.
; It is assumed that the list is initialized.
ezlladdr:
	mov rax, rdi	; rax -> last node
	mov rbx, qword [rdi+4] ; rbx -> last node's next
	.L:
		test rbx, rbx
		jz .L_end
		mov rax, rbx
		mov rbx, qword [rbx+4]
		jmp .L
	.L_end:
	ret

; Public.
; Adds a new node if the list is already initialized.
; Otherwise, modifies the value of the beginning.
ezlpush:
	; Check if the list is initialized.
	mov rax, qword [rdi+4]
	cmp rax, 1
	jnz .keepgoing
	mov dword [rdi], esi
	mov qword [rdi+4], 0	; Initialization
	ret
	.keepgoing:

	; Create a new one.
	; malloc smashes rsi and rdi, so I save them.
	push rsi
	push rdi
	call ezlalloc
	pop rdi
	pop rsi

	; Set the value
	mov dword [rax], esi

	; Find the last node. Its address will be at rbx.
	push rax	; Save it in the stack
	call ezlladdr
	mov rbx, rax
	pop rax

	; Set the new last address
	mov qword [rbx+4], rax
	ret

; Gets the last value of the list.
ezlgetl:
	; Check if the list is initialized.
	; If it's not the case, return -1.
	mov rax, qword [rdi+4]
	cmp rax, 1
	jnz .keepgoing
	mov eax, -1
	ret
	.keepgoing:

	call ezlladdr

	; Return the value
	mov eax, dword [rax]
	ret
