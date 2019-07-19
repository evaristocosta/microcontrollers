#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int muxCounter = 0;
int ten = 0;
int unity = 0;

void resetTimer();

// mux function; change states/viewers
void time0(void) __interrupt(1) {
	++muxCounter;
	if(muxCounter == 5) {
		if(P3_0 == 1) {
			P3_0 = 0;
			P3_1 = 1;
			P0 = display[unity];
		} else {
			P3_0 = 1;
			P3_1 = 0;
			P0 = display[ten];
		}
		muxCounter = 0;
	}
	resetTimer();
}



void main() {
	P0 = display[0];
	
	IE = 0b10000010;
	IP = 0b00000010;
	TMOD = 0b00000001;
	
	P3_0 = 0;
	P3_1 = 1;
	
	resetTimer();
	
	while(1) {
		// converter function
		P3_7 = 0;
		P3_6 = 0;
		P3_5 = 0;
		P3_5 = 1;
		
		// unity and ten
		unity = P1%10;
		ten = P1/10;
		
		P3_7 = 1;
	}
}

// restart TIMER
void resetTimer() {
	TH0 = 60;
	TL0 = 175;
	
	TF0 = 0;
	TR0 = 1;
}