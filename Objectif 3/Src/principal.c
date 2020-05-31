#include "gassp72.h"
#include "etat.h"

extern void timer_callback(void);

int fanion = 0;

extern int LongueurSon ; 
extern int PeriodeSonMicroSec;
extern short Son;

type_etat etat;


int Periode_PWM_en_Tck  = 720;
int main(void)
{
	// config port PB1 pour être utilisé en sortie
	GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	
	
	
	
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







// initialisation du timer 4
// Periode_en_Tck doit fournir la durée entre interruptions,
// exprimée en périodes Tck de l'horloge principale du STM32 (72 MHz)
Timer_1234_Init_ff( TIM4, Periode_PWM_en_Tck  );
// enregistrement de la fonction de traitement de l'interruption timer
// ici le 2 est la priorité, timer_callback est l'adresse de cette fonction, a créér en asm,
// cette fonction doit être conforme à l'AAPCS
Active_IT_Debordement_Timer( TIM4, 2, timer_callback );
// lancement du timer
Run_Timer( TIM4 );
while	(1)
	{

	}
}
