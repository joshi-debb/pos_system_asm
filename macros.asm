ClearScreen macro
  mov  ah, 0
  mov  al, 3
  int  10H
endm

PrintText macro Text
    mov ax,@data
    mov ds,ax
    mov ah,09h
    lea dx,Text
    int 21h
endm

EnterOption macro
    mov ah,01 
    int 21h  
endm

Entermoves macro
    mov ah, 01
    int 21h 
    mov bl, al
    mov ah, 01
    int 21h
    sub al, '0'
    mov bh, al
endm

mode_info macro
    ClearScreen
    PrintText minfo
    EnterOption
endm

mode_juego macro
    ClearScreen
    PrintText mtablero
    EnterOption
    printtext msorteo
    EnterOption
    ClearScreen
    PrintText mtablero
    PrintText mturno
    PrintText mpieza
    Entermoves
    PrintText mdestino
    Entermoves
    EnterOption
    ClearScreen
    PrintText mtablero
    PrintText mturno2
    PrintText mpieza
    Entermoves
    PrintText mdestino
    Entermoves
    EnterOption
endm

mode_upload macro
    Clearscreen
    PrintText mcarga
    EnterOption
endm

