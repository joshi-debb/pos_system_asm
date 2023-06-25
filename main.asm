include Macros.asm

.model small
.radix 16
.stack

.data
   
    ; Mensajes de bienvenida
    minfo   db 0a,"Universidad de San Carlos de Guatemala        "
            db 0a,"Facultad de Ingenieria                        "
            db 0a,"Escuela de Vacaciones                         "
            db 0a,"Arquitectura de Computadoras y Ensambladores 1"
            db 0a,"                                              "
            db 0a,"Nombre: Josue Zuleta                          "
            db 0a,"Carne: 202006353                              ","$"

    ; Mensajes de msg_error_txt
    msg_exit_txt    db 0a," > Ejecucion Terminada",24

    ;Menu principal
    mainmenu        db 0a," > Menu Principal < "
                    db 0a,"   1. Productos     "
                    db 0a,"   2. Ventas        "
                    db 0a,"   3. Herramientas  "
                    db 0a,"   4. Salir         ","$"

    ;Menu Productos
    menuprod        db 0a," > Menu Productos < "
                    db 0a,"   1. Crear         "
                    db 0a,"   2. Eliminar      "
                    db 0a,"   3. Mostrar       "
                    db 0a,"   4. Regresar      ","$"

    ; Variables de control
    empty_line_txt  db 0a,"$"
    opt_txt         db 0a," > Ingrese Opcion: ","$"
    opt_error_txt   db 0a,0a," > Ingrese una opcion valida",0a,"$"
    viewCabecera    db 0a,"   > Producto","$"
    code_prod       db 0a,"   > Codigo:  ","$"
    pric_prod       db 0a,"   > Precio:  ","$"
    unit_prod       db 0a,"   > Unidades:  ","$"
    desc_prod       db 0a,"   > Descripcion:  ","$"

    ; credenciales
    identifier      db "jzuletaa","$"
    password        db "202006353","$"

    logged_txt      db " > Bienvenido!",0a,0a,0a,"$"
    press_enter_txt db "Presiona Enter para continuar","$"

    ; Lectura del archivo de credenciales
    filename        db "PRAII.CON", 00 
    DatosFilename   db 256 dup(0), "$" 
    countBuff       dw 0 ;
    quotes          db '"' 
    outBuff         db 256 dup(0); 
    countOutBuff    dw 0 

    ; structura producto
    buffer_entrada  db 20, 00
                    db 20 dup (00)
    cod_prod        db 05 dup (0) 
    cod_desc        db 21 dup (0) 
    cod_price       db 02 dup (0) 
    cod_units       db 02 dup (0)
    handle_prods    dw 0000
    fileproductos   db "PROD.BIN", 00 
    num_price       dw 0000
    num_units       dw 0000
    numero          db 02 dup (30)
    ContadorGlobal  dw 0
    opt_show_prod   db 0a,0a,"[ENTER] si desea continuar, [q] para Salir",0a,"$"
    
    ; eliminar producto
    puntero_temp    dw 0000
    cod_prod_temp   db 05 dup (0)
    ceros          db     2a  dup (0)
.code

LeerFile proc 
    mov ah, 3D   
    mov al, 02       
    mov dx, offset fileproductos 
    int 21   
    ret
LeerFile endp

CreateFile proc 
    mov ah, 3C
    mov cx , 0000      
    mov dx, offset fileproductos 
    int 21   
    ret
CreateFile endp

LimpiarBuff:
    ciclo_memset:
        mov AL, 00
        mov [DI], AL
        inc DI
        loop ciclo_memset
        ret


