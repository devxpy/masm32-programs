dosfn macro val
    mov ah, val
    int 21h
endm

init8255 macro
    mov al, cw
    mov dx, cwr
    out dx, al
endm

outpa macro
    mov dx, pa
    out dx, al
endm

inpb macro
    mov dx, pb
    in al, dx
endm

print macro msg 
    lea dx, msg
    dosfn 09h
endm

exit macro msg
    dosfn 4ch
endm

.model small
.stack 64h
.data
    pa equ 1c60h
    pb equ 1c61h
    cwr equ 1c63h
    cw equ 82h
    msgx db "enter x and press any key",10,13,'$'
    msgy db "enter y and press any key",10,13,'$'
.code
    mov ax, @data
    mov ds, ax

    mov ax, 0

    print msgx
    dosfn 08h
    inpb

    mov bl, al

    print msgy
    dosfn 08h
    inpb

    mul bl

    outpa

    call delay

    mov al, ah
    outpa

    exit

    delay proc
        mov cx, 0ffffH
        inner:
        loop inner
        ret
    delay endp
end