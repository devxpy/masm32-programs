array dw 
len equ ($ - array) / 2
key equ
sucmsg db ''
result db ?,10,13,'$'

mov ax, @data
mov ds, ax

mov bx, 1
mov cx, len
mov dx, key

cmp bx, cx
ja notfound

mov ax, bx
add ax, cx
mov si, ax
dec si
add si, si

cmp dx, array[si]
