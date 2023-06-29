include Macros.asm

.model small
.radix 16
.stack
.data

    ; Mensajes de bienvenida
    minfo           db 0a,"Universidad de San Carlos de Guatemala           "
                    db 0a,"Facultad de Ingenieria                           "
                    db 0a,"Escuela de Vacaciones                            " 
                    db 0a,"Arquitectura de Computadoras y Ensambladores 1   "
                    db 0a,"                                                 "
                    db 0a,"Nombre: Juan Josue Zuleta Beb                    "
                    db 0a,"Carne: 202006353                                 ","$"

    ; credenciales
    identifier      db "jzuleta","$"
    password        db "202006353","$"

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
                    db 0a,"   3. Reporte de Ventas        "
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
    msg_exit_txt    db 0a," > Ejecucion Terminada",24
    logged_txt      db " > Bienvenido!",0a,0a,0a,"$"
    press_enter_txt db "[ENTER] para continuar","$"

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
    prod_file       db "PROD.BIN", 00 
    num_price       dw 0000
    num_units       dw 0000
    numero          db 02 dup (30)
    ContadorGlobal  dw 0
    opt_show_prod   db 0a,0a,"[ENTER] si desea continuar, [q] para Salir",0a,"$"
    
    ; eliminar producto
    puntero_temp    dw 0000
    cod_prod_temp   db 05 dup (0)
    ceros           db 2a  dup (0)

    ; structura ventas
    store_code      db 0a," > Codigo  : ","$"
    units_store     db 0a," > Unidades: ","$"
    price_by_unity  db 02 dup (0) 
    bad_code_store  db "    Producto no encontrado","$"
    bad_code_insert db "    Producto ya existente","$"
    num_ventas      dw 0000
    fileventas      db "VENT.BIN", 00 
    handle_ventas   dw 0000
    handle_reps     dw 0000
    handle_falta    dw 0000
    handle_archivo  dw 0000
    cnt_a           dw 0000
    cnt_b           dw 0000
    cnt_c           dw 0000
    cnt_d           dw 0000
    cnt_e           dw 0000
    cnt_f           dw 0000
    cnt_g           dw 0000
    cnt_h           dw 0000
    cnt_i           dw 0000
    cnt_j           dw 0000
    cnt_k           dw 0000
    cnt_l           dw 0000
    cnt_m           dw 0000
    cnt_n           dw 0000
    cnt_o           dw 0000
    cnt_p           dw 0000
    cnt_q           dw 0000
    cnt_r           dw 0000
    cnt_s           dw 0000
    cnt_t           dw 0000
    cnt_u           dw 0000
    cnt_v           dw 0000
    cnt_w           dw 0000
    cnt_x           dw 0000
    cnt_y           dw 0000
    cnt_z           dw 0000

    caracter db ?

    dia             db 3 dup("$")
    mes             db 3 dup("$")
    anio            db 5 dup("$")
    hora            db 3 dup("$")
    minuto          db 3 dup("$")
    TotalVentas     dw 0000
    quest_store     db 0a,0a,"[ENTER] confirmar venta, [q] Cancelar",0a,"$"
    solds           db " > Total:","$"
    tmp_store       dw 0
    IncItem         db 0

    nombre_rep1     db "CATALG.HTM",00
    nombre_rep2     db "ABC.HTM",00
    nombre_rep3     db "FALTA.HTM",00

    ;REPORTE DE VENTAS CATALOGO
    head_html       db "<html><head></head><body>"
    init_table      db '<table border="1"><tr><td>codigo</td><td>descripcion</td><td>Precio</td><td>Cantidad</td></tr>'
    init_table2     db '<table border="1"><tr><td>codigo</td><td>descripcion</td><td>Precio</td></tr>'
    init_abc_t      db '<table border="1"><tr><td>Letra</td><td>Cantidad</td></tr>'
    close_t         db "</table>"
    f_html          db "</body></html>"
    td_html         db "<td>"
    tdc_html        db "</td>"
    tr_html         db "<tr>"
    trc_html        db "</tr>"
    p_html          db "<p>"
    pc_html         db "</p>"
    msg_hora        db "Fecha: "
    dos_puntos      db ":" 
    guion           db "-"
    diagonal        db "/" 
    l_a             db "A","$"
    l_b             db "B","$"
    l_c             db "C","$"
    l_d             db "D","$"
    l_e             db "E","$"
    l_f             db "F","$"
    l_g             db "G","$"
    l_h             db "H","$"
    l_i             db "I","$"
    l_j             db "J","$"
    l_k             db "K","$"
    l_l             db "L","$"
    l_m             db "M","$"
    l_n             db "N","$"
    l_o             db "O","$"
    l_p             db "P","$"
    l_q             db "Q","$"
    l_r             db "R","$"
    l_s             db "S","$"
    l_t             db "T","$"
    l_u             db "U","$"
    l_v             db "V","$"
    l_w             db "W","$"
    l_x             db "X","$"
    l_y             db "Y","$"
    l_z             db "Z","$"

