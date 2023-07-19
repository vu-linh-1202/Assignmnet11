#include "MKL46Z4.h"
#include "CLOCK.h"
#include "PIT.h"

/******************************************************************************
* Variables
******************************************************************************/
extern uint8_t g_u8mode;
volatile uint8_t g_u8tick;
/*******************************************************************************
 * code
 ******************************************************************************/
void initPIT()
{
    enable_clock_gate_PIT();
    disable_clock_PIT_TIMER();
    load_val_PIT(PIT_CHANNEL_0, 2000000);
    enable_PIT(PIT_CHANNEL_0);
    g_u8tick = 0;
}

void load_val_PIT (PIT_CHANNEL channel,int32_t PIT_val )
{
  PIT->CHANNEL[channel].LDVAL = PIT_val;
}

void disable_PIT (PIT_CHANNEL channel)
{
    PIT->CHANNEL[channel].TCTRL =0;
    /* TEN=0 :timer  (n) channel disable, TIE=0:disable interrupt*/
}

void enable_PIT (PIT_CHANNEL channel)
{
    PIT->CHANNEL[channel].TCTRL =3;
    /* TEN=1 :timer (n) channel enable, TIE=1:enable interrupt */
}

void enable_clock_PIT_TIMER()
{
    PIT->MCR &= ~PIT_MCR_MDIS_MASK;
    /* MDIS=0 clock for PIT enable*/
}

void disable_clock_PIT_TIMER()
{
    PIT->MCR |= PIT_MCR_MDIS_MASK;
}

void enable_clock_gate_PIT()
{
  SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
  /* PIT clock gate control*/
}

void disable_clock_gate_PIT()
{
  SIM->SCGC6 &= ~SIM_SCGC6_PIT_MASK;
}

void clear_flag_PIT(PIT_CHANNEL channel)
{
  PIT->CHANNEL[channel].TFLG |= 1;
}
void PIT_IRQHandler()
{
    clear_flag_PIT(PIT_CHANNEL_1);
    g_u8tick++;
    if( g_u8mode == MOD1 )
    {
        RED_LED_TOGGLE;
        if( g_u8tick == 10 )
        {
            g_u8mode = MOD2;
            g_u8tick = 0;
            MCG->SC |= MCG_SC_FCRDIV(2);
            SIM->CLKDIV1 |= SIM_CLKDIV1_OUTDIV4(1);
            load_val_PIT(PIT_CHANNEL_0, 250000);
            enable_PIT(PIT_CHANNEL_0);
        }
    }
    else if( g_u8mode == MOD2 )
    {
        RED_LED_TOGGLE;
        if( g_u8tick == 10 )
        {
            g_u8mode = MOD1;
            g_u8tick = 0;
            MCG->SC &= ~MCG_SC_FCRDIV_MASK;
            SIM->CLKDIV1 &= ~SIM_CLKDIV1_OUTDIV4_MASK;
            load_val_PIT(PIT_CHANNEL_0, 2000000);
            enable_PIT(PIT_CHANNEL_0);
        }
    }
}