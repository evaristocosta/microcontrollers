#include <at89x52.h>

int maior = 85, menor = 15;
int definitivo;
int flag = 1;

void resetTimer(void);

// alterna entre valores p/ timer
void botao1(void) __interrupt (0) {
	maior = 85;
	menor = 15;
}
void botao2(void) __interrupt (2) {
	maior = 67;
	menor = 33;
}

// comportamento do timer, por interrupcao
void tempo0(void) __interrupt(1) {
	--definitivo;
	if(definitivo == 0){
		if(flag) {
			definitivo = menor;
			P1_0 = 0;
			flag = 0;
		} else {
			definitivo = maior;
			P1_0 = 1;
			flag = 1;
		}
	}
	resetTimer();
}

// inicia contagem
void resetTimer() {
	TR0 = 1;
	
	// é preciso estabeler uma frequência 
	// talvez melhor que essa, entretanto
	// desta forma jé é possível observar
	// o correto funcionamento.
	TH0 = 0xEC;
	TL0 = 0x77;
}

int main() {
	definitivo = maior;

	IE = 0b10000111;
	IP = 0;
	
	TCON = 0b00000101;
	TMOD = 1;
	
	resetTimer();
	
	P1_0 = 0;
	
	while(1) {}
}
