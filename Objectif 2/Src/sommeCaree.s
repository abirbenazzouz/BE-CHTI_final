	thumb

	import TabSin
	import TabCos	
	area  moncode, code, readonly

	export sommecarre
	; r0 correspond a l indice de l angle en entree
sommecarre PROC
		;on importe les adresses de tabsin et tabcos dans r1 et r2
	ldr r1, =TabCos
	ldrsh r1, [r1, r0, lsl #0x01] ; on charge dans r3 TabCos[r0] avec extension de signe
		
	ldr r2, =TabSin
	ldrsh r2, [r2, r0, lsl #0x01] ; de meme pour les sin
		
	smull r4, r3, r1, r1 
	smull r6, r5, r2, r2 
		
	add r0, r6, r4 ;on met dans r0 le resultat de la fonction
	bx lr
		
	ENDP

	END