        mov     20h,#11000000b	; save display values
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

        mov     R0,#20h			; use R0 to access the values
        mov     P0,20h
        
      
button1:
        jb      P3.3,button2
        acall   delay

        inc     R0

        mov     P1,R0          ; P1 work comparing (access bit-bit)
        jb      P1.4,reset     ; P1.4 always 0. If 1, then 30h. Else, continues

        mov     P0,@R0
        jmp     button1
 
button2:
        jb      P3.2,button1
        acall   delay

        dec     R0

        mov     P1,R0
        jnb     P1.5,reset2     ; P1.5 always 1. If 0, then 1fh. Else, continue

        mov     P0,@R0
        jmp     button2
        
reset:                          ; send R0 to start
        mov     R0,#20h
        jmp     3Bh             ; back mov, line 28 (PC)

reset2:                         ; send R0 to the end
        mov     R0,#2Fh
        jmp     4Bh             ; back mov, line 40 (PC)



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
