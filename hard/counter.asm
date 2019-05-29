initds macro
    mov ax, @data
    mov ds, ax
endm

init8255 macro
    mov al, cw
    mov dx, cwr
    out dx, al
endm

dosfn macro val
    mov ah, val
    int 21h
endm

exit macro
    dosfn 4ch
endm

disp macro msg
    lea dx, msg
    dosfn 09h
endm

.model small
.stack 64h
.data
    pa equ 1c60h ; port a
    pb equ 1c61h ; port b
    cwr equ 1c63h ; control word register
    cw equ 82h ; control word
    msg db "Press any key to exit", 10, 13, '$'
    newline db 10,13,'$'
.code
    initds
    init8255

    disp msg

    mov al, 00H

    up:
        call outpa

        add al, 01H
        daa

        cmp al, 05H
        jb up

    down:
        call outpa

        sub al, 01H
        daa

        cmp al, 00H
        ja down

    exit

    delay:
        mov bx, 0010h
        mov cx, 0ffffh

        outer:        
            inner:
            loop inner
        
        dec bx
        cmp bx, 0
        jne outer

        ret

    kbhit:
        push ax
        mov ah, 01h
        int 16h
        jnz done
        pop ax
        ret

        done:
            exit

    outpa:
        push ax

        mov dl, al
        add dl, '0'
        dosfn 02h
        disp newline

        mov dx, pa
        out dx, al

        call delay
        call kbhit

        pop ax
        ret
end