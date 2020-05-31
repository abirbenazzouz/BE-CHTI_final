	AREA DFT_M2k, code, READONLY
	import TabSin
	import TabCos
	export m2
		

		
N EQU 64
	
dft proc
	; r3 : résultat de la somme
	; r4 : indice i
	; r5 : ligne du signal : x(i)
	; r6 : i*k (puis cos ou sin du produit)
	
	push	{lr}
	push	{r4,r5,r6}
	
	mov	r3,#0 
	mov	r4,#0
boucle
	ldrsh	r5, [r0, r4 ,LSL #1] ; ox(i)
	mul	r6, r4, r1 ; ik
	and	r6,r6, #63 ; ik mod 64
	
	ldrsh	r6, [r2, r6 ,lsl #1] ;  cos sin de i*k
	
	mla	r3, r5, r6, r3 ; ajouter a la somme
	
	add	r4,#1 
	cmp	r4,#N
	
	bne	boucle  ; if i!=N
	beq	fin_boucle ; sinon
	
fin_boucle
	mov	r0,r3 ; retour dans r0
	pop	{r4,r5,r6}
	pop	{pc}
	
	endp
	
	
	
m2 proc
	push	{lr}
	push	{r0,r1,r4,r5}
	
	ldr	r2,=TabCos
	bl	dft ; partie réelle
	smull	r4,r5,r0,r0
	
	pop	{r0,r1}
	
	ldr	r2,=TabSin
	bl	dft ; partie imaginaire
	
	smlal	r4,r5,r0,r0
	
	mov	r0,r5
	pop	{r4,r5}
	pop	{pc}
	
	endp
		
end