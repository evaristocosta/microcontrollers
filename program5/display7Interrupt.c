#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int counter = 1;

void botao1(void) __interrupt (0) {
	++counter;
	if(counter == 17)
		counter = 1;
		
	P0 = display[counter-1];
}

void botao2(void) __interrupt (2) {
	--counter;
	if(counter == 0)
		counter = 16;
		
	P0 = display[counter-1];
}


void main(void) {
	P0 = display[0];
	
	IE = 143;
	TCON = 5;
	
	while(1) {}
}