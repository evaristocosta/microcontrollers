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
        jnb      P2.4,function
        jnb      P2.5,function
        jnb      P2.6,function
        jnb      P2.7,function
        ret

function:      
        ;acall   delay          ;delay is a problem
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