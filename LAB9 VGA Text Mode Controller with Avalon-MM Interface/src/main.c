#include "text_mode_vga_color.h"
#include "palette_test.h"

int main()
{	
	while (true)
	{
		paletteTest();
		textVGAColorScreenSaver();
	}
	
	
	return 0;
}