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
    

   mmenu    db 0Dh,0Ah,"      Menu Principal      "
            db 0Dh,0Ah,"Opciones:"
            db 0Dh,0Ah,"1. Iniciar Juego"
            db 0Dh,0Ah,"2. Cargar Juego"
            db 0Dh,0Ah,"3. Salir"
            db 0Dh,0Ah,"Elegir: ",'$'

   mjuego   db 0Dh,0Ah,"     Modo Juego     ","$"

   mtablero db 0Dh,0Ah,"      1   2   3   4   5   6   7   8   9  "
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  A | W | W | W | W | W |   |   |   |   |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  B | W | W | W | W |   |   |   |   |   |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  C | W | W |   |   |   |   |   |   |   |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  D | W |   |   |   |   |   |   |   |   |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  E |   |   |   |   |   |   |   |   |   |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  F |   |   |   |   |   |   |   |   | B |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  G |   |   |   |   |   |   |   | B | B |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  H |   |   |   |   |   |   | B | B | B |"
            db 0Dh,0Ah,"    -------------------------------------"
            db 0Dh,0Ah,"  I |   |   |   |   |   | B | B | B | B |"
            db 0Dh,0Ah,"    -------------------------------------","$"

   msorteo  db 0Dh,0Ah," > Sorteando Turnos!","$"

   mturno   db 0Dh,0Ah,"Turno del jugador con piezas  > W <","$"

   mturno2  db 0Dh,0Ah,"Turno del jugador con piezas  > B <","$"

   mpieza   db 0Dh,0Ah,"Pieza a mover: ","$"

   mdestino db 0Dh,0Ah,"Destino de la pieza: ","$"
            
   ;mtablero db 0Dh,0Ah,"      1   2   3   4   5   6   7   8   9  "
   ;         db 0Dh,0Ah,"    ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗"
   ;         db 0Dh,0Ah,"  A ║ W ║ W ║ W ║ W ║ W ║   ║   ║   ║   ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  B ║ W ║ W ║ W ║ W ║   ║   ║   ║   ║   ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  C ║ W ║ W ║   ║   ║   ║   ║   ║   ║   ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  D ║ W ║   ║   ║   ║   ║   ║   ║   ║   ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  E ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  F ║   ║   ║   ║   ║   ║   ║   ║   ║ B ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  G ║   ║   ║   ║   ║   ║   ║   ║ B ║ B ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  H ║   ║   ║   ║   ║   ║   ║ B ║ B ║ B ║"
   ;         db 0Dh,0Ah,"    ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
   ;         db 0Dh,0Ah,"  I ║   ║   ║   ║   ║   ║ B ║ B ║ B ║ B ║"
   ;         db 0Dh,0Ah,"    ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝","$"


   mcarga   db 0Dh,0Ah,"      Modo Carga     "
            db 0Dh,0Ah,"  No implementado :[ ","$"

.code
main proc
   mov ax,@data
   mov ds,ax

   mode_info
   ClearScreen

   start:
      ClearScreen
      PrintText mmenu
      EnterOption
      mov bl,al
      case1:
         cmp bl,"1"
         jne case2
         mode_juego
         jmp start
      case2:
         cmp bl,"2"
         jne case3
         mode_upload
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
