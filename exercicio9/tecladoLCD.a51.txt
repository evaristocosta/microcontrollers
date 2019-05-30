; Mapeamento de hardware
        rs      equ     P1.5
        rw      equ     P1.6
        en      equ     P1.7
        dat     equ     P2

; ---------------------------
; Principal
inicio:
        acall   lcd_init
        acall   lcd_home

; ---------------------------
; Verificação por coluna
coluna:
        mov     P3,#0FEh
        acall   linha
        mov     P3,#0FDh
        acall   linha
        mov     P3,#0FBh
        acall   linha
        jmp     coluna

; Verificação por linha
linha:
        jnb     P3.4,funcao
        jnb     P3.5,funcao
        jnb     P3.6,funcao
        jnb     P3.7,funcao
        ret

; Passa dado a ser escrito
funcao:
        mov     A,#0FFh
        xrl     A,P3
        acall   waitButton        
        acall   wdat
        ret

; ---------------------------
; escreve dado
wdat:
        clr     en
        setb    rs
        clr     rw
        acall   wait
        setb    en        
        mov     dat,a
        acall   wait
        clr     en
        acall   wait
        ret

; configura display
config:
        clr     en
        clr     rs
        clr     rw
        acall   wait
        setb    en
        acall   wait
        mov     dat,a
        acall   wait
        clr     en
        acall   wait
        ret

; inicia o display
lcd_init:
        acall   wait
        mov     a,#00110100b
        acall   config
        mov     a,#00001111b
        acall   config
        mov     a,#00000001b
        acall   config
        mov     a,#00000111b
        ret

lcd_home:
        mov     a,#00000010b
        acall   config
        ret

; ---------------------------
; delay mais curto
wait:
        mov     R1,#15d
aux1:
        mov     R2,#14d
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

; delay do botao
waitButton:
        mov     R3,#250d
aux3:
        mov     R4,#249d
        nop
        nop
        nop
        nop
        nop
 
aux4:
        nop
        nop
        nop
        nop
        nop
        nop
        djnz    R4,aux4
        djnz    R3,aux3
        ret