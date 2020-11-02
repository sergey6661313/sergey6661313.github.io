;# ScalpiLang (02.11.2020)
;TODO чтение исходника

;def t_slice
  ;def start
    _t_slice•_start = 0
  
  ;def end
    _t_slice•_end   = 8
  
  _t_slice•__size = 16



;fn start
  label start
    namespace .
    SUB RSP, to_link_ret

  ;var resault
    _resault equ local_1

  ;-> get_input_file_name           => resault
    call _get_input_file_name
    mov [_resault], rax
  
  ;TODO -> чтение исходника         => resault
  
  
  ;TODO -> компиляция               => resault
  
  
  ;TODO -> сохранить                => resault

  ;debug_text, 'resault -> 'msvcrt\printf
    lea rcx, [_debug_text]
    mov rdx, rax
    call [_msvcrt•_printf]

  ;return -> PrintLastError 
    call _PrintLastError
    jmp __ret

  ;val debug_text "programm finish with %u" 10 13 0
    label _debug_text
      db "programm finish with %u", 10, 13, 0
  
  label __ret
    ADD RSP, to_link_ret
    ret
    end namespace



;fn PrintLastError
  label _PrintLastError
    namespace .
    SUB RSP, to_link_ret

  ;var last_error
    last_error equ local_1    

  ;~> 'Kernel32\GetLastError => last_error
    ;~> 'Kernel32\GetLastError 
      call [_Kernel32•_GetLastError]
      
    ;=> last_error
      mov [last_error], rax

  ;text_get_last_error, last_error, ~> printf
    ;text_get_last_error, 
      lea rax, [text_get_last_error] 
      mov [argument_1], rax

    ;last_error, 
      mov rax, [last_error] 
      mov [argument_2], rax
    
    ;~> 'msvcrt\printf
        mov rcx, [argument_1]
        mov rdx, [argument_2]
        call [_msvcrt•_printf]

  ;return 1
    mov rax, [last_error]

  label __ret
    add RSP, to_link_ret
    ret

  ;var text_get_last_error 10 13 "last error: %u" 10 13 0
      label text_get_last_error
        db 10, 13, "last error: %u", 10, 13, 0    

  end namespace



;fn get_input_file_name
  label _get_input_file_name
    namespace .
    SUB RSP, to_link_ret

  ;var p_command_line
    _p_command_line equ  local_1
  
  ;var resault
    _resault equ local_2

  ;# пробуем получить имя фаила из коммандной строки
  ;-> 'Kernel32\GetCommandLineA => p_command_line
    call [_Kernel32•_GetCommandLineA]
    mov [_p_command_line], rax
  
  ;'p_command_line, text_command_line, -> copy_symbols
    mov rcx, [_p_command_line]
    lea rdx, [_text_command_line]
    call _copy_symbols
  
  ;debug_text2, text_command_line, -> 'msvcrt\printf
    lea rcx, [_debug_text2]
    mov rdx, [_p_command_line] 
    call [_msvcrt•_printf]

  ;text_command_line -> parse_find_input_name => resault
    lea rcx, [_text_command_line] 
    call _parse_find_input_name 
    mov [_resault], rax
  
  ;# Если не получилось до берём им по умолчанию
  ;if 'resault != 1 #copy default symbols
    label __if_1
      namespace .
      mov rax, [_resault]
      cmp rax, 1
      jne __body
      jmp __end_if
      label __body  
  
    ;default_input_file_name, input_file_name, -> copy_symbols
      lea rcx, [_default_input_file_name]
      lea rdx, [_text_input_file_name]
      call _copy_symbols

    label __end_if
      end namespace

  ;debug_text, input_file_name, -> 'msvcrt\printf
    lea rcx, [_debug_text]
    lea rdx, [_text_input_file_name]
    call [_msvcrt•_printf]

  ;return 1
    mov rax, 1
    jmp __ret

  ;val debug_text "get_input_file_name: input_file_name = %s" 10 13 0
    label _debug_text
      db "get_input_file_name: input_file_name = %s", 10, 13, 0

  ;val debug_text2 "get_input_file_name: command_line = %s" 10 13 0
    label _debug_text2 
      db "get_input_file_name: command_line = %s", 10, 13, 0
  
  ;val default_input_file_name "examples\12_message_box.txt" 0
    label _default_input_file_name 
      db "examples\12_message_box.txt", 0

  label __ret
    ADD RSP, to_link_ret
    ret
    end namespace