.code

gene_catg proc
    generate_report_1: 
        PrintText empty_line_txt
        PrintText empty_line_txt
            get_date
            get_hour
    
            mov ah, 2         ; Función de impresión del carácter
            int 21h   
            mov AH, 3c
            mov CX, 0000
            mov DX, offset nombre_rep1
            int 21
            mov [handle_reps], AX
            mov BX, AX
            mov AH, 40
            mov CH, 00
            mov CL, lengthof head_html
            mov DX, offset head_html
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, lengthof init_table
            mov DX, offset init_table
            int 21
            ;;
            mov AL, 02
            mov AH, 3d
            mov DX, offset prod_file
            int 21
            ;;
            mov [handle_prods], AX
    ciclo_mostrar_rep1:
        mov BX, [handle_prods]
        mov CX, 05
        mov DX, offset cod_prod
        mov AH,3F
        int 21
        mov BX, [handle_prods]
        mov CX, 21
        mov DX, offset cod_desc
        mov AH, 3F
        int 21
        mov BX, [handle_prods]
        mov CX, 02
        mov DX, offset num_price
        mov AH, 3F
        int 21

        mov BX, [handle_prods]
        mov CX, 02
        mov DX, offset num_units
        mov AH, 3F
        int 21
        cmp AX, 00
        je end_show_rep1
        mov AL, 00
        cmp [cod_prod], AL
        je ciclo_mostrar_rep1
        call print_html_struct
        jmp ciclo_mostrar_rep1

    print_html_struct:
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset tr_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ;;
            mov DX, offset cod_prod
            mov SI, 0000
    loop_write_code:
            mov DI, DX
            mov AL, [DI]
            cmp AL, 00
            je write_desc
            cmp SI, 0006
            je write_desc
            mov CX, 0001
            mov BX, [handle_reps]
            mov AH, 40
            int 21
            inc DX
            inc SI
            jmp loop_write_code
    write_desc:
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ;;
            mov DX, offset cod_desc
            mov SI, 0000
    loop_write_desc:
            mov DI, DX
            mov AL, [DI]
            cmp AL, 00
            je write_price
            cmp SI, 0021
            je write_price
            mov CX, 0001
            mov BX, [handle_reps]
            mov AH, 40
            int 21
            inc DX
            inc SI
            jmp loop_write_desc
            ;;
    write_price:
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ;;
            mov AX, [num_price]
            call int_to_string
            mov BX, 0000
            mov CX, 0002
            mov DX, offset numero
            mov SI, 0000
    loop_write_price:
            mov DI, DX
            mov AL, [DI]
            cmp AL, 00
            je loop_write_unit
            cmp SI, 02
            je loop_write_unit
            mov CX, 0001
            mov BX, [handle_reps]
            mov AH, 40
            int 21
            inc DX
            inc SI
            jmp loop_write_price
            ;;
    loop_write_unit:
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset td_html
            int 21
            ;;
            ;; mandar a llamar el metodo de Num a cadena
            mov AX, [num_units]
            call int_to_string
            mov BX, 0000
            mov CX, 0002

            mov DX, offset numero
            
            mov SI, 0000
    loop_write_units:
            mov DI, DX
            mov AL, [DI]
            cmp AL, 00
            je close_tags
            cmp SI, 02
            je close_tags
            mov CX, 0001
            mov BX, [handle_reps]
            mov AH, 40
            int 21
            inc DX
            inc SI
            jmp loop_write_units
    close_tags:
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset tdc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset trc_html
            int 21
            ;;
            ret
    end_show_rep1:
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, lengthof close_t
            mov DX, offset close_t
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 03
            mov DX, offset p_html
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset msg_hora
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset dos_puntos
            int 21


            ;; escribir fecha
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset dia
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset diagonal
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset mes
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset diagonal
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset anio
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset guion
            int 21

            ;; escribir hora;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset hora
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset dos_puntos
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset minuto
            int 21

            ;; cerrar hora
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset pc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, lengthof f_html

            mov DX, offset f_html
            int 21
            ;;
            mov AH, 3e
            int 21
            jmp tool_menu

