print macro msg
    lea dx, msg
    mov ah, 09h
    int 21h
endm

.model small
.stack 64h
.data
    pa equ 0c60h
    cwr equ 0c63h
    cw equ 82h

    table db 96H,0ABH,0C0H,0D2H,0E2H,0EEH,0F8H,0FEH,0FFH
    db 0FEH,0F8H,0EEH,0E2H,0D2H,0C0H,0ABH,96H

    msg db "Press any key to exit", 10, 13, '$'
.code
    call init

    print(msg)

    start:
        mov cx, 11h
        lea si, table

    write_loop:
        mov al, [si]
        call outpa
        call delay
        inc si
        loop write_loop 

    call delay_zero

    mov ah, 01h
    int 16h
    jz start

    call exit

    init:
        mov ax, @data
        mov ds, ax

        mov dx, cwr
        mov al, cw
        out dx, al
        ret

    exit:
        mov ah, 4ch
        int 21h
        ret

    outpa:
        mov dx, pa
        out dx, al
        ret

    delay:
        push cx 
        mov cx, 0ffffh
        delay_loop:
            loop delay_zero_loop
        pop cx
        ret

    delay_zero:
        push cx 
        mov cx, 9fffh
        delay_zero_loop:
            loop delay_zero_loop
        pop cx
        ret

end