; crear producto
make_prod proc
    IngresarProducto:
        PrintText code_prod
            mov dx , offset buffer_entrada
            mov ah , 0a
            int 21  
            mov DI, offset buffer_entrada
            inc DI 
            mov AL , [DI]
            cmp AL, 05
            jb  ParametrosAceptados
            jmp IngresarProducto
        ParametrosAceptados:
            mov SI, offset cod_prod
            mov DI, offset buffer_entrada
            inc DI
            mov CH, 00
            mov CL, [DI]
            inc DI  
            jmp copiar_nombre
        copiar_nombre:
            mov AL , [DI]
            mov [SI], AL
            inc SI
            inc DI 
            loop copiar_nombre
            jmp TransicionCode

        TransicionCode:
            mov DI , offset cod_prod
            jmp ValidarLetras
        ValidarLetras:
            mov AL, [DI]
            cmp AL, 00 
            je VerificacionCorrectaP
            ; los primeros 
            cmp AL, 22
            je clear_aux
            cmp AL, 23
            je clear_aux
            cmp AL, 25
            je clear_aux
            cmp AL, 26
            je clear_aux
            cmp AL, 27
            je clear_aux
            cmp AL, 28
            je clear_aux
            cmp AL, 2A
            je clear_aux
            cmp AL, 2B
            je clear_aux
            cmp AL, 2C
            je clear_aux
            cmp AL, 2E
            je clear_aux
            cmp AL, 2F
            je clear_aux
            ; : a coma
            cmp AL, 3A
            je clear_aux
            cmp AL, 3B
            je clear_aux
            cmp AL, 3C
            je clear_aux
            cmp AL, 3D
            je clear_aux
            cmp AL, 3E
            je clear_aux
            cmp AL, 3F
            je clear_aux
            cmp AL, 40  
            je clear_aux
            ; z hacia delante
            cmp AL , "Z"
            ja clear_aux
            inc DI
            jmp ValidarLetras    
        clear_aux:
            mov DI, offset cod_prod
            mov Cx , 05
            call LimpiarBuff 
            jmp IngresarProducto
        VerificacionCorrectaP:
            jmp IngresarDescripcion

        IngresarDescripcion:
            PrintText desc_prod
                mov dx , offset buffer_entrada
                mov ah , 0a
                int 21  
                mov DI, offset buffer_entrada
                inc DI 
                mov AL , [DI]
                cmp AL, 20
                jb  TransicionDES
                jmp IngresarDescripcion
            TransicionDES:
                mov SI, offset cod_desc
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp copiar_nombreD
            copiar_nombreD:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop copiar_nombreD
                mov DI, offset cod_desc
                jmp ValidarLetrasD
            ValidarLetrasD:
                mov AL , [DI]
                cmp AL , 00
                je VerificacionCorrectaD
                cmp AL, 20
                je clear_aux_d
                cmp AL, 22
                je clear_aux_d
                cmp AL, 23
                je clear_aux_d
                cmp AL, 24
                je clear_aux_d
                cmp AL, 25
                je clear_aux_d
                cmp AL, 26
                je clear_aux_d
                cmp AL, 27
                je clear_aux_d
                cmp AL, 28
                je clear_aux_d
                cmp AL, 2A
                je clear_aux_d
                cmp AL, 2D
                je clear_aux_d
                cmp AL, 2B
                je clear_aux_d
                cmp AL, 2F
                je clear_aux_d  
                ; en medio 
                cmp AL, 3A
                je clear_aux_d
                cmp AL, 3B
                je clear_aux_d
                cmp AL, 3C
                je clear_aux_d
                cmp AL, 3D
                je clear_aux_d
                cmp AL, 3E
                je clear_aux_d
                cmp AL, 3F
                je clear_aux_d
                cmp AL, 40  
                je clear_aux_d
                ; parte mas interna
                cmp AL, 5B
                je clear_aux_d
                cmp AL, 5C
                je clear_aux_d
                cmp AL, 5D
                je clear_aux_d
                cmp AL, 5E
                je clear_aux_d
                cmp AL, 5F
                je clear_aux_d
                cmp AL, 60
                je clear_aux_d
                cmp AL , "z"
                ja clear_aux_d
                inc DI
                jmp ValidarLetrasD
                clear_aux_d:
                    mov DI, offset cod_desc
                    mov Cx , 21
                    call LimpiarBuff 
                    jmp IngresarDescripcion
                VerificacionCorrectaD:
                jmp IngresarPrecio
                        
        IngresarPrecio:
            PrintText pric_prod
                mov dx , offset buffer_entrada
                mov ah , 0a
                int 21  
                mov DI, offset buffer_entrada
                inc DI 
                mov AL , [DI]
                cmp AL, 03
                jb  ParametrosAceptadosP
                jmp IngresarPrecio
            ParametrosAceptadosP:
                mov SI, offset cod_price
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp copiar_nombreP
            copiar_nombreP:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop copiar_nombreP
                mov DI, offset cod_price
                jmp  ValidarLetrasP    
            ValidarLetrasP:
                mov AL , [DI]
                cmp AL , 00
                je FINPRICE 
                cmp AL, 22
                je TransicionPrecio
                cmp AL, 23
                je TransicionPrecio
                cmp AL, 24  
                je TransicionPrecio
                cmp AL, 25
                je TransicionPrecio
                cmp AL, 26
                je TransicionPrecio
                cmp AL, 27
                je TransicionPrecio
                cmp AL, 28
                je TransicionPrecio
                cmp AL, 29
                je TransicionPrecio
                cmp AL, 2A
                je TransicionPrecio
                cmp AL, 2B
                je TransicionPrecio
                cmp AL, 2C
                je TransicionPrecio
                cmp AL, 2D
                je TransicionPrecio
                cmp AL, 2E
                je TransicionPrecio
                cmp AL, 2F
                je TransicionPrecio
                cmp AL, "9"
                ja TransicionPrecio
                inc DI
                jmp ValidarLetrasP
            TransicionPrecio:
                    mov DI, offset cod_price
                    mov Cx , 02
                    call LimpiarBuff 
                    jmp IngresarPrecio
            FINPRICE:
                mov DI, offset cod_price
                call cadenaAnum
                mov [num_price], AX
                mov DI, offset cod_price
                mov CX, 0002
                call LimpiarBuff         
                jmp IngresarUnidades

        IngresarUnidades:
            PrintText unit_prod
            mov dx , offset buffer_entrada
            mov ah , 0a
            int 21  
            mov DI, offset buffer_entrada
            inc DI 
            mov AL , [DI]
            cmp AL, 03
            jb  ParametrosAceptadosU
            jmp IngresarUnidades
            ParametrosAceptadosU:
                mov SI, offset cod_units
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp copiar_nombreU
            copiar_nombreU:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop copiar_nombreU
                mov DI, offset cod_units
                jmp  ValidarLetrasU    
            ValidarLetrasU:
                mov AL , [DI]
                cmp AL , 00
                je FINUNIT 
                cmp AL, 22
                je TransicionUnidades
                cmp AL, 23
                je TransicionUnidades
                cmp AL, 24  
                je TransicionUnidades
                cmp AL, 25
                je TransicionUnidades
                cmp AL, 26
                je TransicionUnidades
                cmp AL, 27
                je TransicionUnidades
                cmp AL, 28
                je TransicionUnidades
                cmp AL, 29
                je TransicionUnidades
                cmp AL, 2A
                je TransicionUnidades
                cmp AL, 2B
                je TransicionUnidades
                cmp AL, 2C
                je TransicionUnidades
                cmp AL, 2D
                je TransicionUnidades
                cmp AL, 2E
                je TransicionUnidades
                cmp AL, 2F
                je TransicionUnidades
                cmp AL, "9"
                ja TransicionUnidades
                inc DI
                jmp ValidarLetrasU
            TransicionUnidades:
                mov DI, offset cod_units
                mov Cx , 03
                call LimpiarBuff 
                jmp IngresarUnidades
            FINUNIT:
                mov DI, offset cod_units
                call cadenaAnum
                mov [num_units], AX
                mov DI, offset cod_units
                mov CX, 0002
                call LimpiarBuff 
                jmp add_products
        add_products:           
            ;leer archivo
            call LeerFile
            jc CrearFiless 
            jmp sigueRead
            CrearFiless:
                call CreateFile                    
            sigueRead:
                mov [handle_prods], AX
                ;; obtener handle
                mov BX, [handle_prods]
                ;; vamos al final del archivo
                mov CX, 00 ;se desplaza la cantidad de bytes
                mov DX, 00;se desplaza la cantidad de bytes
                mov AL, 02;si mueve al final del archivo
                mov AH, 42
                int 21
                ;; escribir el producto en el archivo
                ;; escribí los dos primeros campos
                mov CX, 26
                mov DX, offset cod_prod
                mov AH, 40
                int 21

                mov CX, 0004
                mov DX, offset num_price
                mov AH, 40   
                int 21                 
                ;; cerrar archivo
                mov AH, 3e
                int 21

                jmp Prod_Menu

    ret  
