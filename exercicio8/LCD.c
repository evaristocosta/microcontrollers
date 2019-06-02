#include <at89x52.h>

// Por alguma razão, o acumulador da biblioteca não funcionou corretamente, tive de declarar um próprio
int acumulador = 0;

// Mensagem a ser escrita no display
char linha1[16] = "  Mototáxi  do  ";
char linha2[16] = "      Amor      ";

// Delay padrão
void MSDelay(unsigned int itime) {
	unsigned int i, j;
	for (i=0; i<itime; i++)
		for (j=0; j<1275; j++);
}

// Função tanto de configuração como de escrita
void configura(unsigned int opcao) {
	P1_5 = opcao;		// rs
	P1_6 = 0;			// rw
	P1_7 = 0;			// en
	MSDelay(30);
	
	P1_7 = 1;
	MSDelay(30);
			
	P2 = acumulador;	// dat
	MSDelay(30);
	
	P1_7 = 0;
	MSDelay(30);
}

// Rotina padrão de inicialiação do display
void inicializa() {
	MSDelay(30);
	acumulador = 0b00111100;

	configura(0);
	acumulador = 0b00001100;

	configura(0);
	acumulador = 0b00000001;

	configura(0);
	acumulador = 0b00000111;

//	Comentado funciona
//	configura(0);
}

void main() {
	int i = 0;

	inicializa();
	
	// Laço de repetição de escrita
	while(1) {
		i = 0;

		// Primeira linha
		acumulador = 0b00000010;
		configura(0);
		while(i < 16) {
			acumulador = linha1[i];
			configura(1);
			i++;
		}
		
		i = 0;

		// Segunda linha
		acumulador = 0b11000000;
		configura(0);
		while(i < 16) {
			acumulador = linha2[i];
			configura(1);
			i++;		
		}	
	}
}
