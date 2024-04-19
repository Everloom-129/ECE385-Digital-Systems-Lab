//io_handler.c
#include "io_handler.h"
#include <stdio.h>

void IO_init(void)
{
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
	*otg_hpi_r = 1;
	*otg_hpi_w = 1;
	*otg_hpi_address = 0;
	*otg_hpi_data = 0;
	// Reset OTG chip
	*otg_hpi_cs = 0;
	*otg_hpi_reset = 0;
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
}

void IO_write(alt_u8 Address, alt_u16 Data)
{
    *otg_hpi_address = Address;  // Set the address
    *otg_hpi_data = Data;        // Set the data to be written

    *otg_hpi_cs = 0;             // Assert chip select
    *otg_hpi_w = 0;              // Assert write signal
    // Wait loop or delay here if needed
    *otg_hpi_w = 1;              // De-assert write signal
    *otg_hpi_cs = 1;             // De-assert chip select
}


alt_u16 IO_read(alt_u8 Address)
{
    *otg_hpi_address = Address;  // Set the address

    *otg_hpi_cs = 0;             // Assert chip select
    *otg_hpi_r = 0;              // Assert read signal
    // Wait loop or delay here if needed
    alt_u16 temp = *otg_hpi_data; // Read the data
    *otg_hpi_r = 1;              // De-assert read signal
    *otg_hpi_cs = 1;             // De-assert chip select
	printf("%x\n",temp);

    return temp;
}
