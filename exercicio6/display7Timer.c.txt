#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int contador1 = 0;
int contador2 = 0;

void resetTimer(void);

void tempo0(void) __interrupt(1) {
	++contador1;
	if(contador1 == 20){
		++contador2;
		if(contador2 == 16)
			contador2 = 0;
		
		P0 = display[contador2];
		contador1 = 0;
	}
	resetTimer();
}

void main(void) {
	P0 = display[0];
	
	IE = 130;
	IP = 0;
	TMOD = 1;
	
	resetTimer();

	while(1) {}
}

void resetTimer() {
	TCON = 16;
	
	TH0 = 60;
	TL0 = 175;
}