gene_catg endp

gene_abcd proc
    generate_report_2:
        mov AL, 02
        mov AH, 3D
        mov DX, offset prod_file
        int 21
        mov [handle_prods], AX
        mov SI,0
        mov cnt_a , 0000
        mov cnt_b , 0000
        mov cnt_c , 0
        mov cnt_d , 0
        mov cnt_e , 0
        mov cnt_f , 0
        mov cnt_g , 0
        mov cnt_h , 0
        mov cnt_i , 0
        mov cnt_j , 0
        mov cnt_k , 0
        mov cnt_l , 0
        mov cnt_m , 0
        mov cnt_n , 0
        mov cnt_o , 0
        mov cnt_p , 0
        mov cnt_q , 0
        mov cnt_r , 0
        mov cnt_s , 0
        mov cnt_t , 0
        mov cnt_u , 0
        mov cnt_v , 0
        mov cnt_w , 0
        mov cnt_x , 0
        mov cnt_y , 0
        mov cnt_z , 0

    loop_search_abc:
    inc SI
        mov BX, [handle_prods]
        mov CX, 05
        mov DX, offset cod_prod
        mov AH,3F
        int 21
        mov BX, [handle_prods]
        mov CX, 21
        mov DX, offset cod_desc
        mov AH, 3F
        int 21
        mov BX, [handle_prods]
        mov CX, 0002
        mov DX, offset num_price
        mov AH, 3F
        int 21
        mov BX, [handle_prods]
        mov CX, 0002
        mov DX, offset num_units
        mov AH, 3F
        int 21
        cmp AX, 0000
        je end_show_1
            ;; ver si es producto válido
        mov AL, 00
        cmp [cod_prod], AL
        je loop_search_abc
        
        ;; producto en estructura
        call search_1
        jmp loop_search_abc

    search_1:
        mov DI, offset cod_desc
    loop_search_letter:
        mov Al, [DI]
        inc DI 
        mov Al, 24
        mov[DI], AL
        mov AL, cod_desc
        cmp AL, 41
        je plus_a
        cmp AL, 42
        je plus_b
        cmp AL, 43
        je plus_c
        cmp AL, 44
        je plus_d
        cmp AL, 45
        je plus_e
        cmp AL, 46
        je plus_f
        cmp AL, 47
        je plus_g
        cmp AL, 48
        je plus_h
        cmp AL, 49
        je plus_i
        cmp AL, 4A
        je plus_j
        cmp AL, 4B
        je plus_k
        cmp AL, 4C
        je plus_l
        cmp AL, 4D
        je plus_m
        cmp AL, 4E
        je plus_n
        cmp AL, 4F
        je plus_o
        cmp AL, 50
        je plus_p
        cmp AL, 51
        je plus_q
        cmp AL, 52
        je plus_r
        cmp AL, 53
        je plus_s
        cmp AL, 54
        je plus_t
        cmp AL, 55
        je plus_u
        cmp AL, 56
        je plus_v
        cmp AL, 57
        je plus_w
        cmp AL, 58
        je plus_x
        cmp AL, 59
        je plus_y
        cmp AL, 5A
        je plus_z
        ;; minusculas
        cmp AL, 61
        je plus_a
        cmp AL, 62
        je plus_b
        cmp AL, 63
        je plus_c
        cmp AL, 64
        je plus_d
        cmp AL, 65
        je plus_e
        cmp AL, 66
        je plus_f
        cmp AL, 67
        je plus_g
        cmp AL, 68
        je plus_h
        cmp AL, 69
        je plus_i
        cmp AL, 6A
        je plus_j
        cmp AL, 6B
        je plus_k
        cmp AL, 6C
        je plus_l
        cmp AL, 6D
        je plus_m
        cmp AL, 6E
        je plus_n
        cmp AL, 6F
        je plus_o
        cmp AL, 70
        je plus_p
        cmp AL, 71
        je plus_q
        cmp AL, 72
        je plus_r
        cmp AL, 73
        je plus_s
        cmp AL, 74
        je plus_t
        cmp AL, 75
        je plus_u
        cmp AL, 76
        je plus_v
        cmp AL, 77
        je plus_w
        cmp AL, 78
        je plus_x
        cmp AL, 79
        je plus_y
        cmp AL, 7A
        je plus_z

        jmp loop_search_abc

    plus_a:
        ;; plus a cnt_a
        inc cnt_a

    
        jmp loop_search_abc
    plus_b:
        inc cnt_b
        jmp loop_search_abc
    plus_c:
        inc cnt_c
        jmp loop_search_abc
    plus_d:
        inc cnt_d
        jmp loop_search_abc
    plus_e:
        inc cnt_e
        jmp loop_search_abc
    plus_f:
        inc cnt_f
        jmp loop_search_abc
    plus_g:
        inc cnt_g
        jmp loop_search_abc
    plus_h:
        inc cnt_h
        jmp loop_search_abc
    plus_i:
        inc cnt_i
        jmp loop_search_abc
    plus_j:
        inc cnt_j
        jmp loop_search_abc
    plus_k:
        inc cnt_k
        jmp loop_search_abc
    plus_l:
        inc cnt_l
        jmp loop_search_abc
    plus_m:
        inc cnt_m
        jmp loop_search_abc
    plus_n:
        inc cnt_n
        jmp loop_search_abc
    plus_o:
        inc cnt_o
        jmp loop_search_abc
    plus_p:
        inc cnt_p
        jmp loop_search_abc
    plus_q: 
        inc cnt_q
        jmp loop_search_abc
    plus_r:
        inc cnt_r
        jmp loop_search_abc
    plus_s:
        inc cnt_s
        jmp loop_search_abc
    plus_t:
        inc cnt_t
        jmp loop_search_abc
    plus_u: 
        inc cnt_u
        jmp loop_search_abc
    plus_v:
        inc cnt_v
        jmp loop_search_abc
    plus_w:
        inc cnt_w
        jmp loop_search_abc
    plus_x:
        inc cnt_x
        jmp loop_search_abc
    plus_y:
        inc cnt_y
        jmp loop_search_abc
    plus_z:
        inc cnt_z
        jmp loop_search_abc

    end_show_1:
        ;; imprimir cnt_j
    jmp make_html_abc


    make_html_abc:
        mov numero , 0000
        get_hour
        get_date
        mov ah, 2
        int 21h
        mov AH, 3C
        mov CX, 0000
        MOV dx, offset nombre_rep2
        int 21
        mov [handle_reps], AX
        mov BX,AX
        mov AH, 40
        mov CH, 00
        mov CL, lengthof head_html
        mov DX, offset head_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, lengthof init_abc_t
        mov DX, offset init_abc_t
        int 21

    ; A

    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_a
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_a]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
     ; B
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_b
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_b]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; C

    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_c
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_c]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; D
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_d
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_d]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; E
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_e
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_e]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; F
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_f
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_f]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; G
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_g
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_g]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; H
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_h
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_h]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; I
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_i
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_i]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; J
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_j
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_j]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; K
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_k
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_k]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; L
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_l
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_l]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; M
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_m
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_m]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; N
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_n
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_n]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; O
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_o
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_o]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; P
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_p
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_p]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; Q
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_q
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_q]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; R
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_r
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_r]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; S
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_s
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_s]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21

    ; T
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_t
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_t]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; U
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_u
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_u]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; V
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_v
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_v]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; W
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_w
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_w]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; X
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_x
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_x]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; Y
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_y
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_y]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ; Z
    mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset l_z
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [cnt_z]
        call int_to_string
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset numero
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        mov BX, [handle_reps]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
    
    ;LETRAS

    fin_mostrar_rep2:
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, lengthof close_t
            mov DX, offset close_t
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 03
            mov DX, offset p_html
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 05
            mov DX, offset msg_hora
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset dos_puntos
            int 21


            ;; escribir fecha
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset dia
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset diagonal
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset mes
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 01
            mov DX, offset diagonal
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset anio
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset guion
            int 21

            ;; escribir hora;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset hora
            int 21

            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL , 01
            mov DX, offset dos_puntos
            int 21
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 02
            mov DX, offset minuto
            int 21

        
    
    
            ;; cerrar hora
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, 04
            mov DX, offset pc_html
            int 21
            ;;
            mov BX, [handle_reps]
            mov AH, 40
            mov CH, 00
            mov CL, lengthof f_html
            mov DX, offset f_html
            int 21
            ;;
            mov AH, 3e
            int 21
            jmp tool_menu
