; Converts an array to an ezlist. Then, frees the first.
; rdi -> array
; esi -> size
arr2ezlw:
	; First create the ezlist.
	call arr2ezl

	; Free the array.
	push rax
	call saveRegisters
	call free WRT ..plt
	call restoreRegisters
	pop rax

	ret
