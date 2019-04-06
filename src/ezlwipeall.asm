; Frees the whole list
; rdi -> list
ezlwipeall:
	; Delete the first node until the list is empty.
	.L:
		call ezlwipef
		test eax, eax
		jnz .L

	; Delete the list itself.
	; rdi is already the list.
	call free WRT ..plt

	ret
