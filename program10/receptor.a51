starter:
        mov     TMOD,#20h ; Timer 1 on mode 2
        mov     TH1,#-3 ; Baud rate 9600 (FDh = 253d = 256 - 3)
        mov     SCON,#50h ; Mode 1, REN on
        setb    TR1 ; Start timer
prog: 
        jnb     RI,prog ; wait to receive
        clr     RI 
        mov     A,SBUF
        mov     P0,A ; move data to display
        jmp     prog 
        

        end