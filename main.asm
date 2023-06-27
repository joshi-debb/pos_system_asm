include Macros.asm

.model small
.radix 16
.stack
.data

    ; Mensajes de bienvenida
    minfo   db 0a,"Universidad de San Carlos de Guatemala           "
            db 0a,"Facultad de Ingenieria                           "
            db 0a,"Escuela de Vacaciones                            " 
            db 0a,"Arquitectura de Computadoras y Ensambladores 1   "
            db 0a,"Nombre: Juan Josue Zuleta Beb                    "
            db 0a,"Carne: 202006353                                 ","$"

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
    
    menutools       db 0a," > Herramientas <              "
                    db 0a,"   1. Catalogo Completo        "
                    db 0a,"   2. Productos por Alfabeto   "
                    db 0a,"   3. Reporte de Ventaget_hours        "
                    db 0a,"   4. Productos sin Existencia "
                    db 0a,"   5. Regresar                 ","$"


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
    identifier      db "jzuleta","$"
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
    prod_file   db "PROD.BIN", 00 
    num_price       dw 0000
    num_units       dw 0000
    numero          db 02 dup (30)
    ContadorGlobal  dw 0
    opt_show_prod   db 0a,0a,"[ENTER] si desea continuar, [q] para Salir",0a,"$"
    
    ; eliminar producto
    puntero_temp    dw 0000
    cod_prod_temp   db 05 dup (0)
    ceros           db     2a  dup (0)

    ; structura ventas
    store_code      db 0a," > Codigo  : ","$"
    units_store     db 0a," > Unidades: ","$"
    price_by_unity  db 02 dup (0) 
    bad_code_store  db    "El producto No existe Ingrese Codigo valido","$"
    num_ventas      dw 0000
    fileventas      db    "VENT.BIN", 00 
    handle_ventas   dw 0000

    ;SECCION PARA ALMACENAR DIA , MES ,ANO
    dia db 3 dup("$")
    mes db 3 dup("$")
    anio db 5 dup("$")
    ;almacenar MINUTO , HORA
    hora db 3 dup("$")
    minuto db 3 dup("$")
    TotalVentas   dw    0000
    quest_store   db 0a,0a,"[ENTER] confirmar venta, [q] Cancelar",0a,"$"
    solds db " > Costo de venta:","$"
    tmp_store dw 0
    IncItem db 0

.code

