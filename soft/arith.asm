AREA PRO1, CODE, READONLY
    LDR R0, =0x00000001
    LDR R1, =0x00000009

    ADD R2, R1, R0

    LDR R3, =A
    LDR R4, [R3]
    
    LDR R3, =B
    LDR R5, [R3]

    AND R6, R5, R4
    BIC R7, R5, R4

    LDR R3, =ANDRES
    STR R6, [R3]

    LDR R3, =BICRES
    STR R7, [R3]

    A DCD 0x11223344
    B DCD 0x11000044

    BX LR ; branch exchange for link register

AREA DATA1, DATA, READWRITE

    ANDRES DCD 0x0
    BICRES DCD 0x0

END