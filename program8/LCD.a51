; hardware mapping
        rs      equ     P1.5
        rw      equ     P1.6
        en      equ     P1.7
        dat     equ     P2

; ---------------------------
; principal
starter:
        acall   lcd_init
repetition:
        acall   lcd_home
        mov     dptr,#LCD1
        acall   send_lcd

        acall   second_line
        mov     dptr,#LCD2
        acall   send_lcd
        
        ajmp    repetition

lcd_init:
        acall   wait
        mov     a,#00111100b
        acall   config
        mov     a,#00001100b
        acall   config
        mov     a,#00000001b
        acall   config
        mov     a,#00000111b
        ret

LCD1:
        db      'Microcontrolled '

LCD2:
        db      '     Systems    '

; ---------------------------
; send lcd
send_lcd:
        mov     R0,#0d
send:
        mov     a,R0
        inc     R0
        movc    a,@a+dptr

        acall   wdat
        cjne    R0,#16d,send
        ret

; ---------------------------
; write data
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

second_line:
        mov     a,#11000000b
        acall   config
        ret


lcd_home:
        mov     a,#00000010b
        acall   config
        ret


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