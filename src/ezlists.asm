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

	; If there's no start and end node, set it.
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
	mov [rbx+8], rax
	inc dword [rdi+16]

	; And as the last
	mov [rdi+8], rax
	ret

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
