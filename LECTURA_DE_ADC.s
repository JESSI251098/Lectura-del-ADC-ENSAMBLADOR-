PROCESSOR 16F887                   ;CONfiguracion del pic a utilizar
    ; INSTITUTO TECNOLOGICO SUPERIOR DE COATZACOALCOS 
    ; INGENIERIA MECATRÓNICA    
    ; Práctica 1: LECTURA DE ADC
    ; EQUIPO: LA EGG.CELENCIA           MATERIA: MICROCONTROLADORES
    ; INTEGRANTES:
    ; Agustín Madrigal Luis           17080167           imct17.lagustinm@itesco.edu.mx
    ; Cruz Gallegos Isaac             17080186           imct17.icruzg@itesco.edu.mx
    ; Godínez Palma Jessi Darissel    17080205 	imct17.jgodinezp@itesco.edu.mx
    ; Guzmán García Omar de Jesús     17080211           imct17.oguzmang@itesco.edu.mx
    ; Medina Ortiz Mauricio           17080237           imct17.mmedinao@itesco.edu.mx
    ; Méndez Osorio Julia Vanessa     17080238           imct17.jmendezo@itesco.edu.mx
    ; DOCENTE: JORGE ALBERTO SILVA VALENZUELA
    ; SEMESTRE: 7 °     GRUPO: A
    ; FECHA:  22 / 10 / 2020
    #include <xc.inc>
   ;CONFIG 1
    CONFIG FOSC=INTRC_NOCLKOUT    ;configuracion de los fuses 
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=ON
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
     ;CONFIG 2
    CONFIG BOR4V=BOR40V     ;CONFIG de alimantacion V      
    CONFIG WRT=OFF
    
 
PSECT udata ;Variables a usar
tick:
    DS 1
num:
    DS 1
adc:
    DS 1

PSECT code         ;Generacion de los diferentes delays que ocupampos en esta practica 
Inicio:
movlw 0xff
movwf num
num_loop:
movlw 0xff
movwf tick ;movemos w a f de la variable tick
tick_loop:
decfsz tick,f
goto tick_loop
decfsz num,f
goto num_loop ;volvemos a num_loop
return
    
PSECT code
Inicio2:
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
return

PSECT resetVec,class=CODE,delta=2           ;Nuestra seccion de reset hubicada en la direccion 0h
resetVec:
goto main
    
PSECT main,class=CODE,delta=2       ;Seccion de codigo main hubicada en la direccion 20h
main:
    BANKSEL OSCCON
    MOVLW 0X64
    MOVWF OSCCON
BANKSEL ANSEL
   movlw 0xFF
   movwf ANSEL
   BANKSEL PORTD
   CLRF PORTA
   CLRF PORTD
   clrf PORTC
   BANKSEL TRISA
   movlw  0xFF
   movwf TRISA
   CLRF TRISD
   clrf TRISC
   BANKSEL ADCON0
   MOVLW 0b01000001
   movwf ADCON0
   BANKSEL ADCON1
   movlw 0b10000000
   movwf ADCON1
   QG:
   call Inicio2 ;llamamos al proceso de Inicio2
   BANKSEL ADCON0
   BSF ADCON0,1	
   ad:
   BTFSC ADCON0,1
   goto ad ;nos manda de nuevo al proceso de ad
   BANKSEL ADRESH
   BANKSEL ADRESL
   MOVF ADRESL,0
   BANKSEL PORTD
   movwf PORTD
   goto QG
  
END ;Fin del programa


