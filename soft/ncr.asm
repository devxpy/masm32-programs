push_and_call macro
    push ax
    push bx
    call ncr
    pop bx
    pop ax
endm

exit macro
    mov ah, 4ch
    int 21h    
endm

.model small
.stack 64
.data
    n_value db 6
    r_value db 3
    result db 0
.code
    mov ax, @data
    mov ds, ax

    mov al, n_value
    mov bl, r_value

    call ncr
    exit

    ncr proc
        cmp bl, 0
        jne l1
        add result, 1
        ret

        l1:
        cmp bl, al
        jne l2
        add result, 1
        ret

        l2:
        cmp bl, 1
        jne l3
        add result, al
        ret

        l3:
        dec al
        cmp bl, al
        jne l4
        inc al
        add result, al
        ret

        l4:
        push_and_call
        dec bx
        push_and_call
        ret
    ncr endp    
end