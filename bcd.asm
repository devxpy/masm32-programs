INITDS MACRO        
    MOV AX,@DATA                
    MOV DS,AX                           
ENDM

INIT8255 MACRO 
    MOV AL,CW       
    MOV DX,CR                           
    OUT DX,AL                 
ENDM

OUTPA MACRO
    MOV DX,PA           
    OUT DX,AL
ENDM

DISPLAY MACRO MSG
    MOV AH,9
    LEA DX,MSG
    INT 21H
ENDM

EXIT MACRO
    MOV AH,4CH          
    INT 21H
ENDM

.MODEL SMALL
.STACK
.DATA
    PA EQU 1c60H    
    CR EQU 1c63H
    CW DB 82H
    MSG DB 10,13,"PRESS ANY KEY TO EXIT $"
.CODE
    INITDS
    INIT8255
    DISPLAY MSG 
    MOV AL,0            
    UP:  
    OUTPA              
    CALL DELAY
    CALL KBHIT          
    ADD AL,1            
    DAA             
    CMP AL,99H          
    JNE UP
    DOWN:       
    OUTPA               
    CALL DELAY
    CALL KBHIT
    ADD AL,099H         
    DAA             

    CMP AL,099H
    JNE DOWN
    EXIT
    DELAY PROC
        MOV BX,04FFH
        B2:  
        MOV CX,0FFFFH
        B1: 
        LOOP B1
        DEC BX
        JNZ B2
        RET
    DELAY ENDP

    KBHIT PROC
        PUSH AX
        MOV AH,1            
        INT 16H
        JNZ DONE
        POP AX
        RET
        DONE:  
        EXIT
    KBHIT ENDP
END