gene_abcd endp

gene_noex proc
    generate_report_3:
        get_hour
        get_date
		mov AH, 3c
		mov CX, 0000
		mov DX, offset nombre_rep3
		int 21
		mov [handle_falta], AX
		mov BX, AX
		mov AH, 40
		mov CH, 00
		mov CL, lengthof head_html
		mov DX, offset head_html
		int 21
		mov BX, [handle_falta]
		mov AH, 40
		mov CH, 00
		mov CL, lengthof init_table2
		mov DX, offset init_table2
		int 21
		;;
		mov AL, 02
		mov AH, 3d
		mov DX, offset prod_file
		int 21
		;;
		mov [handle_prods], AX

    loop_report_f:
        mov BX, [handle_prods]
        mov CX, 05    ;; leer 
        mov DX, offset cod_prod
        mov AH, 3f
        int 21

        mov BX, [handle_prods]
        mov CX, 21
        mov DX, offset cod_desc
        mov AH, 3f
        int 21

        mov BX, [handle_prods]
        mov CX, 0002
        mov DX, offset num_price
        mov AH, 3f
        int 21

        mov BX, [handle_prods]
        mov CX, 0002
        mov DX, offset num_units
        mov AH, 3f
        int 21
        
        cmp AX, 00
        je end_loop_report_f
        
        mov AL, 00
        cmp [cod_prod], AL
        je loop_report_f

        cmp word ptr [num_units], 0
        jz call_to_print_report
        jmp loop_report_f
    call_to_print_report:
        call print_body_f
        jmp loop_report_f
    end_loop_report_f:
        get_date
        get_hour

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 03
        mov DX, offset p_html
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset pc_html
        int 21
        
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 03
        mov DX, offset p_html
        int 21
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset msg_hora
        int 21
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL , 01
        mov DX, offset dos_puntos
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset dia
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset diagonal
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset mes
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 01
        mov DX, offset diagonal
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset anio
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL , 01
        mov DX, offset guion
        int 21

        ;; escribir hora;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset hora
        int 21

        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL , 01
        mov DX, offset dos_puntos
        int 21
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 02
        mov DX, offset minuto
        int 21

        ;; cerrar hora
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset pc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, lengthof f_html
        mov DX, offset f_html
        int 21
    
        ;;
        mov AH, 3e
        int 21
        ClearScreen
        PrintText empty_line_txt
        jmp tool_menu
    print_body_f: 
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset tr_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        ;;
        mov DX, offset cod_prod
        mov SI, 0000
    loop_write_code_f:
        mov DI, DX
        mov AL, [DI]
        cmp AL, 00
        je write_name_f
        cmp SI, 05
        je write_name_f
        mov CX, 0001
        mov BX, [handle_falta]
        mov AH, 40
        int 21
        inc DX
        inc SI
        jmp loop_write_code_f

    write_name_f:
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        ;;
        mov DX, offset cod_desc
        mov SI, 0000
    loop_write_name_f:
        mov DI, DX
        mov AL, [DI]
        cmp AL, 00
        je write_price_f
        cmp SI, 21
        je write_price_f
        mov CX, 0001
        mov BX, [handle_falta]
        mov AH, 40
        int 21
        inc DX
        inc SI
        jmp loop_write_name_f

    write_price_f:
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
        mov AX, [num_price]
        call int_to_string
        mov BX, 0000
        mov CX, 0002
        mov DX, offset numero
        mov SI, 0000

    loop_write_price_f:
        mov DI, DX
        mov AL, [DI]
        cmp AL, 00
        je write_unit_f
        cmp SI, 0002
        je write_unit_f
        mov CX, 0001
        mov BX, [handle_falta]
        mov AH, 40
        int 21
        inc DX
        inc SI
        jmp loop_write_price_f
    write_unit_f:
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 04
        mov DX, offset td_html
        int 21
    
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset tdc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, 05
        mov DX, offset trc_html
        int 21
        ;;
        mov BX, [handle_falta]
        mov AH, 40
        mov CH, 00
        mov CL, lengthof f_html
        mov DX, offset f_html
        int 21

        ret
    
