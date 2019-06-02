#include <at89x52.h>

int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
int contadorDeTempo = 0;
int contador1 = 0;
int contador2 = 0;
int contadorMux = 0;

void resetTimer1();
void resetTimer2();

// funcao de contagem, de 0 a 9
// contador1 referente ao primeiro display,
// contador2 referente ao segundo
void tempo0(void) __interrupt(1) {
	++contadorDeTempo;
	if(contadorDeTempo == 20){
		++contador1;
		if(contador1 == 10) {
			contador1 = 0;
			++contador2;
		}
		if(contador2 == 10)
			contador2 = 0;
		
		contadorDeTempo = 0;
	}
	resetTimer1();
}

// funcao de mux; alterna entre estados/visores
void tempo1(void) __interrupt(3) {
	++contadorMux;
	if(contadorMux == 5) {
		if(P2_0 == 1) {
			P2_0 = 0;
			P2_1 = 1;
			P0 = display[contador1];
		} else {
			P2_0 = 1;
			P2_1 = 0;
			P0 = display[contador2];
		}
		contadorMux = 0;
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