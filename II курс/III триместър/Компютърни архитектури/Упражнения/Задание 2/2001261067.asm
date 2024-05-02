%include "io64.inc"
arLen equ 2
ar resq arLen
s db ' ', 0
numInt resd 1
xStr    db 'x: ', 0
yStr    db "y: ", 0
resStr  db "x + 8 * y - 11: ", 0

section .bss
section .text
global CMAIN 
CMAIN:

    GET_DEC 4, eax
    PRINT_DEC 4, eax 
    NEWLINE
    
    GET_DEC 8, r10
    GET_DEC 8, r11
    GET_DEC 8, r12
    NEWLINE
    
    GET_DEC 8, rax
    GET_DEC 8, rcx 
    lea rsi, [rax + 8*rcx - 11] 
    PRINT_STRING [xStr]
    PRINT_DEC 8, rax
    NEWLINE
    PRINT_STRING [yStr]
    PRINT_DEC 8, rcx
    NEWLINE
    PRINT_STRING [resStr]
    PRINT_DEC 8, rsi
    NEWLINE


    cmp r10, r11
    jg max1 
        mov r8, r11
        jmp step2
  max1:
        mov r8, r10
  step2:
    cmp  r12, r8
    jng maxEnd 
        mov r8, r12
  maxEnd:
    PRINT_STRING [msg]
    PRINT_DEC 8, r8
    NEWLINE
    
    mov ecx, arLen
    lea r8, [ar1] ; 
    call readArray
    call writeArray
    lea r8, [ar2]
    call writeArray
    
    lea rsi, [ar1]
    lea rdi, [ar2]
    cld
    mov rcx, arLen
    rep movsd

    mov ecx, arLen 
    lea r8, [ar2]
    call writeArray
    GET_DEC 4, eax
    
    lea rdi, [ar2]
    mov rcx, arLen
    cld
    repnz scasd
 
    sub rdi, 4
    cmp [rdi], eax 
    jne .notEqual
        PRINT_STRING [msgIndex]
        lea rsi, [ar2]
        sub rdi, rsi
        sar rdi, 2
        PRINT_DEC 8, rdi
        jmp .after
  .notEqual:
        PRINT_STRING [msgNotElement]
  .after:
    NEWLINE      
    
xor rax, rax
ret 

readArray:

    pushfq
    push rcx
    push r8
            cmp ecx, 1
            jl .end 
        .next:  GET_DEC 4, [r8]
                add r8, 4
            dec ecx
            cmp ecx, 0
            jg .next
        .end:
    pop r8
    pop rcx
    popfq
ret 

writeArray:
    pushfq
    push rcx
    push r8
            cmp rcx, 1
            jl .end 
        .next: 
                PRINT_DEC 4, [r8]
                PRINT_CHAR ' '
                add r8, 4
            dec ecx
            cmp ecx, 0
            jg .next
        .end:
            NEWLINE
    pop r8
    pop rcx
    popfq
ret
    
xor rax, rax 
ret 