gene_noex endp

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
        
        
        call rd_file
        jc insert_decpt
        mov [handle_prods], AX
        loop_to_found_code:
            mov BX, [handle_prods]
            mov CX, 5
            mov DX, offset cod_prod_temp
            mov AH, 3fh
            int 21
            mov BX, [handle_prods]
            mov CX, 21
            mov DX, offset cod_desc
            mov AH, 3fh
            int 21
            mov BX, [handle_prods]
            mov CX, 4
            mov DX, offset num_price
            mov AH, 3fh
            int 21
            cmp AX, 0000
            je c_not_found
            mov AL, 00
            cmp [cod_prod_temp], AL
            je loop_to_found_code
            mov SI, offset cod_prod_temp
            mov DI, offset cod_prod
            mov CX, 0004
            call equal_strings
            cmp DL, 0ff
            je code_found
            mov DI, offset cod_prod_temp
            mov CX , 5
            call clear_buffer
            jmp loop_to_found_code
        code_found:
            mov BX, [handle_prods]
            mov AH, 3eh
            int 21
            PrintText bad_code_insert
            jmp insert_product

        c_not_found:
            mov BX, [handle_prods]
            mov AH, 3eh
            int 21

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

; ventas
make_vent proc

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
            jb  punits  
            jmp ask_prod
            punits:
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
                    jmp seguirv2

            seguirv2:
                mov DI, offset price_by_unity
                call string_to_int
                mov [num_ventas], AX
                mov DI, offset price_by_unity
                mov CX, 0002
                call clean_buffer 
                ; jmp prod_update

                mov AX, num_ventas
                cmp AX, num_units
                ja loop_solds

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

