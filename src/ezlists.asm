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
global ezladd:function

; METHODS
%include 'src/privatemethods.asm'
%include 'src/ezlnew.asm'
%include 'src/ezlpush.asm'
%include 'src/ezladdb.asm'
%include 'src/ezlgetl.asm'
%include 'src/ezlgetf.asm'
%include 'src/ezlgetsize.asm'
%include 'src/ezlget.asm'
%include 'src/ezladd.asm'
