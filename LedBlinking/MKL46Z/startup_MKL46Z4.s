; ---------------------------------------------------------------------------------------
;  @file:    startup_MKL46Z4.s
;  @purpose: CMSIS Cortex-M0P Core Device Startup File
;            MKL46Z4
;  @version: 2.2
;  @date:    2013-8-15
;  @build:   b151105
; ---------------------------------------------------------------------------------------
;
; Copyright (c) 1997 - 2015 , Freescale Semiconductor, Inc.
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without modification,
; are permitted provided that the following conditions are met:
;
; o Redistributions of source code must retain the above copyright notice, this list
;   of conditions and the following disclaimer.
;
; o Redistributions in binary form must reproduce the above copyright notice, this
;   list of conditions and the following disclaimer in the documentation and/or
;   other materials provided with the distribution.
;
; o Neither the name of Freescale Semiconductor, Inc. nor the names of its
;   contributors may be used to endorse or promote products derived from this
;   software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
; ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
; ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit
        PUBLIC  __vector_table
        PUBLIC  __vector_table_0x1c
        PUBLIC  __Vectors
        PUBLIC  __Vectors_End
        PUBLIC  __Vectors_Size

        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler

        DCD     NMI_Handler                                   ;NMI Handler
        DCD     HardFault_Handler                             ;Hard Fault Handler
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
__vector_table_0x1c
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     SVC_Handler                                   ;SVCall Handler
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     PendSV_Handler                                ;PendSV Handler
        DCD     SysTick_Handler                               ;SysTick Handler

                                                              ;External Interrupts
        DCD     DMA0_IRQHandler                               ;DMA channel 0 transfer complete and error interrupt
        DCD     DMA1_IRQHandler                               ;DMA channel 1 transfer complete and error interrupt
        DCD     DMA2_IRQHandler                               ;DMA channel 2 transfer complete and error interrupt
        DCD     DMA3_IRQHandler                               ;DMA channel 3 transfer complete and error interrupt
        DCD     Reserved20_IRQHandler                         ;Reserved interrupt
        DCD     FTFA_IRQHandler                               ;FTFA command complete and read collision
        DCD     LVD_LVW_IRQHandler                            ;Low-voltage detect, low-voltage warning
        DCD     LLWU_IRQHandler                               ;Low Leakage Wakeup
        DCD     I2C0_IRQHandler                               ;I2C0 interrupt
        DCD     I2C1_IRQHandler                               ;I2C1 interrupt
        DCD     SPI0_IRQHandler                               ;SPI0 single interrupt vector for all sources
        DCD     SPI1_IRQHandler                               ;SPI1 single interrupt vector for all sources
        DCD     UART0_IRQHandler                              ;UART0 status and error
        DCD     UART1_IRQHandler                              ;UART1 status and error
        DCD     UART2_IRQHandler                              ;UART2 status and error
        DCD     ADC0_IRQHandler                               ;ADC0 interrupt
        DCD     CMP0_IRQHandler                               ;CMP0 interrupt
        DCD     TPM0_IRQHandler                               ;TPM0 single interrupt vector for all sources
        DCD     TPM1_IRQHandler                               ;TPM1 single interrupt vector for all sources
        DCD     TPM2_IRQHandler                               ;TPM2 single interrupt vector for all sources
        DCD     RTC_IRQHandler                                ;RTC alarm interrupt
        DCD     RTC_Seconds_IRQHandler                        ;RTC seconds interrupt
        DCD     PIT_IRQHandler                                ;PIT single interrupt vector for all channels
        DCD     I2S0_IRQHandler                               ;I2S0 Single interrupt vector for all sources
        DCD     USB0_IRQHandler                               ;USB0 OTG
        DCD     DAC0_IRQHandler                               ;DAC0 interrupt
        DCD     TSI0_IRQHandler                               ;TSI0 interrupt
        DCD     MCG_IRQHandler                                ;MCG interrupt
        DCD     LPTMR0_IRQHandler                             ;LPTMR0 interrupt
        DCD     LCD_IRQHandler                                ;Segment LCD interrupt
        DCD     PORTA_IRQHandler                              ;PORTA pin detect
        DCD     PORTC_PORTD_IRQHandler                        ;Single interrupt vector for PORTC and PORTD pin detect
__Vectors_End

        SECTION FlashConfig:CODE
__FlashConfig
        DCD 0xFFFFFFFF
        DCD 0xFFFFFFFF
        DCD 0xFFFFFFFF
        DCD 0xFFFFFFFE
__FlashConfig_End

__Vectors       EQU   __vector_table
__Vectors_Size  EQU   __Vectors_End - __Vectors


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB

        PUBWEAK Reset_Handler
        SECTION .text:CODE:REORDER:NOROOT(2)
Reset_Handler
        CPSID   I               ; Mask interrupts
        LDR     R0, =0xE000ED08
        LDR     R1, =__vector_table
        STR     R1, [R0]
        LDR     R0, =SystemInit
        BLX     R0
        CPSIE   I               ; Unmask interrupts
        LDR     R0, =__iar_program_start
        BX      R0

        PUBWEAK NMI_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
NMI_Handler
        B .

        PUBWEAK HardFault_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
HardFault_Handler
        B .

        PUBWEAK SVC_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
SVC_Handler
        B .

        PUBWEAK PendSV_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