make_vent endp

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

        loop_to_found_to_delete:
        mov BX, [handle_prods]
        mov CX, 26
        mov DX, offset cod_prod
        mov AH, 3fh
        int 21
        mov BX, [handle_prods]
        mov CX, 4
        mov DX, offset num_price
        mov AH, 3fh
        int 21
        cmp AX, 0000
        je not_found
        mov DX, [puntero_temp]
        add DX, 2ah
        mov [puntero_temp], DX
        mov AL, 00
        cmp [cod_prod], AL
        je loop_to_found_to_delete
        mov SI, offset cod_prod_temp
        mov DI, offset cod_prod
        mov CX, 0005
        call equal_strings
        cmp DL, 0ff
        je del_not_found
        jmp loop_to_found_to_delete
    del_not_found:
        mov DX, [puntero_temp]
        sub DX, 2ah
        mov CX, 0000
        mov BX, [handle_prods]
        mov AL, 00
        mov AH, 42
        int 21
        mov CX, 2ah
        mov DX, offset ceros
        mov AH, 40
        int 21
        mov BX, [handle_prods]
        mov AH, 3eh
        int 21
        jmp Prod_Menu

    not_found:
        mov BX, [handle_prods]
        mov AH, 3eh
        int 21
        PrintText empty_line_txt
        PrintText bad_code_store
        EnterOption
        jmp Prod_Menu

    ret
delete_prod endp

