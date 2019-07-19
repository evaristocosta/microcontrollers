#include <at89x52.h>

int big = 85, small = 15;
int definitive;
int flag = 1;

void resetTimer(void);

// change values for timer
void button1(void) __interrupt (0) {
	big = 85;
	small = 15;
}
void button2(void) __interrupt (2) {
	big = 67;
	small = 33;
}

// timer behavior, with interruption
void tempo0(void) __interrupt(1) {
	--definitive;
	if(definitive == 0){
		if(flag) {
			definitive = small;
			P1_0 = 0;
			flag = 0;
		} else {
			definitive = big;
			P1_0 = 1;
			flag = 1;
		}
	}
	resetTimer();
}

// start counting
void resetTimer() {
	TR0 = 1;
	
	TH0 = 0xEC;
	TL0 = 0x77;
}

int main() {
	definitive = big;

	IE = 0b10000111;
	IP = 0;
	
	TCON = 0b00000101;
	TMOD = 1;
	
	resetTimer();
	
	P1_0 = 0;
	
	while(1) {}
}
