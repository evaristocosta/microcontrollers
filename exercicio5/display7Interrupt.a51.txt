         org     0000h           ;Onde o programa come?a ap?s o RESET
         ajmp    inicio          ;Pula os endere?os previstos de interrup??o, por meio da label INICIO 

        org     0003h           ;endere?o da interrup??o INT0
        inc     R0
        mov     ACC,R0
        jb      ACC.4,resetBotao1
        reti


        org     0013h           ;endere?o da interrup??o INT1
        dec     R0              
        mov     ACC,R0
        jnb      ACC.5,resetBotao2
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
        mov     2Ah,#00001000b
        mov     2Bh,#00000011b
        mov     2Ch,#01000110b
        mov     2Dh,#00100001b
        mov     2Eh,#00000110b
        mov     2Fh,#00001110b

        mov     R0,#20h
        mov     P0,20h
        
        mov     IE,#10001111b
        mov     IP,#00d
        mov     TCON,#00000101b        
      
main:
        mov     P0,@R0
        jmp     main

resetBotao1:
        mov     R0,#20h
        reti
        
resetBotao2:
        mov     R0,#2Fh
        reti


        
        