#include <at89x52.h>

void check();

void main () {
	while(1) {
		P2 = 0xFE;
		check();
		P2 = 0xFD;
		check();
		P2 = 0xFB;
		check();
		P2 = 0xF7;
	}
}

void check() {
	if(P2_4 == 0 || P2_5 == 0 || P2_6 == 0 || P2_7 == 0)
		P0 = ~P2;
}                                                                                                                                                                                                                                                         