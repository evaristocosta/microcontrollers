        org     0000h           
        ajmp    setMem         ;jum interruption addresses, thru label setMem 
 
        org     000Bh   ;TIMER0 addr
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        djnz    R2,mux
        reti
 
  
setMem:  ; display values
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

        mov     R0,#20h ; mem pointers
        mov     R1,#20h
        
        mov     P0,20h ; display out

        ; mux
        setb    P3.0
        clr     P3.1

        ; general config
        mov     IE,#10000010b
        mov     IP,#00000010b
        mov     TMOD,#00000001b

        ; begin TIMER0
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        ; 50 x 5 = 25fps
        mov     R2,#5d

main:   ; conversor check function
        clr     P3.7
        clr     P3.6
        clr     P3.5
        setb    P3.5
        mov     A,P1

        ; display config
        mov     B,#10d
        div     AB ; == mod

        add     A,#20h ; sum to reach right location on memory
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