PendSV_Handler
        B .
        /* Save LR to return */
        PUSH {LR} /* MSP FFFFFFFD*/
        /* Backup R4 - R7 */
        MRS R0, PSP
        SUBS R0, R0, #4
        STR R7, [R0]
        SUBS R0, R0, #4
        STR R6, [R0]
        SUBS R0, R0, #4
        STR R5, [R0]
        SUBS R0, R0, #4 
        STR R4, [R0] 
        /* Get next SP */
       /* BL GetNextSP /* return PSP cua task tiep theo, back up PSP hien tai*/
        /* Restore R4 - R7 */
        LDR R4, [R0]
        ADDS R0, R0, #4
        LDR R5, [R0]
        ADDS R0, R0, #4
        LDR R6, [R0]
        ADDS R0, R0, #4
        LDR R7, [R0]
        ADDS R0, R0, #4
        /* Update PSP */
        MSR PSP, R0
        /* Restore LR */
        POP {PC}  
        PUBWEAK SysTick_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
        
SysTick_Handler
        B .

        PUBWEAK DMA0_IRQHandler
        PUBWEAK DMA0_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
DMA0_IRQHandler
        LDR     R0, =DMA0_DriverIRQHandler
        BX      R0

        PUBWEAK DMA1_IRQHandler
        PUBWEAK DMA1_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
DMA1_IRQHandler
        LDR     R0, =DMA1_DriverIRQHandler
        BX      R0

        PUBWEAK DMA2_IRQHandler
        PUBWEAK DMA2_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
DMA2_IRQHandler
        LDR     R0, =DMA2_DriverIRQHandler
        BX      R0

        PUBWEAK DMA3_IRQHandler
        PUBWEAK DMA3_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
DMA3_IRQHandler
        LDR     R0, =DMA3_DriverIRQHandler
        BX      R0

        PUBWEAK Reserved20_IRQHandler
        PUBWEAK FTFA_IRQHandler
        PUBWEAK LVD_LVW_IRQHandler
        PUBWEAK LLWU_IRQHandler
        PUBWEAK I2C0_IRQHandler
        PUBWEAK I2C0_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
I2C0_IRQHandler
        LDR     R0, =I2C0_DriverIRQHandler
        BX      R0

        PUBWEAK I2C1_IRQHandler
        PUBWEAK I2C1_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
I2C1_IRQHandler
        LDR     R0, =I2C1_DriverIRQHandler
        BX      R0

        PUBWEAK SPI0_IRQHandler
        PUBWEAK SPI0_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
SPI0_IRQHandler
        LDR     R0, =SPI0_DriverIRQHandler
        BX      R0

        PUBWEAK SPI1_IRQHandler
        PUBWEAK SPI1_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
SPI1_IRQHandler
        LDR     R0, =SPI1_DriverIRQHandler
        BX      R0

        PUBWEAK UART0_IRQHandler
        PUBWEAK UART0_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
UART0_IRQHandler
        LDR     R0, =UART0_DriverIRQHandler
        BX      R0

        PUBWEAK UART1_IRQHandler
        PUBWEAK UART1_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
UART1_IRQHandler
        LDR     R0, =UART1_DriverIRQHandler
        BX      R0

        PUBWEAK UART2_IRQHandler
        PUBWEAK UART2_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
UART2_IRQHandler
        LDR     R0, =UART2_DriverIRQHandler
        BX      R0

        PUBWEAK ADC0_IRQHandler
        PUBWEAK CMP0_IRQHandler
        PUBWEAK TPM0_IRQHandler
        PUBWEAK TPM1_IRQHandler
        PUBWEAK TPM2_IRQHandler
        PUBWEAK RTC_IRQHandler
        PUBWEAK RTC_Seconds_IRQHandler
        PUBWEAK PIT_IRQHandler
        PUBWEAK I2S0_IRQHandler
        PUBWEAK I2S0_DriverIRQHandler
        SECTION .text:CODE:REORDER:NOROOT(2)
I2S0_IRQHandler
        LDR     R0, =I2S0_DriverIRQHandler
        BX      R0

        PUBWEAK USB0_IRQHandler
        PUBWEAK DAC0_IRQHandler
        PUBWEAK TSI0_IRQHandler
        PUBWEAK MCG_IRQHandler
        PUBWEAK LPTMR0_IRQHandler
        PUBWEAK LCD_IRQHandler
        PUBWEAK PORTA_IRQHandler
        PUBWEAK PORTC_PORTD_IRQHandler
        PUBWEAK DefaultISR
        SECTION .text:CODE:REORDER:NOROOT(2)
DMA0_DriverIRQHandler
DMA1_DriverIRQHandler
DMA2_DriverIRQHandler
DMA3_DriverIRQHandler
Reserved20_IRQHandler
FTFA_IRQHandler
LVD_LVW_IRQHandler
LLWU_IRQHandler
I2C0_DriverIRQHandler
I2C1_DriverIRQHandler
SPI0_DriverIRQHandler
SPI1_DriverIRQHandler
UART0_DriverIRQHandler
UART1_DriverIRQHandler
UART2_DriverIRQHandler
ADC0_IRQHandler
CMP0_IRQHandler
TPM0_IRQHandler
TPM1_IRQHandler
TPM2_IRQHandler
RTC_IRQHandler
RTC_Seconds_IRQHandler
PIT_IRQHandler
I2S0_DriverIRQHandler
USB0_IRQHandler
DAC0_IRQHandler
TSI0_IRQHandler
MCG_IRQHandler
LPTMR0_IRQHandler
LCD_IRQHandler
PORTA_IRQHandler
PORTC_PORTD_IRQHandler
DefaultISR
        LDR R0, =DefaultISR
        BX R0

        END
