dos_func macro val
    mov ah, val
    int 21h
endm

exit macro
    dos_func 4ch
endm    

.model small
.stack 64h
.data
    array dw 4400h, 1100h, 9900h, 2200h, 3300h
    len equ ($ - array) / 2
.code
    mov ax, @data
    mov ds, ax

    mov cx, 2

    outer:
        mov dx, cx
        dec dx
        
        mov si, dx
        add si, si

        mov ax, array[si]

        inner:
            cmp array[si - 2], ax
            jbe break

            mov di, array[si - 2]
            mov array[si], di

            dec si
            dec si

            dec dx
            jnz inner

        break:
            mov array[si], ax
           
            inc cx
            cmp cx, len
            jbe outer

    exit
end    