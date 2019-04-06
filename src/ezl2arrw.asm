; Converts an ezlist to an array; then, deletes the first one.
; rdi -> list

ezl2arrw:
	; Create the array.
	call ezl2arr

	; Free the ezlist.
	push rax
	call ezlwipeall
	pop rax
	
	ret
