#include <at89x52.h>

void main() {
	TMOD = 0x20;
	TH1 = 250;
	SCON = 0x50;
	TR1 = 1;
	
	while(1) {
		while(!RI) {}
		RI = 0;
		P0 = SBUF;
	}
	
}