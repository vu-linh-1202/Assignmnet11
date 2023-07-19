#include "MKL46Z4.h"
#include "CLOCK.h"
#include "PIT.h"
/******************************************************************************
* Variables
******************************************************************************/
extern uint8_t g_u8mode;

/*******************************************************************************
 * code
 ******************************************************************************/
void initLed()
{
    /* Enable clock for PORTD, PORTE */
    SIM->SCGC5 |= (1 << 11);/* Set bit 11 enable clock portC*/
    SIM->SCGC5 |= (1 << 12);/* Set bit 12 enable clock portD*/
    SIM->SCGC5 |= (1 << 13);/* Set bit 13 enable clock portE*/

 

    /* Configure multiplex of PTD5 and PTE29 and PTC3 as GPIO */
    PORTD->PCR[5]  |= PORT_PCR_MUX(1);
    PORTE->PCR[29] |= PORT_PCR_MUX(1);
    /* 
    PORTD->PCR[7]  |= PORT_PCR_MUX(1);
    GPIOD->PDDR |= (1 << 7);
    */
    /* Configure PTD5 and PTE29 as output, PTC3 as input  */
    GPIOD->PDDR |= (1 << 5);
    GPIOE->PDDR |= (1 << 29);
   
    /* Clear PTD5 and PTE29 */
    RED_LED_OFF;
    GREEN_LED_ON;
}
void initClock()
{
    MCG->C2 |= MCG_C2_IRCS_MASK;
    MCG->SC &= ~MCG_SC_FCRDIV_MASK;
    SIM->CLKDIV1 &= ~SIM_CLKDIV1_OUTDIV4_MASK;
    SIM->CLKDIV1 &= ~SIM_CLKDIV1_OUTDIV1_MASK;
    MCG->C1 |= MCG_C1_CLKS(1);
}

void delay_mod1(unsigned long delayTime)
{
    unsigned long i;
    uint8_t u8flag;
    u8flag = 1;
    for (i = 0; i < delayTime; i++)
    {
        while( (g_u8mode == MOD2) && (u8flag == 1))  /* xu ly khi delay chay trong ca 2 mode*/
        {
            i = DELAY_CLOCK - (( DELAY_CLOCK - i )/4);
            u8flag = 0;
        }
        __asm("nop");
    }
}
void delay_mod2(unsigned long delayTime)
{
    unsigned long i;
    /*unsigned long temp; */
    uint8_t u8flag;
    u8flag = 1;
    for (i = 0; i < delayTime; i++)
    {
        while( (g_u8mode == MOD1) && (u8flag == 1))    /* xu ly khi delay chay trong ca 2 mode*/
        {
            u8flag = 0;
            i = DELAY_PIT - (( DELAY_PIT - i )*4);
            /*
            temp = DELAY_CLOCK - (( DELAY_PIT - i )*4);
            for (i = temp; i < DELAY_CLOCK; i++)
            {
                __asm("nop");
            }
            i = delayTime; 
             */
        }
        __asm("nop");
    }
}