; crear producto
make_prod proc
    insert_product:
        PrintText code_prod
            mov dx , offset buffer_entrada
            mov ah , 0a
            int 21  
            mov DI, offset buffer_entrada
            inc DI 
            mov AL , [DI]
            cmp AL, 05
            jb  g_params
            jmp insert_product
        g_params:
            mov SI, offset cod_prod
            mov DI, offset buffer_entrada
            inc DI
            mov CH, 00
            mov CL, [DI]
            inc DI  
            jmp cp_name
        cp_name:
            mov AL , [DI]
            mov [SI], AL
            inc SI
            inc DI 
            loop cp_name
            jmp trns_code

        trns_code:
            mov DI , offset cod_prod
            jmp check_caracters
        check_caracters:
            mov AL, [DI]
            cmp AL, 00 
            je check_name
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
            jmp check_caracters    
        clear_aux:
            mov DI, offset cod_prod
            mov Cx , 05
            call clean_buffer 
            jmp insert_product
        check_name:
            jmp insert_decpt

        insert_decpt:
            PrintText desc_prod
                mov dx , offset buffer_entrada
                mov ah , 0a
                int 21  
                mov DI, offset buffer_entrada
                inc DI 
                mov AL , [DI]
                cmp AL, 20
                jb  TransicionDES
                jmp insert_decpt
            TransicionDES:
                mov SI, offset cod_desc
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp cp_nameD
            cp_nameD:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop cp_nameD
                mov DI, offset cod_desc
                jmp check_caracters_d
            check_caracters_d:
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
                jmp check_caracters_d
                clear_aux_d:
                    mov DI, offset cod_desc
                    mov Cx , 21
                    call clean_buffer 
                    jmp insert_decpt
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
                jb  g_paramsP
                jmp IngresarPrecio
            g_paramsP:
                mov SI, offset cod_price
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp cp_nameP
            cp_nameP:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop cp_nameP
                mov DI, offset cod_price
                jmp  check_caracters_p    
            check_caracters_p:
                mov AL , [DI]
                cmp AL , 00
                je FINPRICE 
                cmp AL, 22
                je trns_p
                cmp AL, 23
                je trns_p
                cmp AL, 24  
                je trns_p
                cmp AL, 25
                je trns_p
                cmp AL, 26
                je trns_p
                cmp AL, 27
                je trns_p
                cmp AL, 28
                je trns_p
                cmp AL, 29
                je trns_p
                cmp AL, 2A
                je trns_p
                cmp AL, 2B
                je trns_p
                cmp AL, 2C
                je trns_p
                cmp AL, 2D
                je trns_p
                cmp AL, 2E
                je trns_p
                cmp AL, 2F
                je trns_p
                cmp AL, "9"
                ja trns_p
                inc DI
                jmp check_caracters_p
            trns_p:
                    mov DI, offset cod_price
                    mov Cx , 02
                    call clean_buffer 
                    jmp IngresarPrecio
            FINPRICE:
                mov DI, offset cod_price
                call string_to_int
                mov [num_price], AX
                mov DI, offset cod_price
                mov CX, 0002
                call clean_buffer         
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
            jb  g_paramsU
            jmp IngresarUnidades
            g_paramsU:
                mov SI, offset cod_units
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp cp_nameU
            cp_nameU:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop cp_nameU
                mov DI, offset cod_units
                jmp  check_caractersU    
            check_caractersU:
                mov AL , [DI]
                cmp AL , 00
                je FINUNIT 
                cmp AL, 22
                je trns_u
                cmp AL, 23
                je trns_u
                cmp AL, 24  
                je trns_u
                cmp AL, 25
                je trns_u
                cmp AL, 26
                je trns_u
                cmp AL, 27
                je trns_u
                cmp AL, 28
                je trns_u
                cmp AL, 29
                je trns_u
                cmp AL, 2A
                je trns_u
                cmp AL, 2B
                je trns_u
                cmp AL, 2C
                je trns_u
                cmp AL, 2D
                je trns_u
                cmp AL, 2E
                je trns_u
                cmp AL, 2F
                je trns_u
                cmp AL, "9"
                ja trns_u
                inc DI
                jmp check_caractersU
            trns_u:
                mov DI, offset cod_units
                mov Cx , 03
                call clean_buffer 
                jmp IngresarUnidades
            FINUNIT:
                mov DI, offset cod_units
                call string_to_int
                mov [num_units], AX
                mov DI, offset cod_units
                mov CX, 0002
                call clean_buffer 
                jmp add_products
        add_products:           

            call rd_file
            jc CrearFiless 
            jmp sigueRead
            CrearFiless:
                call mk_file                    
            sigueRead:
                mov [handle_prods], AX

                mov BX, [handle_prods]

                mov CX, 00
                mov DX, 00
                mov AL, 02
                mov AH, 42
                int 21

                mov CX, 26
                mov DX, offset cod_prod
                mov AH, 40
                int 21

                mov CX, 0004
                mov DX, offset num_price
                mov AH, 40   
                int 21                 

                mov AH, 3e
                int 21

                jmp Prod_Menu
    ret  
make_prod endp

; mostrar productos
shown_prod proc
    show_prod:
        call rd_file
        mov [handle_prods], AX
        PrintText empty_line_txt
        mov si,0
        loop_show_p:
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

            PrintText viewCabecera
            call PrintText_CODE
            call PrintText_DESC

            cmp si , 05
            jz printt
            
            jmp loop_show_p
        fin_mostrar:
            jmp Prod_Menu
        printt:
            PrintText  opt_show_prod
            EnterOption
            cmp al , 71
            je Prod_Menu
            mov si,0
            ClearScreen
            jmp loop_show_p

    ret
shown_prod endp

