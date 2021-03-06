#include <at89x52.h>

#define SDA P1_1
#define SCL P1_0
 
void I2CInit(){
	SDA = 1;
	SCL = 1;
}
 
void I2CStart(){
	SDA = 0;
	SCL = 0;
}
 
void I2CRestart(){
	SDA = 1;
	SCL = 1;
	SDA = 0;
	SCL = 0;
}
 
void I2CStop(){
	SCL = 0;
	SDA = 0;
	SCL = 1;
	SDA = 1;
}
 
void I2CAck(){
	SDA = 0;
	SCL = 1;
	SCL = 0;
	SDA = 1;
}
 
void I2CNak(){
	SDA = 1;
	SCL = 1;
	SCL = 0;
	SDA = 1;
}
 
unsigned char I2CSend(unsigned char Data){
	 unsigned char i, ack_bit;
	 for (i = 0; i < 8; i++) {
		if ((Data & 0x80) == 0)
			SDA = 0;
		else
			SDA = 1;
		SCL = 1;
	 	SCL = 0;
		Data<<=1;
	 }
	 SDA = 1;
	 SCL = 1;
	 ack_bit = SDA;
	 SCL = 0;
	 return ack_bit;
}
 
unsigned char I2CRead(){
	unsigned char i, Data=0;
	for (i = 0; i < 8; i++) {
		SCL = 1;
		if(SDA)
			Data |=1;
		if(i<7)
			Data<<=1;
		SCL = 0;
	}
	return Data;
}



void main() {
	int ddata;
	int ack;

    I2CInit();
    I2CStart();
    ack = I2CSend(0x20);
    
    ack = I2CSend(0x07);
    ack = I2CSend(0x10);

    I2CStop();

    
    I2CInit();
    I2CStart();
    
    I2CSend(0x21);
    ddata = I2CRead();
    I2CAck();
    ddata = I2CRead();
    I2CNak();

    I2CStop();

    P2 = ddata;
}