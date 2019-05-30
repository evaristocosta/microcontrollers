        org     0000h        
rot1:
        mov     P2,#0FEh
        acall   rot2
        mov     P2,#0FDh
        acall   rot2
        mov     P2,#0FBh
        acall   rot2
        mov     P2,#0F7h
        acall   rot2
        jmp     rot1

rot2:
        jnb      P2.4,funcao
        jnb      P2.5,funcao
        jnb      P2.6,funcao
        jnb      P2.7,funcao
        ret

funcao:      
        ;acall   delay          ;por alguma razão, delay atrapalha
        mov     A,#0FFh
        xrl     A,P2
        mov     P0,A
        ret


delay:
         mov     R1,#125d
 aux1:
         mov     R2,#124d
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
 
 
 end