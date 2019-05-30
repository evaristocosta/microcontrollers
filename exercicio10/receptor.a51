inicio:
        mov     TMOD,#20h ; Timer 1 no modo 2
        mov     TH1,#-3 ; Baud rate 9600 (FDh = 253d = 256 - 3)
        mov     SCON,#50h ; Modo 1, REN on
        setb    TR1 ; Inicia timer
prog: 
        jnb     RI,prog ; Espera receber
        clr     RI 
        mov     A,SBUF
        mov     P0,A ; Move dado pro display
        jmp     prog ; Volta pra verificação
        

        end