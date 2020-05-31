#include "gassp72.h"
#include <stdio.h>
#include "etat.h"



extern void timer_callback(void);


extern int sommecarre(int);
extern int m2(unsigned short*,int);
short int dma_buf[64];
int M2k[64];

int M2TIR=3936256/4;

int Periode_PWM_en_Tck  = 360;


int SYSTICK_PER=360000; 

int k[6] = {17, 18, 19, 20, 23, 24};
int compteur_occurences[6]= {0,0,0,0,0,0};
int M2[6];

int fanion = 0;
int score[6]={0,0,0,0,0,0};



extern int LongueurSon ; 
extern int PeriodeSonMicroSec;
extern short Son;


type_etat etat;


void sys_callback(void)
{

	// Démarrage DMA pour 64 points
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	
	
	for (int i=0; i<6; i++)
	{
		M2[i]=m2(dma_buf, k[i]); // calcul DFT M2(k) 
		if (M2[i]>=M2TIR){ // si le seuil est dépassé
			compteur_occurences[i] ++;
			//GPIO_Set(GPIOB, 14);
		}
		else{
			compteur_occurences[i]=0;
			//GPIO_Clear(GPIOB,14);
		}
		if (compteur_occurences[i] >= 15) {
			score[i]++;
			
			etat.position =0;

			
			
				// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();

			// initialisation du timer 4
			// Periode_en_Tck doit fournir la durée entre interruptions,
			// exprimée en périodes Tck de l'horloge principale du STM32 (72 MHz)
			Timer_1234_Init_ff( TIM4, etat.periode_ticks  );
			// enregistrement de la fonction de traitement de l'interruption timer
			// ici le 2 est la priorité, timer_callback est l'adresse de cette fonction, a créér en asm,
		// cette fonction doit être conforme à l'AAPCS
			Active_IT_Debordement_Timer( TIM4, 2, timer_callback );
			// lancement du timer
			Run_Timer( TIM4 );
			
			
			compteur_occurences[i] =0;

		}
	}

}



int main(void)
{
	
	// config port PB0 pour être utilisé en sortie
	GPIO_Configure(GPIOB, 0, OUTPUT, OUTPUT_PPULL);
	
	
	
	
	etat.periode_ticks=PeriodeSonMicroSec*72;
	etat.taille=LongueurSon;
	etat.position=0;
	etat.son=&Son;
	etat.resolution = PWM_Init_ff( TIM3, 3, Periode_PWM_en_Tck );
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	
		// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();
	// PA2 (ADC voie 2) = entrée analog
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	// PB1 = sortie pour profilage à l'oscillo
	GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	// PB14 = sortie pour LED
	GPIO_Configure(GPIOB, 14, OUTPUT, OUTPUT_PPULL);

	// activation ADC, sampling time 1us
	Init_TimingADC_ActiveADC_ff( ADC1, 0x52 );
	Single_Channel_ADC( ADC1, 2 );
	// Déclenchement ADC par timer2, periode (72MHz/320kHz)ticks
	Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
	// Config DMA pour utilisation du buffer dma_buf
	Init_ADC1_DMA1( 0, dma_buf );

	// Config Timer, période exprimée en périodes horloge CPU (72 MHz)
	Systick_Period_ff( SYSTICK_PER );
	// enregistrement de la fonction de traitement de l'interruption timer
	Systick_Prio_IT( 3, sys_callback );
	SysTick_On;
	SysTick_Enable_IT;	
	
	
	
	
	
	
	
	

while	(1)
	{

	}
	
}
