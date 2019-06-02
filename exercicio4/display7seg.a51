        mov     20h,#11000000b	; salva os valores do display
        mov     21h,#11111001b
        mov     22h,#10100100b
        mov     23h,#10110000b
        mov     24h,#10011001b
        mov     25h,#10010010b
        mov     26h,#10000010b
        mov     27h,#11111000b
        mov     28h,#10000000b
        mov     29h,#10010000b
        mov     2Ah,#10001000b
        mov     2Bh,#10000011b
        mov     2Ch,#11000110b
        mov     2Dh,#10100001b
        mov     2Eh,#10000110b
        mov     2Fh,#10001110b

        mov     R0,#20h			; usa R0 pra acessar os valores
        mov     P0,20h
        
      
botao1:
        jb      P3.3,botao2
        acall   delay

        inc     R0

        mov     P1,R0          ; P1 serve como comparador (acesso bit a bit)
        jb      P1.4,reset     ; P1.4 sempre 0. Se 1, então 30h. Se não, continua

        mov     P0,@R0
        jmp     botao1
 
botao2:
        jb      P3.2,botao1
        acall   delay

        dec     R0

        mov     P1,R0
        jnb     P1.5,reset2     ; P1.5 sempre 1. Se 0, então 1fh. Se não, continua

        mov     P0,@R0
        jmp     botao2
        
reset:                          ; volta R0 pro começo
        mov     R0,#20h
        jmp     3Bh             ; volta no mov, linha 28 (PC)

reset2:                         ; manda R0 pro final
        mov     R0,#2Fh
        jmp     4Bh             ; volta no mov, linha 40 (PC)



delay:
         mov     R1,#200d

aux1:
         mov     R2,#199d
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
         djnz    R2,aux2
         djnz    R1,aux1
         ret
