#include "MKL46Z4.h"
#include "CLOCK.h"
#include "PIT.h"


uint8_t g_u8mode;

void main()
{
    g_u8mode = MOD1;
    initLed();
    initClock();
    initPIT();
    SystemCoreClockUpdate();
    NVIC_EnableIRQ(PIT_IRQn);
    while (1)
    {
        if( g_u8mode == MOD1 )
        {
            GREEN_LED_TOGGLE;
            delay_mod1(DELAY_CLOCK);
        }
        else if( g_u8mode == MOD2 )
        {
            GREEN_LED_TOGGLE;
            delay_mod2(DELAY_PIT);
        }
    }
}

