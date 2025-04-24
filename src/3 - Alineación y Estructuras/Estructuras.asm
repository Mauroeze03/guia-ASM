

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 0
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 16
NODO_OFFSET_LONGITUD EQU 24
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 0
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 9
PACKED_NODO_OFFSET_LONGITUD EQU 17
PACKED_NODO_SIZE EQU 21
LISTA_OFFSET_HEAD EQU 8
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 8
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos:
	push RBP
	mov RBP,RSP
	mov RDI,[RDI]; voy de lista_t* lista a nodo_t* head
	mov EAX,0
	loop:
		add EAX,[RDI+24]; voy de nodo_t* head a su atributo longitud
		mov RDI,[RDI]; voy de nodo_t* head a nodo_t* next
		cmp RDI,0; comparo si el siguiente nodo es null
		jne loop; si no es null sigo el loop

	pop RBP
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos_packed:
	push RBP
	mov RBP,RSP
	mov RDI,[RDI];voy de packed_lista_t* lista a nodo_t* head
	mov EAX,0
	loop2:
		add EAX,[RDI+17]; voy de packed_nodo_t* head a su atributo longitud
		mov RDI,[RDI]; voy de packed_nodo_t* head a packed
		cmp RDI,0; comparo si el siguiente nodo es null
		jne loop2; si no es null sigo el loop
	pop RBP

	ret

