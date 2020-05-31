	thumb
	
	AREA   MONCODE, CODE, READONLY
	extern fanion
	EXPORT timer_callback

		
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register


	

; ro contient l'adresse du fanion
; r1 contient la valeur 2
; r2 contient la valeur du fanion
; r3 contient l'adresse du registre GPIOB_BSRR

timer_callback 	PROC
	ldr r0, =fanion  
	ldr r2, [r0] ; on met dans r2 ce que pointe r0 (valeur du fanion)
;cmp r2, #0x00000000 ; on compare r2 et 0
;beq mettreA1
	cbz r2, mettreA1
	cbnz r2, mettreA0
	
	
; mise a 1 de PB1
	
mettreA1
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00000002
	str	r1, [r3]
; passons le fanion a 1
	mov r2, #1
	str r2, [r0]
	bx lr
			
			
	; mise a zero de PB1
	
mettreA0
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00020000
	str	r1, [r3]
	mov r2, #0x0
	str r2, [r0]
	bx lr
	; N.B. le registre BSRR est write-only, on ne peut pas le relire
	
	
	ENDP
	END