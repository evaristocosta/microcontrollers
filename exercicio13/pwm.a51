;       IMPORTANTE!
;
;       No arquivo de simulacao, para correto funcionamento
;       das interrupcoes, é preciso alterar a ligacao dos
;       botoes para os ports P3.2 e P3.3
;

        org     0000h           
        ajmp    inicio          

        org     0003h           ;endereco da interrupcao INT0
        mov     R1,#85d
        mov     R2,#15d
        reti

        org     0013h           ;endereco da interrupcao INT1
        mov     R1,#67d
        mov     R2,#33d
        reti
        
 
inicio:         
        ; Definicao de interrupcoes
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
        jnb     TF0,$           ; espera zerar o timer
        clr     TF0
        clr     TR0
        djnz    R7,timer        ; quando zero, alterna a saida
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