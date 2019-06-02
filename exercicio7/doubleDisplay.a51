        org     0000h           ;Onde o programa come?a ap?s o RESET
        ajmp    inicio          ;Pula os endere?os previstos de interrup??o, por meio da label INICIO 
 
        org     000Bh           ;endere?o TIMER0
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        dec     A
        jz      resetAcc
        reti
 
        org     001Bh   ;endere�o TIMER1
        mov     TH1,#HIGH(65535-50000)
        mov     TL1,#LOW(65535-50000)
        clr     TF1
        setb    TR1
        dec     B
        jnb     B,mux
        reti

 
inicio:
        mov     20h,#01000000b
        mov     21h,#01111001b
        mov     22h,#00100100b
        mov     23h,#00110000b
        mov     24h,#00011001b
        mov     25h,#00010010b
        mov     26h,#00000010b
        mov     27h,#01111000b
        mov     28h,#00000000b
        mov     29h,#00010000b
        ; ate aqui
        mov     2Ah,#00001000b
        mov     2Bh,#00000011b
        mov     2Ch,#01000110b
        mov     2Dh,#00100001b
        mov     2Eh,#00000110b
        mov     2Fh,#00001110b
 
        mov     R0,#20h
        mov     R1,#20h
        mov     R2,#20h
        mov     P0,20h

        setb    P2.0
        clr     P2.1
        
        ; configura��o geral 
        mov     IE,#10001010b
        mov     IP,#00001000b
        mov     TMOD,#00010001b

        ; inicio do TIMER0 
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        ; 50 x 20 = 1s
        mov     A,#20d

        ; inicio do TIMER1
        mov     TH1,#HIGH(65535-50000)
        mov     TL1,#LOW(65535-50000)
        clr     TF1
        setb    TR1
        ; 50 x 5 = 25fps
        mov     B,#5d

main:
        jmp     main
         
resetAcc:
        inc     R0
        mov     A,#20d
        cjne    R0,#2Ah,return

        ; reset Display 1
        inc     R1
        mov     R0,#20h
        cjne    R1,#2Ah,return

        ; reset Display 2
        mov     R1,#20h
        reti

return:
        reti

mux:
        mov     B,#5d
        jb      P2.0,remux
        mov     P0,@R1
        setb    P2.0
        clr     P2.1
        reti

remux:
        mov     P0,@R0
        clr     P2.0
        setb    P2.1
        reti
