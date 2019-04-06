; Deletes the n-th node.
; rdi -> list
; esi -> index
ezlwipe:
	; Check if the index is valid.
	; If it's zero, call "ezlwipef", which will manage the pointers in the list itself.
	; If it's lower, do nothing at all.
	cmp esi, 0
	jl .donothing
	jnz .keepgoing
	call ezlwipef
	ret
	.keepgoing:

	; If the index greater or equal to the size, do nothing.
	mov eax, dword [rdi+16] ; eax <- size
	cmp esi, eax
	jl .keepgoing2
	.donothing:
		ret
	.keepgoing2:

	; If the index is size-1, call "ezlwipel", which will manage the list as well.
	dec eax
	cmp esi, eax
	jnz .keepgoing3
	call ezlwipel
	ret
	.keepgoing3:

	; If this point in the method is reached, the index is valid and it's not
	; 	either the start node or the end node, so those pointers do not need
	; 	to be modified.
	push rdi

	; Get the address of the node at index-1, save it in rax.
	dec esi
	call ezlgetaddr

	; Get the address of the node @ index in rdi.
	mov rdi, qword [rax+4]
	; Get the address of the node @ index+1 in rbx.
	mov rbx, qword [rdi+4]
	; Set the next node of index-1 to index+1.
	mov qword [rax+4], rbx
	; Free index, which position is already in rdi.
	call free WRT ..plt

	; Decrement the size.
	pop rdi
	dec dword [rdi+16]
	ret
