dos_call macro val
    mov ah, val
    int 21h
endm

print macro msg
    lea dx, msg
    dos_call 09h
endm

printc macro char
    mov dl, char
    dos_call 02h
endm

print_ascii macro
    aam
    mov bx, ax
    add bx, "00"

    mov dl, bh
    dos_call 02h

    mov dl, bl
    dos_call 02h
endm

exit macro
    dos_call 4ch
endm

.model small
.stack 64h
.data
    msg db "the current date & time is: $"
.code
    mov ax, @data
    mov ds, ax

    print msg

    ;hour
    dos_call 2ch
    mov al, ch
    print_ascii 
    
    printc ':'

    ;minute
    dos_call 2ch
    mov al, cl
    print_ascii

    printc ' '
    printc ' '

    ;day
    dos_call 2ah
    mov al, dh
    print_ascii

    printc '/'

    ;month
    dos_call 2ah
    mov al, dl
    print_ascii

    printc '/'  

    ;year
    dos_call 2ah
    add cx, 0c30h
    mov ax, cx
    print_ascii

    exit
end