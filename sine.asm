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

.MODEL SMALL
.STACK
.DATA
    PA EQU 1c60H        
    CR EQU 1c63H
    CW DB 82H
    TABLE DB 80H,96H,0ABH,0C0H,0D2H,0E2H,0EEH,0F8H,0FEH,0FFH
    DB 0FEH,0F8H,0EEH,0E2H,0D2H,0C0H,0ABH,96H,80H
    DB 69H,54H,40H,2DH,1DH,11H,07H,01H,00H
    DB 01H,07H,11H,1DH,2DH,40H,54H,69H,80H
    MSG DB 10,13,"PRESS ANY KEY TO EXIT $"
.CODE   
    INITDS
    INIT8255
    LEA DX,MSG
    MOV AH,9
    INT 21H

    START:
    MOV CX,25H      
    LEA SI,TABLE        
    
    BACK:   
    MOV AL,[SI]            

    OUTPA                   
    CALL DELAY
    INC SI              
    LOOP BACK           

    MOV AH,1
    INT 16H             
    JZ START

    MOV AH,4CH
    INT 21H

    DELAY PROC
    MOV BX,0FFFH            
    
    L2:   
    DEC BX
    JNZ L2
    RET
    DELAY ENDP
END