;login
proce_login proc
    deploy_info:
        ClearScreen
        PrintText minfo
    mov AH, 3Dh 
    mov AL, 0              
    mov DX, OFFSET filename
    int 21h             
    mov [handle_archivo], AX
    jmp read_as_char

    read_as_char:

    mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], '[' 
        jne error_credenciales
    
    mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'c' 
        jne error_credenciales 

    mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'r' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'e' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'd' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'e' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'n' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'c' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'i' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'a' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'l' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'e' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 's' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], ']' 
        jne error_credenciales 

    
        mov AH, 3Fh        
        mov BX, [handle_archivo]
        mov CX, 1        
        mov DX, OFFSET caracter 
        int 21h           
        cmp AX, 0          
        je end_of_read  
        jmp jump_of_line


    next_line:
    
        cmp [caracter], 'u'
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 's' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'u' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'a' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'r' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'i' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'o' 
        jne error_credenciales 

    jump_1: 
        mov AH, 3Fh     
        mov BX, [handle_archivo] 
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0
        je end_of_read
        cmp [caracter], '='
        je next
        jmp jump_of_line2

    next:

        mov AH, 3Fh    
        mov BX, [handle_archivo] 
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0
        je end_of_read
        cmp [caracter], '"'
        je next2
        jmp jump_of_line3

    next2:
        mov AH, 3Fh       
        mov BX, [handle_archivo] 
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0
        je end_of_read
        cmp [caracter], '"'
        je next3
        jmp jump_of_line3

    next3: 
        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1        
        mov DX, OFFSET caracter 
        int 21h           
        cmp AX, 0          
        je end_of_read  
        jmp jump_of_line4

    next4:
        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'l' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'a' 
        jne error_credenciales 

        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'v' 
        jne error_credenciales 


        mov AH, 3Fh      
        mov BX, [handle_archivo] 
        mov CX, 1         
        mov DX, OFFSET caracter
        int 21h           
        cmp AX, 0        
        je end_of_read     
        cmp [caracter], 'e' 
        jne error_credenciales 

        jmp jump_1


        jmp end_of_read
        jmp read_as_char 

    jump_of_line:
        mov AH, 3Fh       
        mov BX, [handle_archivo] 
        mov CX, 1        
        mov DX, OFFSET caracter 
        int 21h           
        cmp AX, 0          
        je end_of_read    
        cmp [caracter], 'u'
        je next_line
    
        jmp jump_of_line

    jump_of_line2:
        mov AH, 3Fh
        mov BX, [handle_archivo]
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0
        
        je end_of_read    
        cmp [caracter], '='
        je next
        cmp [caracter], 20
        jne error_credenciales
        jmp jump_of_line2
    jump_of_line3:
        mov AH, 3Fh
        mov BX, [handle_archivo]
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0          
        je end_of_read    
        cmp [caracter], '"'
        je next3
        jmp jump_of_line3
    jump_of_line4:
        mov AH, 3Fh
        mov BX, [handle_archivo]
        mov CX, 1
        mov DX, OFFSET caracter
        int 21h
        cmp AX, 0          
        je end_of_read    
        cmp [caracter], 'c'
        je next4
        jmp jump_of_line4

    end_of_read:
        ; Cierre del archivo
        mov AH, 3Eh  
        mov BX, AX   
        INT 21h    
  
    read_datas:  
        ; abrir archivo
        mov ah, 3D   
        mov al, 00       
        mov dx, offset filename 
        int 21    
        jc Exit 
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
        jnz Exit
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
        jnz Exit
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
proce_login endp

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

error_credenciales:
    PrintText empty_line_txt
    PrintText msg_exit_txt
    PrintText empty_line_txt
    jmp fin

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
    cmp AX, 00
    je retorno_convertirAcadena

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


.startup
inicio:   
    
    call proce_login

    Main_Menu:
        ClearScreen
        PrintText mainmenu
        PrintText opt_txt
        EnterOption
        cmp al , 31
        je Prod_Menu
        cmp al , 32
        je mk_slds
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

    tool_menu:
        PrintText menutools
        PrintText opt_txt
        EnterOption
        cmp al , 31
        je mk_cat
        cmp al , 32
        je mk_abc
        cmp al , 33
        je Main_Menu
        cmp al , 34
        je mk_noe
        cmp al , 35
        je Main_Menu
        PrintText opt_error_txt 
        jmp tool_menu

    mk_slds:
        ClearScreen
        call make_vent
        ClearScreen
        jmp Main_Menu

    mk_cat:
        ClearScreen
        call gene_catg
        ClearScreen
        jmp tool_menu

    mk_abc:
        ClearScreen
        call gene_abcd
        ClearScreen
        jmp tool_menu

    mk_noe:
        ClearScreen
        call gene_noex
        ClearScreen
        jmp tool_menu
    
    mk_prod:
        ClearScreen
        call make_prod
        ClearScreen
        jmp Prod_Menu
    
    sw_prod:
        ClearScreen
        call shown_prod
        EnterOption
        jmp Prod_Menu
    
    dl_prod:
        ClearScreen
        call delete_prod
        ClearScreen
        jmp Prod_Menu

    Exit:
        PrintText empty_line_txt
        PrintText msg_exit_txt
        PrintText empty_line_txt
fin:
.exit
end



