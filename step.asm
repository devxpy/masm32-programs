.model small
.stack 64h
.data
    pa equ 1c60h
    cwr equ 1c63h
    cw equ 82h
.code
    call initds
    call init8255

    mov cx, 200h
    mov al, 88h

    clockwise:    
        call outpa
        call delay
        
        rol al, 1  
        loop clockwise

    mov cx, 200h
    mov al, 88h

    anti_clockwise:
        call outpa
        call delay

        ror al, 1
        loop anti_clockwise

    call exit

    initds:
        mov ax, @data
        mov ds, ax
        ret

    init8255:
        mov al, cw
        mov dx, cwr
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
            loop delay_loop
        pop cx
        ret
end




