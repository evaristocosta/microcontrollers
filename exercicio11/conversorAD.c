#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int contadorMux = 0;
int dezena = 0;
int unidade = 0;

void resetTimer();

// funcao de mux; alterna entre estados/visores
void tempo0(void) __interrupt(1) {
	++contadorMux;
	if(contadorMux == 5) {
		if(P3_0 == 1) {
			P3_0 = 0;
			P3_1 = 1;
			P0 = display[unidade];
		} else {
			P3_0 = 1;
			P3_1 = 0;
			P0 = display[dezena];
		}
		contadorMux = 0;
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
		// rotina padrão de verificação do conversor
		P3_7 = 0;
		P3_6 = 0;
		P3_5 = 0;
		P3_5 = 1;
		
		// representantes de unidade e dezena
		unidade = P1%10;
		dezena = P1/10;
		
		P3_7 = 1;
	}
}

// reinicia TIMER
void resetTimer() {
	TH0 = 60;
	TL0 = 175;
	
	TF0 = 0;
	TR0 = 1;
}