;fn copy_symbols
  label _copy_symbols
    namespace .
    SUB RSP, to_link_ret
    mov [param_1], RCX
    mov [param_2], RDX
    
  ;param from
   from equ param_1

  ;param dest
    dest equ param_2

  ;[u8] var symbol
    symbol equ local_1

  ;var pos 0
    pos equ local_2
    mov rax, 0
    mov [pos], rax
  
  ;loop       # копируем символы
    label loop_1
      namespace .
      label __continue
    
    ;[u8] '('from + 'pos) => symbol
        mov rax,      [from]
        add rax,      [pos]
        mov al,       [rax]
        mov [symbol], al

    ;[u8]'symbol => 'dest + 'pos
      mov al,    [symbol]
      mov rcx,   [dest]
      add rcx,   [pos]
      mov [rcx], al

    ;#debug_text, 'symbol -> 'msvcrt\printf
      lea rcx, [debug_text]
      mov rdx, [symbol]
      xor r8,  r8
      mov r8l, dl
      ;call [_msvcrt•_printf]

    ;if [u8]'symbol = 0
      label __if_1
        namespace .
        mov al,   [symbol]
        cmp al,   0
        je __body
        jmp __end_if
        label __body

      ;break
        jmp __break

      label __end_if
        end namespace

    ;'pos + 1 => pos
        mov rax, [pos]
        add rax, 1
        mov [pos], rax
    
    jmp __continue
      label __break
      end namespace

  ;return 1
    mov rax, 1
    jmp __ret

  jmp __ret

  ;val debug_text "copy_symbols: symbol = %c, %u" 10 13 0
    label debug_text
      db "copy_symbols: symbol = %c, %u", 10, 13, 0

  label __ret
    ADD RSP, to_link_ret
    ret
    end namespace



;fn parse_find_input_name
  label _parse_find_input_name
    namespace .
    SUB RSP, to_link_ret
    
    mov [param_1], RCX
    mov [param_2], RDX
    mov [param_3], R8
    mov [param_4], R9

  ;param p_command_line
    p_command_line equ param_1

  ;# вычесляем положение первого аргумента
  ;[t_slice] var slice 
    _slice        equ local_1
    _slice•_start equ local_1
    _slice•_end   equ local_2

  ;'p_command_line => slice\start 
    mov rax, [p_command_line]
    mov [_slice•_start], rax

  ;# проверяем "имя exe начинаетя на кавычки" ?
  ;var symbol
    _symbol equ local_3
  
  ;[u8]''slice\start => symbol
    mov rax,      [_slice•_start]
    mov al,       [rax]
    mov [_symbol], al

  ;if [u8]'symbol = 34 
    label __if_1
      namespace .
      mov al,   [_symbol]
      cmp al,   34
      je __body
      jmp __else
      label __body

    ;'slice\start + 1 => slice\start
      mov rax, [_slice•_start]
      add rax, 1
      mov [_slice•_start], rax
    
    ;loop
      label loop_1
      namespace .
      label __continue
      
      ;[u8]''slice\start => symbol
        mov rax,      [_slice•_start]
        mov al,       [rax]
        mov [_symbol], al
      
      ;if [u8]'symbol = 34 # двойные кавычки
        label __if_2
          namespace .
          mov al,   [_symbol]
          cmp al,   34
          je __body
          jmp __end_if
          label __body
        
        ;break
          jmp __break
        
        label __end_if
          end namespace

      ;'slice.start + 1 => slice.start
        mov rax, [_slice•_start]
        add rax, 1 
        mov [_slice•_start], rax
      
      jmp __continue
      label __break
        end namespace
    
    ;'slice\start + 1 => slice\start
      mov rax, [_slice•_start]
      add rax, 1
      mov [_slice•_start], rax
    
    jmp __end_if
  
  ;else # значит начало аргумента после двух пробелов
    label __else

    ;loop # ищим начало
      label loop_2
        namespace .
        label __continue

      ;[u8]''slice.start => symbol
        mov rax,      [_slice•_start]
        mov al,       [rax]
        mov [_symbol], al

      ;if [u8]'symbol = 0
        label __if_3
          namespace .
          mov al,   [_symbol]
          cmp al,   0
          je __body
          jmp __end_if
          label __body
        
        ;return 3
          mov rax, 3
          jmp __ret

        label __end_if
          end namespace

      ;if [u8]'symbol = " "
        label __if_2
          namespace .
          mov al,   [_symbol]
          cmp al,   " "
          je __body
          jmp __end_if
          label __body
        
        ;'slice.start + 2 => slice.start
          mov rax, [_slice•_start]
          add rax, 2
          mov [_slice•_start], rax

      ;[u8]''slice.start => symbol
        mov rax,      [_slice•_start]
        mov al,       [rax]
        mov [_symbol], al

      ;if [u8]'symbol = 0 
        label __if_4
          namespace .
          mov al,   [_symbol]
          cmp al,   0
          je __body
          jmp __end_if
          label __body
        
        ;return 4
          mov rax, 4
          jmp __ret

        label __end_if
          end namespace

        ;break
          jmp __break

        label __end_if
          end namespace

      ;'slice\start + 1 => slice\start
        mov rax, [_slice•_start]
        add rax, 1
        mov [_slice•_start], rax
      
      jmp __continue
        label __break
        end namespace

    label __end_if
      end namespace

  ;# ищим конец первого аргумента
  ;'slice\start => slice\end
    mov rax, [_slice•_start]
    mov [_slice•_end], rax

  ;# увеличиваем slice\end пока не встретим конец аргумента
  ;loop 
    label loop_3
      namespace .
      label __continue

    ;var next_symbol
      _next_symbol equ local_4
    
    ;'('slice\end + 1) => next_symbol
      mov rax, [_slice•_end]
      add rax, 1
      mov rax, [rax]
      mov [_next_symbol], rax

    ;match 'next_symbol
      label __match_1
        namespace .
        mov rax, [_slice•_end]
        add rax, 1
        mov rax, [rax]
        cmp rax, " "
          je __body_1
        cmp rax, 0
          je __body_2
        jmp __end_match
        
      ;" "  
        label __body_1
        
        ;break
          jmp __break
      
      ;0
        label __body_2
        
        ;break
          jmp __break

      label __end_match
        end namespace
  
    ;'slice\end + 1 => slice\end
      mov rax, [_slice•_end] 
      add rax, 1
      mov [_slice•_end], rax

    jmp __continue
      label __break
      end namespace

  ;var resault
    _resault equ local_4

  ;slice, text_input_file_name, -> slice_copy_symbols_to_text => resault
    lea rcx, [_slice]
    lea rdx, [_text_input_file_name]
    call _slice_copy_symbols_to_text
    mov [_resault], rax
  
  ;if 'resault != 1 :break
    mov rax, [_resault]
    cmp rax, 1
    jne __ret

  ;var slice_size 'slice\start - 'slice\end
    _slice_size equ local_4
    mov rax, [_slice•_start]
    sub rax, [_slice•_end]
    mov [_slice_size], rax

  ;0 => text_input_file_name + 'slice_size
    mov rax,    0
    lea rcx,    [_text_input_file_name]
    add rcx,    [_slice_size]
    mov [rcx],  rax

  ;return 1
    mov rax, 1
    jmp __ret

  label __ret
    ADD RSP, to_link_ret
    ret
    end namespace



