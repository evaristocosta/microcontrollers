org     0000h
ljmp    main

;Com ports
sda equ P1.1  ;serial data
scl equ P1.0  ;serial clock

;Com start
i2cinit:
        setb sda
        setb scl
        ret

;Com restart condition
rstart:
        clr scl
        setb sda
        setb scl
        clr sda
        ret

;Com start condition
startc:
        setb scl
        clr sda
        clr scl
        ret

;I2C bus stop condition
stop:
        clr scl
        clr sda
        setb scl
        setb sda
        ret

;data sending funtion 
send:
        mov r7,#08
back:
        clr scl
        rlc a
        mov sda,c
        setb scl
        djnz r7,back
        clr scl
        setb sda
        setb scl
        mov c, sda
        clr scl
        ret

;ACK and NAK for I2C bus
ack:
        clr sda
        setb scl
        clr scl
        setb sda
        ret

nak:
        setb sda
        setb scl
        clr scl
        setb scl
        ret

;data receiving from I2C bus 
recv:
        mov r7,#08
back2:
        clr scl
        setb scl
        mov c,sda
        rlc a
        djnz r7,back2
        clr scl
        setb sda
        ret

; Sending of 3 data and reception of same with ports inversion 
main:
        mov     P2,#0
        lcall   i2cinit
rep:    
        lcall   startc
        mov     a,#20h
        acall   send

        ;send data
        mov     a,#00001111b
        acall   send
               
        mov     a,#11110000b
        acall   send

        acall   stop

button:
        jnb     P1.7, send
        jmp     button
send:
        lcall   rstart
        mov     a,#21h
        acall   send
    
        ;data receiving
        acall   recv
        mov     P2,a
        acall   ack

        acall   recv
        mov     P2,a
        acall   nak
        
        acall   stop

        jmp     rep

        end

