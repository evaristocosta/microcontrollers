#include <at89x52.h>

int accumulator = 0;

// Message to be writen on display
char line1[16] = "Microcontrolled ";
char line2[16] = "     Systems    ";

// Delay
void MSDelay(unsigned int itime) {
	unsigned int i, j;
	for (i=0; i<itime; i++)
		for (j=0; j<1275; j++);
}

// config and write function
void config(unsigned int option) {
	P1_5 = option;		// rs
	P1_6 = 0;			// rw
	P1_7 = 0;			// en
	MSDelay(30);
	
	P1_7 = 1;
	MSDelay(30);
			
	P2 = accumulator;	// dat
	MSDelay(30);
	
	P1_7 = 0;
	MSDelay(30);
}

// display initialization
void starter() {
	MSDelay(30);
	accumulator = 0b00111100;

	config(0);
	accumulator = 0b00001100;

	config(0);
	accumulator = 0b00000001;

	config(0);
	accumulator = 0b00000111;

//	config(0);
}

void main() {
	int i = 0;

	starter();
	
	// writing repeating loop
	while(1) {
		i = 0;

		// first line
		accumulator = 0b00000010;
		config(0);
		while(i < 16) {
			accumulator = line1[i];
			config(1);
			i++;
		}
		
		i = 0;

		// second line
		accumulator = 0b11000000;
		config(0);
		while(i < 16) {
			accumulator = line2[i];
			config(1);
			i++;		
		}	
	}
}
