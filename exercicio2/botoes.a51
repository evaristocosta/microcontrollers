botao1:
        jb      P3.3,botao2
        acall   delay1s
        mov     P0,#00001111b
        jmp     botao1

botao2:
        jb      P3.2,botao1
        acall   delay1s
        mov     P0,#11110000b
        jmp     botao2


delay1s:
        mov     R1,#50d
aux1:
        mov     R2,#49d
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
