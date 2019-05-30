#include <at89x52.h>

void led1();
void led2();
void MSDelay(unsigned int);
void main(void) {
	while(1) {
		if(P3_2 == 0)
			led1();
		else if(P3_3 == 0) 
			led2();
		else
			P0 = 0;
	}
}

void led1() {
	MSDelay(200);
	P0 = 0xF0;
}

void led2() {
	MSDelay(200);
	P0 = 0x0F;
}

void MSDelay(unsigned int itime) {
	unsigned int i, j;
	for (i=0; i<itime; i++)
		for (j=0; j<1275; j++);
}