make_prod endp

; mostrar productos
shown_prod proc
    show_prod:
        call LeerFile
        mov [handle_prods], AX
        PrintText empty_line_txt
        mov si,0
        ciclo_mostrar:
            inc si
            mov BX, [handle_prods]
            mov CX, 05    
            mov DX, offset cod_prod
            mov AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 21    
            mov DX, offset cod_desc
            mov AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 0004
            mov DX, offset num_price
            mov AH, 3f
            int 21
            cmp AX, 00
            je fin_mostrar
            ; poner enter
            ; termina enter
            PrintText viewCabecera
            call PrintText_CODE
            call PrintText_DESC

            cmp si , 05
            jz printt
            
            jmp ciclo_mostrar
        fin_mostrar:
            jmp Prod_Menu
        printt:
            PrintText  opt_show_prod
            ExtractOption
            cmp al , 71
            je Prod_Menu
            mov si,0
            ClearScreen
            jmp ciclo_mostrar

    ret
shown_prod endp

; eliminar producto
delete_prod proc
    dele_prod:
            mov DX, 0000
            mov [puntero_temp], DX
            pedir_de_nuevo_codigo2:
            PrintText code_prod
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            mov DI, offset buffer_entrada
            inc DI
            mov AL, [DI]
            cmp AL, 00
            je  pedir_de_nuevo_codigo2
            cmp AL, 05
            jb  aceptar_tam_cod2  
            jmp pedir_de_nuevo_codigo2
        aceptar_tam_cod2:
            mov SI, offset cod_prod_temp
            mov DI, offset buffer_entrada
            inc DI
            mov CH, 00
            mov CL, [DI]
            inc DI  
        copiar_codigo2:	
            mov AL, [DI]
            mov [SI], AL
            inc SI
            inc DI
            loop copiar_codigo2 
            call LeerFile
            mov [handle_prods], AX
            ciclo_encontrar:
            ; lectura
            mov BX, [handle_prods]
            mov CX, 26
            mov DX, offset cod_prod
            moV AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 4
            mov DX, offset num_price
            moV AH, 3f
            int 21
            ; verifica si llego al fin
            cmp AX, 0000   
            je finalizar_borrar
            ; obtengo los bytes recorridos
            mov DX, [puntero_temp]
            add DX, 2a
            mov [puntero_temp], DX
            ;;; verificar si es producto válido
            mov AL, 00
            cmp [cod_prod], AL
            je ciclo_encontrar
            ;;; verificar el código
            mov SI, offset cod_prod_temp
            mov DI, offset cod_prod
            mov CX, 0005
            call cadenas_iguales
            cmp DL, 0ff
            je borrar_encontrado
            jmp ciclo_encontrar
        borrar_encontrado:
            mov DX, [puntero_temp]
            sub DX, 2a
            mov CX, 0000
            mov BX, [handle_prods]
            mov AL, 00
            mov AH, 42
            int 21
            ;;; puntero posicionado
            mov CX, 2a
            mov DX, offset ceros
            mov AH, 40
            int 21
        finalizar_borrar:
            mov BX, [handle_prods]
            mov AH, 3e
            int 21
            jmp Prod_Menu
    ret
