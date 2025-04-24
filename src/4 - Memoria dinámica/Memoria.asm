extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; char*a [RDI] char*b [RSI]
strCmp:
	push RBP
	mov RBP, RSP
	xor EAX,EAX;

	while1:
		mov r8b, byte[RDI]
		mov r9b, byte[RSI]
		cmp r8b,r9b
		je checkeoFinal
		jl mayor
		jg menor
	checkeoFinal:
		cmp r8b,0
		je igual
		
		inc RDI
		inc RSI
		jmp while1
	
	mayor:
		add EAX,1
		jmp fin
	menor:
		sub EAX,1
		jmp fin
	igual:
		xor EAX,EAX
		jmp fin
	fin:
		pop rbp
		ret

; char* strClone(char* a)
strClone:
	push rbp
	mov rbp,RSP
	push r12
	push r13
	mov r12,RDI
	call strLen
	mov r13, RAX
	mov RDI,r13
	add RDI,1
	call malloc
	mov RDI,RAX; puntero malloc
	mov RSI, r12;el puntero a
	mov RCX, r13;len de a
	cmp RCX, 0
	je vacio
	while2:
		mov r8b,byte[RSI]
		mov byte[RDI],r8b
		inc RDI
		inc RSI
		dec RCX
		cmp RCX, 0
		
		jne while2
	vacio:
		mov r8b,byte[RSI]
		mov byte[RDI],r8b
	fin2:
	pop r13
	pop r12
	pop rbp
	ret

; void strDelete(char* a)
strDelete:
	push RBP
	mov RBP,RSP
	call free 
	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	push RBP
	mov RBP,RSP
	mov RAX, RSI
	mov RSI,RDI
	mov RDI,RAX
	call strPrint
	pop rbp
	
	ret

; uint32_t strLen(char* a)
strLen:
	push RBP
	mov RBP,RSP
	xor EAX,EAX
	cmp byte[RDI], 0
	jz end
	while:
		add EAX,1 ;sumo 1 por el primer elemento
		inc RDI; 
		cmp byte[RDI],0; comparo si el siguiente nodo es null
		jne while; si no es null sigo el loop
	end:
		pop RBP
		ret


