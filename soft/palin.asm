print macro msg 
    lea dx, msg
    mov ah, 09h
    int 21h
endm

readmsg macro 
    mov ah, 01h
    int 21h
endm

exit macro
    mov ah, 4ch
    int 21h
endm

.model small
.stack 64h
.data
    str1 db 40 dup (0)
    str2 db 40 dup (0)
    entermsg db 10,13,"please enter string:",10,13,'$'
    sucmsg db 10,13,"is palindrome",10,13,'$'
    failmsg db 10,13,"is not palindrome",10,13,'$'
.code
    mov ax, @data
    mov ds, ax
    mov es, ax

    lea si, str1
    lea di, str2

    print entermsg

    mov cx, 0

readloop: 
    readmsg
    cmp al, 13
    jz copyloop

    mov [si], al
    inc si
    inc cx

    jmp readloop

copyloop:    
    dec si

    mov al, [si]
    mov [di], al

    inc di

    cmp si, 0
    jnz copyloop

compare:
    lea si, str1
    lea di, str2

    cld 
    repe cmpsb
    je success

failiure:
    print failmsg
    exit

success:
    print sucmsg
    exit

end