delete_prod endp

clearOutBuff proc
    mov countOutBuff, 0
    begin_clear:
        mov bx, countOutBuff
        mov outBuff[bx], 0
        inc countOutBuff
        cmp countOutBuff, 256
        jne begin_clear ; limpia el buffer de salida

    mov countOutBuff, 0
    ret
clearOutBuff endp

; extrae la cita del buffer
extract_quote proc
     find_quotes:
        mov bx, countBuff
        mov al, DatosFilename[bx]
        cmp al, quotes
        jne next_char
        inc countBuff

    save_char:
        mov bx, countBuff
        mov al, DatosFilename[bx]
        cmp al, quotes
        je end_quotes
        mov bx, countOutBuff
        mov outBuff[bx], al
        inc countOutBuff
        inc countBuff
        jmp save_char

    next_char:
        inc countBuff
        mov bx, countBuff
        cmp DatosFilename[bx], "$"
        jne find_quotes

    end_quotes:
        mov bx, countOutBuff
        mov outBuff[bx], "$"
        ret
extract_quote endp

.STARTUP
    inicio:   
        mov AX, 7e7
		call numAcadena
		mov BX, 01
		mov CX, 0002
		mov DX, offset numero
		mov AH, 40
		int 21
        ClearScreen
        PrintText minfo    

    LeerArchivo:  
        ; abrir archivo
        mov ah, 3D   
        mov al, 00       
        mov dx, offset filename 
        int 21    
        jc bool_NoExiste 
        mov bx , ax ; handle
        ; leer archivo
        mov ah , 3F
        mov cx , 100
        mov dx , offset DatosFilename 
        int 21
        jmp  ExtraerCredenciales

    ExtraerCredenciales:
        mov countBuff, 0
        call clearOutBuff 
        call extract_quote
        xor si,si
        jmp CompararUseR

    CompararUser:
        mov bh, outBuff[si]
        mov bl, identifier[si]
        cmp bh,bl
        jnz NoIgual
        cmp bh , "$"
        jz  Clave
        inc si
        jmp CompararUser

    Clave:
        inc countBuff
        call clearOutBuff 
        call extract_quote

        xor si,si
        jmp CompararClave

    CompararClave:
        mov bh, outBuff[si]
        mov bl, password[si]
        cmp bh,bl
        jnz NoIgual
        cmp bh , "$"
        jz Login
        inc si
        jmp CompararClave

    Login:
        ; cierra el archivo
        mov ah, 3E     
        mov bx, ax    
        int 21 
        PrintText empty_line_txt
        PrintText empty_line_txt
        PrintText logged_txt
        PrintText press_enter_txt
        EnterOption
        jmp Main_Menu

    Main_Menu:
        ClearScreen
        PrintText mainmenu
        PrintText opt_txt
        ExtractOption
        cmp al , 31
        je Prod_Menu
        ; cmp al , 32
        ; je MENU_VENTAS
        ; cmp al , 33
        ; je MENU_HERRAMIENTAS
        cmp al , 34
        je Exit
        PrintText opt_error_txt 
        jmp Main_Menu
    
    Prod_Menu:
        PrintText menuprod
        PrintText opt_txt
        ExtractOption
        cmp al , 31
        je mk_prod
        cmp al , 32
        je dl_prod
        cmp al , 33
        je sw_prod
        cmp al , 34
        je Main_Menu
        jmp Prod_Menu
    
    mk_prod:
        call make_prod
        jmp Prod_Menu
    
    sw_prod:
        call shown_prod
        jmp Prod_Menu
    
    dl_prod:
        call delete_prod
        jmp Prod_Menu

    NoIgual:
        PrintText empty_line_txt
        jmp Exit 
       
    bool_NoExiste:
        jmp Exit 


    PrintText_estructura:
        PrintText empty_line_txt
        mov DI, offset cod_prod
    ciclo_poner_dolar_1:
        mov AL, [DI]
        cmp AL, 00
        je poner_dolar_1
        inc DI
        jmp ciclo_poner_dolar_1
    poner_dolar_1:
        mov AL, 24  ;; dólar
        mov [DI], AL
        ;; PrintText normal
        PrintText cod_prod
        PrintText empty_line_txt

        PrintText empty_line_txt
        PrintText empty_line_txt
        ret


    PrintText_CODE:
        mov DI, offset cod_prod
    ciclo_poner_dolar_CODE:
        mov AL, [DI]
        cmp AL, 00
        je poner_dolar_code
        inc DI
        jmp ciclo_poner_dolar_CODE
    poner_dolar_code:
        mov AL, 24  ;; dólar
        mov [DI], AL
        ;; PrintText normal
        PrintText empty_line_txt
        PrintText cod_prod
        PrintText empty_line_txt
        ret

    PrintText_DESC:
        mov DI, offset cod_desc
    ciclo_poner_dolar_DESC:
        mov AL, [DI]
        cmp AL, 00
        je poner_dolar_desc
        inc DI
        jmp ciclo_poner_dolar_DESC
    poner_dolar_desc:
        mov AL, 24  ;; dólar
        mov [DI], AL
        ;; PrintText normal
        PrintText cod_desc
        PrintText empty_line_txt
        ret

    numAcadena:
        mov CX, 0002
        mov DI, offset numero
    ciclo_poner30s:
        mov BL, 30
        mov [DI], BL
        inc DI
        loop ciclo_poner30s

        mov CX, AX    ; inicializar contador
        mov DI, offset numero
        add DI, 0001
        ;;
    ciclo_convertirAcadena:
        mov BL, [DI]
        inc BL
        mov [DI], BL
        cmp BL, 3a
        je aumentar_siguiente_digito_primera_vez
        loop ciclo_convertirAcadena
        jmp retorno_convertirAcadena
    aumentar_siguiente_digito_primera_vez:
        push DI
    aumentar_siguiente_digito:
        mov BL, 30     ; poner en "0" el actual
        mov [DI], BL
        dec DI         ; puntero a la cadena
        mov BL, [DI]
        inc BL
        mov [DI], BL
        cmp BL, 3a
        je aumentar_siguiente_digito
        pop DI         ; se recupera DI
        loop ciclo_convertirAcadena
    retorno_convertirAcadena:
        ret

    cadenas_iguales:
    ciclo_cadenas_iguales:
        mov AL, [SI]
        cmp [DI], AL
        jne no_son_iguales
        inc DI
        inc SI
        loop ciclo_cadenas_iguales
        ;;;;; <<<
        mov DL, 0ff
        ret
    no_son_iguales:	mov DL, 00
        ret

    cadenaAnum:
        mov AX, 0000    ; inicializar la salida
        mov CX, 0002    ; inicializar contador
    seguir_convirtiendo:
        mov BL, [DI]
        cmp BL, 00
        je retorno_cadenaAnum
        sub BL, 30      ; BL es el valor numérico del caracter
        mov DX, 000a
        mul DX          ; AX * DX -> DX:AX
        mov BH, 00
        add AX, BX 
        inc DI          ; puntero en la cadena
        loop seguir_convirtiendo
    retorno_cadenaAnum:
        ret   
    
    Exit:
        PrintText msg_exit_txt 

fin:
.EXIT
END



