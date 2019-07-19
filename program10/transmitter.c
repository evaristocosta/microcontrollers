#include <at89x52.h>

int num = 0;

void transmission() {
	SBUF = num;

	while(!TI) {}
	
	TI = 0;
}

void main() {
	TMOD = 0x20;
	TH1 = 250;
	SCON = 0x50;
	TR1 = 1;
	
	
	while(1) {
		if(P2_0 == 0) {
			num = 0b01111001;
			transmission();
		} else if(P2_1 == 0) {
			num = 0b00100100;
			transmission();
		}
	}
}