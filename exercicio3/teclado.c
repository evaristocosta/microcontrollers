                      #include <at89x52.h>

void verifica();

void main () {
	while(1) {
		P2 = 0xFE;
		verifica();
		P2 = 0xFD;
		verifica();
		P2 = 0xFB;
		verifica();
		P2 = 0xF7;
	}
}

void verifica() {
	if(P2_4 == 0 || P2_5 == 0 || P2_6 == 0 || P2_7 == 0)
		P0 = ~P2;
}                                                                                                                                                                                                                                                         