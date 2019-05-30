inicio:
        mov     TMOD,#20h ; Timer 1 no modo 2
        mov     TH1,#-3 ; Baud rate 9600 (FDh = 253d = 256 - 3)
        mov     SCON,#50h ; Modo 1, REN on
        setb    TR1 ; Inicia timer

main:
        jnb     P2.0,botao1 ; Verificação de botões
        jnb     P2.1,botao2
        jmp     main

botao1:
        mov     A,#01111001b ; Equivalente a 1 no display
        jmp     transmite
       

botao2:
        mov     A,#00100100b ; Equivalente a 2 no display
        jmp     transmite


transmite:
        mov     SBUF,A ; Move dado pra transmissão
aux:
        jnb     TI,aux ; Espera transmitir e volta pro main
        clr     TI
        jmp     main

