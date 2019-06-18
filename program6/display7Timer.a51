        org     0000h           
        ajmp    start          
 
        org     000Bh           
        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0
        dec     A
        jz      resetAcc
        reti
 
start:
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
        
        mov     A,#20d
         
        mov     IE,#10000010b
        mov     IP,#00d

        mov     TCON,#00010000b
        mov     TMOD,#00000001b

        mov     TH0,#HIGH(65535-50000)
        mov     TL0,#LOW(65535-50000)
        clr     TF0
        setb    TR0

main:
        mov     P0,@R0
        jmp     main
         
resetAcc:
        inc     R0
        mov     A,#20d
        cjne    R0,#30h,return

resetDisplay:
        mov     R0,#20h
        mov     A,#20d
        reti

return:
        reti