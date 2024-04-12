#include <stdint.h>

// Definitions for easier handling of peripherals
#define LED_PIO_BASE       0x70 // Base address for the LED PIO
#define SWITCH_PIO_BASE    0x60 // Base address for the Switch PIO
#define BUTTON_PIO_BASE    0x50 // Base address for the Button PIO

// Function prototypes for button handling
void waitForButtonRelease(uint8_t button);

int main() {
    // Pointer initializations for the LEDs, switches, and buttons
    volatile uint8_t *LED_PIO = (uint8_t*)LED_PIO_BASE;
    volatile uint8_t *SWITCH_PIO = (uint8_t*)SWITCH_PIO_BASE;
    volatile uint8_t *BUTTON_PIO = (uint8_t*)BUTTON_PIO_BASE;

    uint8_t j = 0; // j for the switch values

    *LED_PIO = j; // Initialize LEDs to show the j value (0 at start)

    while (1) { // Infinite loop
        if (*BUTTON_PIO & 0x04) { // Check if Reset button (KEY[2]) is pressed
            j = 0; // Reset the j
            *LED_PIO = j; // Update LEDs
            waitForButtonRelease(0x04); // Wait for the Reset button to be released

        } else if (*BUTTON_PIO & 0x08) { // Check if Accumulate button (KEY[3]) is pressed

            uint8_t switchValue = *SWITCH_PIO; // Read the switch values
            j += switchValue; // Add the switch value to the j
            
            if (j > 256) { // Check for overflow
                j -= 256 ; // Reset j to 0 on overflow
            }
            *LED_PIO = j; // Update LEDs to show the new j value
            waitForButtonRelease(0x08); // Wait for the Accumulate button to be released
        }
    }
    return 1; // This point is never reached
}

// Function to wait until a specified button is released
void waitForButtonRelease(uint8_t button) {
    volatile uint8_t *BUTTON_PIO = (uint8_t*)BUTTON_PIO_BASE;
    int i = 0
    while (i = 0; i < 100000; i++) {
        //software delay
    }
}
