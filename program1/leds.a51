        org     0000h

main:
        mov     P0,#170d
        acall   delay1s
        mov     P0,#55h
        acall   delay1s
        ajmp    main

delay1s:
        mov     R1,#500d
aux1:
        mov     R2,#499d
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