org     0000h
ljmp    main

;Portas de comunicacao
sda equ P1.1  ;dado serial
scl equ P1.0  ;clock serial

;Inicializacao da com. I2C
i2cinit:
        setb sda
        setb scl
        ret

;Condicao de restart da com. I2C
rstart:
        clr scl
        setb sda
        setb scl
        clr sda
        ret

;Condicao de começo da com. I2C
startc:
        setb scl
        clr sda
        clr scl
        ret

;Condicao de parada pro bus I2C
stop:
        clr scl
        clr sda
        setb scl
        setb sda
        ret

;Funcao de envio de dados 
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

;ACK e NAK pro bus I2C
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

;Recepcao de dados do bus I2C
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

; Envio de 3 dados e recepcao dos mesmos com inversao de ports
main:
        mov     P2,#0
        lcall   i2cinit
rep:    
        lcall   startc
        mov     a,#20h
        acall   send

        ;envio dos dados
        mov     a,#00001111b
        acall   send
               
        mov     a,#11110000b
        acall   send

        acall   stop

botao:
        jnb     P1.7, envio
        jmp     botao
envio:
        lcall   rstart
        mov     a,#21h
        acall   send
    
        ;recepcao dos dados
        acall   recv
        mov     P2,a
        acall   ack

        acall   recv
        mov     P2,a
        acall   nak
        
        acall   stop

        jmp     rep

        end

