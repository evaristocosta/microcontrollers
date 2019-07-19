; hardware mapping
        rs      equ     P1.5
        rw      equ     P1.6
        en      equ     P1.7
        dat     equ     P2

; ---------------------------
; principal
start:
        acall   lcd_init
        acall   lcd_home

; ---------------------------
; column check
column:
        mov     P3,#0FEh
        acall   line
        mov     P3,#0FDh
        acall   line
        mov     P3,#0FBh
        acall   line
        jmp     column

; line check
line:
        jnb     P3.4,function
        jnb     P3.5,function
        jnb     P3.6,function
        jnb     P3.7,function
        ret

; send data to be written
function:
        mov     A,#0FFh
        xrl     A,P3
        acall   waitButton        
        acall   wdat
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

; display config
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

; start display
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
; shorter delay 
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

; button delay 
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