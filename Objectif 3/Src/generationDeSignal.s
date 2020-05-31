	thumb
		
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM
	
	area  moncode, code, readonly
	export	timer_callback
	import etat
	get	etat.inc


cont	equ	32768
	
timer_callback proc

	
	push {r4,r5}
	
	ldr	r0, =etat
	ldr	r1, [R0,#E_POS] 
	ldr	r2, [R0,#E_TAI] 
	ldr	r3, [R0,#E_SON]
	ldr	r5, =TIM3_CCR3
	ldr	r12, [R0,#E_RES] 
	
	cmp	r1,r2
	bne	son
	beq	fin
	

; if position<taille 
son

	ldrsh	R4,[R3,R1, LSL#1]
	add	r4,r4,#cont 
	mul	r4,r12 
	lsr	r4, #16 ; diviser par 2**16
	
	str	r4, [r5]
	
	add	r1, #1
	str	r1,[R0,#E_POS] 
	


; if position=taille	
fin
	pop	{r4,r5}
	bx	lr
	

	endp
	end