; eliminar producto
delete_prod proc
    dele_prod:
        mov DX, 0000
        mov [puntero_temp], DX
        ask_for_code:
        PrintText code_prod
        mov DX, offset buffer_entrada
        mov AH, 0a
        int 21
        mov DI, offset buffer_entrada
        inc DI
        mov AL, [DI]
        cmp AL, 00
        je  ask_for_code
        cmp AL, 05
        jb  accept_code_to_delete  
        jmp ask_for_code
        accept_code_to_delete:
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
            call rd_file
            mov [handle_prods], AX
            ciclo_encontrar:

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

            cmp AX, 0000   
            je end_erase

            mov DX, [puntero_temp]
            add DX, 2a
            mov [puntero_temp], DX

            mov AL, 00
            cmp [cod_prod], AL
            je ciclo_encontrar

            mov SI, offset cod_prod_temp
            mov DI, offset cod_prod
            mov CX, 0005
            call equal_strings
            cmp DL, 0ff
            je erase_product_foud
            jmp ciclo_encontrar
        erase_product_foud:
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
        end_erase:
            mov BX, [handle_prods]
            mov AH, 3e
            int 21
            jmp Prod_Menu
    ret
delete_prod endp

rd_file proc 
    mov ah, 3D   
    mov al, 02       
    mov dx, offset prod_file 
    int 21   
    ret
rd_file endp

mk_file proc 
    mov ah, 3C
    mov cx , 0000      
    mov dx, offset prod_file 
    int 21   
    ret
mk_file endp

clean_buffer:
    loop_memset:
        mov AL, 00
        mov [DI], AL
        inc DI
        loop loop_memset
        ret
clear_buffer proc
    mov countOutBuff, 0
    begin_clear:
        mov bx, countOutBuff
        mov outBuff[bx], 0
        inc countOutBuff
        cmp countOutBuff, 256
        jne begin_clear ; limpia el buffer de salida

    mov countOutBuff, 0
    ret
clear_buffer endp

extract_quote proc
     find_quotes:
        mov bx, countBuff
        mov al, DatosFilename[bx]
        cmp al, quotes
        jne next_char ; si no es comilla, avanza al siguiente caracter
        inc countBuff

    save_char:
        mov bx, countBuff
        mov al, DatosFilename[bx]
        cmp al, quotes
        je end_quotes ; si es comilla, termina la extracción
        mov bx, countOutBuff
        mov outBuff[bx], al
        inc countOutBuff
        inc countBuff
        jmp save_char ; guarda el caracter y avanza al siguiente

    next_char:
        inc countBuff
        mov bx, countBuff
        cmp DatosFilename[bx], "$"
        jne find_quotes ; si no es fin de cadena, busca la siguiente comilla

    end_quotes:
        mov bx, countOutBuff
        mov outBuff[bx], "$" ; agrega fin de cadena
        ret
extract_quote endp

