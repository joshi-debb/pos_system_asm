include Macros.asm

.model small
.stack 100h

.data

   .RADIX 16

   minfo    db 0Dh,0Ah,"Universidad de San Carlos de Guatemala        "
            db 0Dh,0Ah,"Facultad de Ingenieria                        "
            db 0Dh,0Ah,"Escuela de Vacaciones                         "
            db 0Dh,0Ah,"Arquitectura de Computadoras y Ensambladores 1"
            db 0Dh,0Ah,"                                              "
            db 0Dh,0Ah,"Nombre: Josue Zuleta                          "
            db 0Dh,0Ah,"Carne: 202006353                              ","$"

    ;USUARIO JZULETA
    ;CLAVE 202006363

.code
main proc
   mov ax,@data
   mov ds,ax

   mode_info
   ClearScreen

   start:
      ClearScreen
      mode_info
      EnterOption
      mov bl,al
      case1:
         cmp bl,"1"
         jne case2
         ;mode_juego
         jmp start
      case2:
         cmp bl,"2"
         jne case3
         ;mode_upload
         jmp start
      case3:
         cmp bl,"3"   
         jne case4   
         mov ah,4ch  
         int 21h      
      case4:
         ClearScreen
         jmp start   
            
main endp 
end main
