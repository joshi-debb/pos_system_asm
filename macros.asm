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




