        org     0000h           ;Onde o programa começa após o RESET
        ajmp    setaMem         ;Pula os endereços previstos de interrupção, por meio da label setaMem 
 
        org     000Bh   ;endereço TIMER0
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        djnz    R2,mux
        reti
 
  
setaMem:  ; valores do display
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

        mov     R0,#20h ; apontadores de memória
        mov     R1,#20h
        
        mov     P0,20h ; saída do display

        ; mux
        setb    P3.0
        clr     P3.1

        ; configuração geral 
        mov     IE,#10000010b
        mov     IP,#00000010b
        mov     TMOD,#00000001b

        ; inicio do TIMER0
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        ; 50 x 5 = 25fps
        mov     R2,#5d

main:   ; rotina padrão de verificação do conversor
        clr     P3.7
        clr     P3.6
        clr     P3.5
        setb    P3.5
        mov     A,P1

        ; configura o display
        mov     B,#10d
        div     AB ; == mod

        add     A,#20h ; soma pra alcançar parte certa da memória
        mov     R1,A

        mov     A,B

        add     A,#20h
        mov     R0,A

        setb    P3.7
        acall   delay
        jmp     main

mux:
        mov     R2,#5d
        jb      P3.0,remux
        mov     P0,@R1
        setb    P3.0
        clr     P3.1
        reti

remux:
        mov     P0,@R0
        clr     P3.0
        setb    P3.1
        reti


delay:
        mov     R3,#50d
aux1:
        mov     R4,#49d
        nop
        nop
        nop
        nop
        nop

aux2:
        nop
        nop
        nop
        nop
        nop
        nop
        djnz    R4,aux2
        djnz    R3,aux1
        ret

        end