;fn slice_copy_symbols_to_text
  label _slice_copy_symbols_to_text
    namespace .
    SUB RSP, to_link_ret
    
    mov [param_1], RCX
    mov [param_2], RDX
    mov [param_3], R8
    mov [param_4], R9

  ;param p_slice
    _p_slice equ param_1
  
  ;param p_buffer
    _p_buffer equ param_2
  
  ;var start '('p_slice + t_slice\start)
    _start equ local_1
    ;'('p_slice + t_slice\start) => start
      mov rax, [_p_slice]
      mov rax, [rax]
      mov [_start], rax
    
  ;var end   '('p_slice + t_slice\end)
    _end equ local_2
    ;'('p_slice + t_slice\end) => end
        mov rax, [_p_slice]
        add rax, _t_slice•_end
        mov rax, [rax]
        mov [_end], rax
  
  ;var address_in 'start
    _address_in equ local_3
    mov rax, [_start]
    mov [_address_in], rax
  
  ;var addres_out 'p_buffer
    _addres_out equ local_4 
    mov rax, [_p_buffer]
    mov [_addres_out], rax

  ;# последовательно копируем символ за символом
  ;loop
    label loop_1
      namespace .
      label __continue

    ;''address_in => 'addres_out
      mov rax, [_address_in]
      mov rax, [rax]
      mov rcx, [_addres_out]
      mov [rcx], rax
    
    ;'address_in + 1 => address_in
      mov rax, [_address_in]
      add rax, 1
      mov [_address_in], rax
    
    ;'addres_out + 1 => addres_out
      mov rax, [_addres_out]
      add rax, 1
      mov [_addres_out], rax

    ;if 'address_in = 'end
      label __if_1 
        namespace .
        mov rax, [_address_in]
        mov rcx, [_end]
        cmp rax, rcx
        je __body
        jmp __end_if
        label __body

      ;break
        jmp __break
      
      label __end_if
        end namespace
    
    jmp __continue
      label __break
      end namespace

  ;return 1
    mov rax, 1
    jmp __ret

  label __ret
    ADD RSP, to_link_ret
    ret
    end namespace






