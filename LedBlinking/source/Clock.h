#ifndef _CLOCK_H_
#define _CLOCK_H_

/*******************************************************
* DEFINITION
*******************************************************/
#define GREEN_LED_ON        GPIOD->PCOR |= (1 << 5)
#define GREEN_LED_OFF       GPIOD->PSOR |= (1 << 5)
#define GREEN_LED_TOGGLE    GPIOD->PTOR |= (1 << 5)
#define RED_LED_ON          GPIOE->PCOR |= (1 << 29)
#define RED_LED_OFF         GPIOE->PSOR |= (1 << 29)
#define RED_LED_TOGGLE      GPIOE->PTOR |= (1 << 29)
/*
#define RED_LED_ON          GPIOD->PCOR |= (1 << 7)
#define RED_LED_OFF         GPIOD->PSOR |= (1 << 7)
#define RED_LED_TOGGLE      GPIOD->PTOR |= (1 << 7)
*/
#define DELAY_CLOCK        167838
#define MOD1                1u
#define MOD2                2u

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void initClock();
void initLed();
void delay_mod1(unsigned long delayTime);
void delay_mod2(unsigned long delayTime);

#endif