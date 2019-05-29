dosfn macro val
    mov ah, val
    int 21h
endm

print macro msg
    lea dx, msg
    dosfn 09h
endm    

exit macro 
    dosfn 4ch
endm

.model small
.stack 64h
.data
    found_msg db 10, 13, "element found at: "
    result db ?, 10, 13, '$'
    not_found_msg db 10, 13, "element not found!", 10, 13, '$'
    array dw 1122h, 2233h, 3344h, 4455h, 5566h, 6677h
    len equ ($ - array) / 2
    srch equ 1122h
.code
    mov ax, @data
    mov ds, ax

    mov bx, 1
    mov cx, srch
    mov dx, len

    searchloop:
    cmp bx, dx
    ja not_found

    ; ax = bx + dx / 2
    mov ax, bx
    add ax, dx
    shr ax, 1

    ; si = 2 * (ax - 1)
    mov si, ax
    dec si
    add si, si

    cmp cx, array[si]
    jae above

    below:
        dec ax
        mov dx, ax
        jmp searchloop

    above:
        je found
        inc ax
        mov bx, ax
        jmp searchloop

    found:
        add al, '0'
        mov result, al
        print found_msg
        exit

    not_found:
        print not_found_msg
        exit
end    