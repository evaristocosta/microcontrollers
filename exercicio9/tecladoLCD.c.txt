#include <at89x52.h>

int acumulador = 0;

// Matriz de tradução da entrada no teclado numérico
char matrix[4][3] = {{'1', '2', '3'},{'4', '5', '6'},{'7', '8', '9'},{'*', '0', '#'}};

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
			
	P2 = acumulador; 	// dat
	MSDelay(30);
	
	P1_7 = 0;
	MSDelay(30);
}

// Rotina padrão de inicialiação do display
void inicializa() {
	MSDelay(30);
	acumulador = 0b00110100;

	configura(0);
	acumulador = 0b00001111;

	configura(0);
	acumulador = 0b00000001;

	configura(0);
	acumulador = 0b00000111;

//	Comentado funciona
//	configura(0);
}

// Verificação de qual botão foi pressionado, por linha
void verifica(unsigned int i) {
	unsigned int j = 0;
	if(P3_4 == 0) {
		j = 0;
		acumulador = matrix[j][i];
		configura(1);
	}
	if(P3_5 == 0){
		j = 1;
		acumulador = matrix[j][i];
		configura(1);
	}
	if(P3_6 == 0){
		j = 2;
		acumulador = matrix[j][i];
		configura(1);
	}
	if(P3_7 == 0){
		j = 3;
		acumulador = matrix[j][i];
		configura(1);
	}
}

void main() {
	unsigned int i = 0;

	inicializa();

	// primeira linha
	acumulador = 0b00000010;
	configura(0);
	
	// Verificação de qual botão foi pressionado, por coluna
	while(1) {
		P3 = 0xFE;
		verifica(i);
		++i;

		P3 = 0xFD;
		verifica(i);
		++i;
		
		P3 = 0xFB;
		verifica(i);
		i = 0;
	}
}
