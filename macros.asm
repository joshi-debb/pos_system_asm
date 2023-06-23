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

mode_info macro
    ClearScreen
    PrintText minfo
    EnterOption
endm
