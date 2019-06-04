#include <at89x52.h>

void MSDelay(unsigned int);

void main(void) {
	// save display values
	int display[16] = {192, 249, 164, 176, 153, 146, 130, 248, 128, 144, 136, 131, 198, 161, 134, 142};
	int counter = 1;
	
	// start display on '0'
	P0 = display[0];
	
	while(1) {
		if(P3_2 == 0) {
			MSDelay(200);
			++counter;
			
			// if counter == 16, its the end
			if(counter == 16)
				counter = 1;
				
			// counter is the vector indexes
			P0 = display[counter-1];
		
		} else if(P3_3 == 0) {
			MSDelay(200);
			--counter;
			
			// if counter == 0, it reached the start
			if(counter == 0)
				counter = 16;
				
			P0 = display[counter-1];	
		}
	}
}


void MSDelay(unsigned int itime) {
	unsigned int i, j;
	for (i=0; i<itime; i++)
		for (j=0; j<1275; j++);
}