starter:
        mov     TMOD,#20h ; Timer 1 on mode 2
        mov     TH1,#-3 ; Baud rate 9600 (FDh = 253d = 256 - 3)
        mov     SCON,#50h ; Mode 1, REN on
        setb    TR1 ; start timer

main:
        jnb     P2.0,button1 ; button check
        jnb     P2.1,button2
        jmp     main

button1:
        mov     A,#01111001b 
        jmp     transmission
       

button2:
        mov     A,#00100100b 
        jmp     transmission


transmission:
        mov     SBUF,A ; Move data for transmission
aux:
        jnb     TI,aux ; Await for transmission and go back to main
        clr     TI
        jmp     main

