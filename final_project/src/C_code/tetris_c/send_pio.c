#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "system.h"
#include "io.h"

#define WIDTH 20
#define HEIGHT 30
#define PIO_BASE 0x0000  // Update this with the actual base address of your PIO

char screen[HEIGHT][WIDTH] = {0};






void sendScreenToFPGA() {
    uint32_t data;
    for (int i = 0; i < HEIGHT; i++) {
        data = (i << 27); // 5-bit row index
        for (int j = 0; j < WIDTH; j++) {
            data |= (screen[i][j] << (26 - j)); // 20-bit screen data
        }
        // Assume 7 bits are used for color or other purposes and set them to 0 for now
        IOWR_32DIRECT(PIO_BASE, 0, data);
        usleep(100); // Small delay to ensure FPGA has time to process the data
    }
}

int main() {
    // Initialize the screen array with some data
    // ...
    
    sendScreenToFPGA();

    return 0;
}
