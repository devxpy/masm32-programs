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

print macro msg
    lea dx, msg
    int 21h
endm

outpb macro msg
    mov dx, pb
    out dx, al
endm

outpc macro msg
    mov dx, pc
    out dx, al
endm

exit macro msg
    dosfn 4ch
endm

.model small
.stack 64h
.data
    pb equ 0c61h
    pc equ 0c62h
    cwr equ 0c63h
    cw equ 82h
    exitmsg db "press any key to exit", 10, 13, '$'
    fire db 86h, 0afh, 0cfh, 8eh
    help db 8CH, 0C7h, 86h, 89h
    nl db 10,13,'$'
.code
    initds
    init8255

    print exitmsg

    start:
    lea si, fire
    call disp_msg
    call delay

    lea si, help
    call disp_msg
    call delay

    mov ah, 01h
    int 16h
    jz start

    exit

    delay proc
        mov cx, 0ffffh
        innerloop:
        loop innerloop
        ret
    delay endp

    clock_cycle proc
        push ax

        mov al, 00h
        outpc

        mov al, 11h
        outpc

        pop ax
        ret
    clock_cycle endp

    disp_msg proc
        mov cx, 04H

        next_char:
        mov al, [si]
        mov bl, 08H
        
        next_bit:
        rol al, 1
        outpb        
        call clock_cycle

        dec bl
        jnz next_bit
        
        inc si
        loop next_char 

        ret   
    disp_msg endp
end
    