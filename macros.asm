ClearScreen macro
    mov  ah, 0
    mov  al, 3
    int  10H
endm

PrintText macro buffer      
    mov dx, offset buffer 
    mov ah,09
    int 21
endm

ExtractOption macro
    mov ah, 08
    int 21
endm

EnterOption macro
    mov ah,01 
    int 21h  
endm

printchar macro charToPrint
    mov ah, 2       
    mov dl, charToPrint 
    int 21h 
endm


get_date macro
    mov ah, 2a
    int 21h

    xor ah, ah
    mov al, dl
    mov bl, 0a
    div bl
    add al, 30
    add ah, 30
    mov dia[0], al
    mov dia[1], ah

    xor ah, ah
    mov al, dh
    mov bl, 0a
    div bl
    add al, 30
    add ah, 30
    mov mes[0], al
    mov mes[1], ah

    xor dx, dx
    mov ax, cx
    mov cx, 1000
    div cx
    add al, 32
    mov anio[0], al

    mov ax, dx
    xor dx, dx
    mov cx, 100
    div cx
    add al, 29
    mov anio[1], al

    mov ax, dx
    xor dx, dx
    mov cx, 10
    div cx
    add al, 24
    mov anio[2], al

    add dl, 2c
    mov anio[3], dl
endm


get_hour macro
    mov ah, 2ch
    int 21h

    xor ah, ah
    mov al, ch
    mov bl, 0a
    div bl
    add al, 30
    add ah, 30
    mov hora[0], al
    mov hora[1], ah

    xor ah, ah
    mov al, cl
    mov bl, 0a
    div bl
    add al, 30
    add ah, 30
    mov minuto[0], al
    mov minuto[1], ah
endm


