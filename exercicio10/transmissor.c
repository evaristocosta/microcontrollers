#include <at89x52.h>

int numero = 0;

void transmite() {
	SBUF = numero;

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
			numero = 0b01111001;
			transmite();
		} else if(P2_1 == 0) {
			numero = 0b00100100;
			transmite();
		}
	}
}