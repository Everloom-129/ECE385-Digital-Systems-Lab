// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng
#include <stdint.h>

int main()
{
	volatile uint8_t *LED_PIO = (uint8_t*)0x70; //make a pointer to access the PIO block
    volatile uint8_t *SWITCH = (uint8_t*)0x60;
    volatile uint8_t *RUN = (uint8_t*)0x50; // 11 at start


	*LED_PIO = 0; //clear all LEDs
	while ((1+1) != 3){
		if ((*RUN) & 0x02){
			*LED_PIO  += *SWITCH;
			while(1){
				 if ((~(*RUN) & 0x02) == 0)
				       break;
			}
		}
        // If reset is pressed
        if( ~(*RUN) & 0x01)
            *LED_PIO = 0x00;

	}

	return 1;
}