.startup
inicio:   
    deploy_info:
        ClearScreen
        PrintText minfo     
  
    read_datas:  
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
        jmp  get_datas
    get_datas:
        mov countBuff, 0
        call clear_buffer 
        call extract_quote
        xor si,si
        jmp match_user

    match_user:
        mov bh, outBuff[si]
        mov bl, identifier[si]
        cmp bh,bl
        jnz NoIgual
        cmp bh , "$"
        jz  key
        inc si
        jmp match_user
    key:
        inc countBuff
        call clear_buffer 
        call extract_quote

        xor si,si
        jmp match_key
    match_key:
        mov bh, outBuff[si]
        mov bl, password[si]
        cmp bh,bl
        jnz NoIgual
        cmp bh , "$"
        jz Login
        inc si
        jmp match_key
    Login:
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
        EnterOption
        cmp al , 31
        je Prod_Menu
        cmp al , 32
        je sold_Menu
        cmp al , 33
        je tool_menu
        cmp al , 34
        je Exit
        PrintText opt_error_txt 
        jmp Main_Menu
    
    Prod_Menu:
        PrintText menuprod
        PrintText opt_txt
        EnterOption
        cmp al , 31
        je mk_prod
        cmp al , 32
        je dl_prod
        cmp al , 33
        je sw_prod
        cmp al , 34
        je Main_Menu
        jmp Prod_Menu
     
    sold_Menu:
        mov IncItem , 0
        loop_solds:
            cmp IncItem , 0A
            je main_menu
            get_date
            get_hour
            mov DX, 0000
            mov [puntero_temp], DX
            PrintText empty_line_txt
            PrintText solds
            mov AX, [TotalVentas]
            call int_to_stringTotal

            mov BX, 0001
            mov CX, 0005
            mov DX, offset numero
            mov AH, 40
            int 21

        slds_code:
            PrintText store_code
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            mov DI, offset buffer_entrada
            inc DI
            mov AL, [DI]
            cmp AL, 00
            je  slds_code
            cmp AL, 05
            jb  steep1  
            jmp slds_code
        steep1: 
            mov SI, offset cod_prod_temp
            mov DI, offset buffer_entrada
            inc DI
            mov CH, 00
            mov CL, [DI]
            inc DI  
            jmp steep2
        steep2:	
            mov AL, [DI]
            mov [SI], AL
            inc SI
            inc DI
            loop steep2
            jmp ending
        ending:
            mov DI , offset cod_prod_temp
            jmp steep3
        steep3:
            mov AL, [DI]
            cmp AL, 'f'
            je outs1
            jmp steep4
        outs1:
            inc DI
            mov AL, [DI]
            cmp AL , 'i'
            je outs2
        outs2:
            inc DI
            mov AL, [DI]
            cmp AL , 'n'
            je outs3
        outs3:
            mov DI, offset cod_prod_temp
            mov Cx , 05
            call clean_buffer
            jmp main_menu

        steep4:
            call rd_file
            mov [handle_prods], AX
            jmp search_prod
        search_prod:
            ; lectura
            mov BX, [handle_prods]
            mov CX, 05
            mov DX, offset cod_prod
            moV AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 21
            mov DX, offset cod_desc
            moV AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 0002
            mov DX, offset num_price
            moV AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 0002
            mov DX, offset num_units
            moV AH, 3f
            int 21
            ; verifica si llego al fin
            cmp AX, 0000   
            je end_doc
            ; obtengo los bytes recorridos
            mov DX, [puntero_temp]
            add DX, 2a
            mov [puntero_temp], DX
            ;;; verificar si es producto válido
            mov AL, 00
            cmp [cod_prod], AL
            je search_prod

            mov SI, offset cod_prod_temp
            mov DI, offset cod_prod
            mov CX, 0005
            call equal_strings
            cmp DL, 0ff
            je found_prod
            jmp search_prod 

        found_prod:
                jmp ask_prod
        end_doc:
            mov BX, [handle_prods]
            mov AH, 3e
            int 21
            PrintText empty_line_txt
            PrintText empty_line_txt
            PrintText bad_code_store
            PrintText empty_line_txt
            mov DI, offset cod_prod_temp
            mov Cx , 05
            call clean_buffer
            jmp loop_solds

        ask_prod:
            PrintText units_store
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            mov DI, offset buffer_entrada
            inc DI
            mov AL, [DI]
            cmp AL, 00
            je  ask_prod
            cmp AL, 03
            jb  PUNIDADES  
            jmp ask_prod
            PUNIDADES:
                mov SI, offset price_by_unity
                mov DI, offset buffer_entrada
                inc DI
                mov CH, 00
                mov CL, [DI]
                inc DI 
                jmp copy_unit
            copy_unit:
                mov AL , [DI]
                mov [SI], AL
                inc SI
                inc DI 
                loop copy_unit
                jmp ask_up
            ask_up:
                 PrintText quest_store
                 EnterOption
                 cmp al , 71
                 je loop_solds
                 jmp SEGUIRVENTA2

            SEGUIRVENTA2:
                mov DI, offset price_by_unity
                call string_to_int
                mov [num_ventas], AX
                mov DI, offset price_by_unity
                mov CX, 0002
                call clean_buffer 
                jmp prod_update
      prod_update:
                mov DX, [puntero_temp]
		        sub DX, 2a
                mov CX, 0000
                mov BX, [handle_prods]
                mov AL, 00
                mov AH, 42
                int 21

                mov CX, 05
                mov DX, offset cod_prod
                mov AH, 40
                int 21

                mov CX, 21
                mov DX, offset cod_desc
                mov AH, 40
                int 21
                
                mov CX, 0002
                mov DX, offset num_price
                mov AH, 40
                int 21
                ; resta unidades
                mov ax , num_ventas
                sub num_units , ax
                mov CX, 0002
                mov DX, offset num_units
                mov AH, 40
                int 21
                ; multiplica
                ; copio la variable para guardarla
                mov ax , num_ventas
                mov tmp_store , ax

                mov ax , tmp_store
                mov bx , num_price
                mul bx
                mov tmp_store , ax

                mov ax , tmp_store
                add TotalVentas , ax

                mov BX, [handle_prods]
                mov AH, 3e
                int 21

                jmp do_store
    
    do_store:
        ; abrir archivo VENT.BIN
        mov ah, 3D   
        mov al, 02       
        mov dx, offset fileventas 
        int 21  
        jc existeVenta 
        jmp sigueReadV
        ; si no existe lo crea
        existeVenta:
            mov ah, 3C
            mov cx , 0000      
            mov dx, offset fileventas 
            int 21                   
        sigueReadV:
            mov [handle_ventas], AX
            mov BX, [handle_ventas]

            mov CX, 00 
            mov DX, 00
            mov AL, 02
            mov AH, 42
            int 21

            mov CX, 021
            mov DX, offset cod_desc
            mov AH, 40
            int 21

            mov CX, 02
            mov DX, offset dia
            mov AH, 40
            int 21

            mov CX, 02
            mov DX, offset mes
            mov AH, 40
            int 21

            mov CX, 04
            mov DX, offset anio
            mov AH, 40
            int 21

            mov CX, 02
            mov DX, offset hora
            mov AH, 40
            int 21

            mov CX, 02
            mov DX, offset minuto
            mov AH, 40
            int 21
           
            mov CX, 05
            mov DX, offset cod_prod
            mov AH, 40
            int 21

            mov CX, 0002
            mov DX, offset num_ventas
            mov AH, 40   
            int 21    
            ;; cerrar archivo
            mov AH, 3e
            int 21
            Inc IncItem
            jmp loop_solds

    tool_menu:
        PrintText menutools
        EnterOption
        cmp al , 31
        je main_menu
        cmp al , 32
        je sold_menu
        cmp al , 33
        je tool_menu
        cmp al , 34
        je Exit
        cmp al , 35
        je main_menu
        PrintText opt_error_txt 
        jmp tool_menu

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
        jmp Exit 
       
    bool_NoExiste:
               jmp Exit 


