print macro msg
    lea dx, msg
    mov ah, 09h
    int 21h
endm

.model small
.stack
.data
    pa equ 1c60h
    cwr equ 1c63h
    cw equ 82h

    table db 80H,96H,0ABH,0C0H,0D2H,0E2H,0EEH,0F8H,0FEH,0FFH
    DB 0FEH,0F8H,0EEH,0E2H,0D2H,0C0H,0ABH,96H,80H
    DB 69H,54H,40H,2DH,1DH,11H,07H,01H,00H
    DB 01H,07H,11H,1DH,2DH,40H,54H,69H,80H

    msg db "Press any key to exit", 10, 13, '$'
.code
    call init

    print msg
    
    start:
        mov cx, 25h
        lea si, table

    write_loop:
        mov al, [si]
        call outpa
        call delay
        inc si
        loop write_loop

    mov ah, 01h
    int 16h
    jz start

    call exit

    exit:
        mov ah, 4ch
        int 21h
        ret

    delay:
        push cx
        mov cx, 0ffffh
        delay_loop:
            loop delay_loop
        pop cx
        ret

    outpa:
        mov dx, pa
        out dx, al
        ret

    init:
        mov ax, @data
        mov ds, ax

        mov dx, cwr
        mov al, cw
        out dx, al
end
