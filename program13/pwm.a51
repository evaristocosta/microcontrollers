        org     0000h           
        ajmp    starter          

        org     0003h           ;INT0 interruption addr
        mov     R1,#85d
        mov     R2,#15d
        reti

        org     0013h           ;INT1 interruption addr
        mov     R1,#67d
        mov     R2,#33d
        reti
        
 
starter:         
        ; interruptions definition
        mov     IE,#10000101b   
        mov     IP,#00d

        mov     A,#1d

        mov     R1,#85d
        mov     R2,#15d
        mov     B,R2
        mov     R7,B

        clr     P1.0

        mov     TCON,#00000101b
        mov     TMOD,#00000001b

timer:
        mov     TH0,#HIGH(65535)
        mov     TL0,#LOW(65535)
        setb    TR0
        jnb     TF0,$           ; wait timer reach 0
        clr     TF0
        clr     TR0
        djnz    R7,timer        ; when 0, change out
        jmp     reset
       
reset:
        jz      reset2
        mov     B,R1
        mov     R7,B
        setb    P1.0
        dec     A
        jmp     timer

reset2:
        inc     A
        mov     B,R2
        mov     R7,B
        clr     P1.0
        jmp     timer

        end