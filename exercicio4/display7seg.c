#include <at89x52.h>

void MSDelay(unsigned int);

void main(void) {
	// salva valores do display, em decimal
	int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
	int contador = 1;
	
	// começa display no '0'
	P0 = display[0];
	
	while(1) {
		if(P3_2 == 0) {
			MSDelay(200);
			++contador;
			
			// se contador == 16, significa que chegou ao fim
			if(contador == 16)
				contador = 1;
				
			// contador serve de índice do vetor
			P0 = display[contador-1];
		
		} else if(P3_3 == 0) {
			MSDelay(200);
			--contador;
			
			// se contador == 0, significa que chegou no começo
			if(contador == 0)
				contador = 16;
				
			P0 = display[contador-1];	
		}
	}
}


void MSDelay(unsigned int itime) {
	unsigned int i, j;
	for (i=0; i<itime; i++)
		for (j=0; j<1275; j++);
}