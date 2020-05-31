	thumb
	AREA dft, code, READONLY
	import TabSin
	import TabCos
	import TabSig2
	export m2

    ; r0 contient k
    ; r1 cotient TabCos
    ; r2 contient adresse du signal
    ; r3 contient x(i) 
    ; r4 contient cos(i*k)
    ; r5 contient i*k
    ; r6 la somme des x(i)cos(ik)
    ; r7 contient x(i)cos(ik)
    ; r12 contient i


N	EQU 64

calculdft proc
	push {r4,r5,r6, r7}
	
	mov r12, #0x00 ; on initialise i à 0
	ldr r1, =TabCos ; adresse de TabCos 
    ldr r2, =TabSig2; adresse de TabSig
	
	
	mov	r3,#0 
	mov	r6,#0
	
	

loop
	mul r5,r12,r0 ; i * k
    and	r5,r5, #63 ; modulo 64
	;r5 contient desormais i*k mod 64
	
    ldrsh r4, [r1, r5, lsl #0x01] ; cos(ik)
	ldrsh r3, [r2,r12, lsl #0x01] ; x(i)
	
	mul r7,r3,r4 ; r7 contient desormais x(i)*cos(ik)
	
	add r6,r7 ; on l'ajoute à la somme

	add r12, #0x01 ; on incremente i
	
	cmp	r12,#N ; comparaison entre i et N (64)
	
	bne	loop  ; i/=N : on continue la boucle
	beq	end_loop ; i=N : on sort

end_loop
	mov r0, r6
	pop {r4,r5,r6, r7}
	bx lr
	
	endp
	







m2	proc
	push	{lr}
	push	{r4,r5,r6}
	ldr	r2,=TabCos
	push {r0, r1}
	bl calculdft
	;desormais r0 contient le retour de calculdft
	smull	r5,r4,r0,r0 ;on met dans r4, r5 le carré de la partie réelle 
	pop{r0, r1}
	
	
	ldr	r2,=TabSin
	push {r4}
	bl calculdft
	;desormais r0 contient le retour de calculdft
	mov r6, #0x0
	smull	r6,r3,r0,r0 ; 
	add r0, r3, r4 ; somme des carré des parties réelles et imaginaires  
	pop {r4}
	pop	{r4, r5,r6}
	pop {lr}
	bx lr
	endp
		
	
	end