equal_strings:
loop_equal_strings:
		mov AL, [SI]
		cmp [DI], AL
		jne no_son_iguales
		inc DI
		inc SI
		loop loop_equal_strings
		mov DL, 0ff
		ret
no_son_iguales:	mov DL, 00
		ret

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

		PrintText cod_prod
		PrintText empty_line_txt

        PrintText empty_line_txt
        PrintText empty_line_txt
		ret



PrintText_CODE:
		mov DI, offset cod_prod
place_dollar_c:
		mov AL, [DI]
		cmp AL, 00
		je place_dollar_code
		inc DI
		jmp place_dollar_c
place_dollar_code:
		mov AL, 24  ;; dólar
		mov [DI], AL
        ; PrintText viewCabecera
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
        PrintText empty_line_txt
		ret



int_to_string:
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
		mov BL, 30     ; poner en '0' el actual
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

int_to_stringTotal:
		mov CX, 0005
		mov DI, offset numero
ciclo_poner30sTotal:
		mov BL, 30
		mov [DI], BL
		inc DI
		loop ciclo_poner30sTotal

		mov CX, AX    ; inicializar contador
		mov DI, offset numero
		add DI, 0004
		;;
loop_int_to_string:
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je loop_inc
		loop loop_int_to_string
		jmp rtrn_int_to_string
loop_inc:
		push DI
aumentar_siguiente_digitoTotal:
		mov BL, 30     ; poner en '0' el actual
		mov [DI], BL
		dec DI         ; puntero a la cadena
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je aumentar_siguiente_digitoTotal
		pop DI         ; se recupera DI
		loop ciclo_convertirAcadena
rtrn_int_to_string:
		ret


string_to_int:
		mov AX, 0000    ; inicializar la salida
		mov CX, 0002    ; inicializar contador

seguir_convirtiendo:
		mov BL, [DI]
		cmp BL, 00
		je retorno_string_to_int
		sub BL, 30      ; BL es el valor numérico del caracter
		mov DX, 000a
		mul DX          ; AX * DX -> DX:AX
		mov BH, 00
		add AX, BX 
		inc DI          ; puntero en la cadena
		loop seguir_convirtiendo
retorno_string_to_int:
		ret   

     Exit:
        PrintText empty_line_txt
        PrintText msg_exit_txt
        PrintText empty_line_txt
fin:
.exit
end



