#include "gassp72.h"
#include <stdio.h>

//extern int dft(unsigned short *,int);


extern int sommecarre(int);
extern int m2(int,short*);
extern short TabSig2[];
short int dma_buf[64];

int M2TIR=3936256/4;

int SYSTICK_PER=360000; 

int k[6] = {17, 18, 19, 20, 23, 24};
int compteur_occurences[6]= {0,0,0,0,0,0};
int M2[6];

int fanion = 0;





int main(void)
{
	int M2k[64];
	

	for(int k=0;k<64;k++)
	{
		M2k[k]=m2(k,TabSig2);
	}

while	(1)
	{

	}
	
}
