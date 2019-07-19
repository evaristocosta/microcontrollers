#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int timeCounter = 0;
int counter1 = 0;
int counter2 = 0;
int counterMux = 0;

void resetTimer1();
void resetTimer2();

// counting function, 0 to 9
// counter1 of first display,
// counter2 of second
void time0(void) __interrupt(1) {
	++timeCounter;
	if(timeCounter == 20){
		++counter1;
		if(counter1 == 10) {
			counter1 = 0;
			++counter2;
		}
		if(counter2 == 10)
			counter2 = 0;
		
		timeCounter = 0;
	}
	resetTimer1();
}

// mux
void time1(void) __interrupt(3) {
	++counterMux;
	if(counterMux == 5) {
		if(P2_0 == 1) {
			P2_0 = 0;
			P2_1 = 1;
			P0 = display[counter1];
		} else {
			P2_0 = 1;
			P2_1 = 0;
			P0 = display[counter2];
		}
		counterMux = 0;
	}
	resetTimer2();
}

void main() {
	P0 = display[0];
	
	IE = 138;
	IP = 8;
	TMOD = 17;
	
	P2_0 = 0;
	P2_1 = 1;
	
	resetTimer1();
	resetTimer2();
	
	while(1) {}
}

// reinicia TIMER0
void resetTimer1() {
	TF0 = 0;
	TR0 = 1;
	
	TH0 = 60;
	TL0 = 175;
}

// reinicia TIMER1
void resetTimer2() {
	TF1 = 0;
	TR1 = 1;
	
	TH1 = 60;
	TL1 = 175;
}