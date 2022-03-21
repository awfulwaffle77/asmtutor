;------------------------------------
; strlen(Message)
; arg => expects Message in EAX
; ret => length in EAX
strlen:
    push ebx        ; we save value of ebx, because we use it
    mov eax, ebx    ; save so we know from where to substitute
last_msg_char:      ; here will be calculated the address where \0 is at
    cmp byte [eax], 0
    je finished
    inc eax
    jmp last_msg_char
finished:
    sub eax, ebx    ; now eax holds the length of string

    pop ebx         ; restore EBX value

    ret


;---------------------------------------
; printLF(Message) ; same as _print, but with \n
; arg => message in ECX, len(msg) in EDX
; ret => void
printLF:
    call _print

    ;mov eax, 0FFh ; PLEASE REMOVE THIS. ONLY 4 TESTS
    push eax
    mov al, 36h 
    mov ah, 0Ah
    ; add 360Ah to all messages before printing
    ; if we would have put mov eax, 36; push eax; mov eax, 0Ah; push eax;
    ; it would have put two words padded with 0 on MSBs on the stack
    push eax

    mov ecx, esp  ; we can't just add the value 0Ah. We need a memory address
    call _print
    
    pop eax
    pop eax

    ret
;---------------------------------------
; print(Message)
; arg => message in ECX, len(msg) in EDX
; ret => void
_print:
    ; save values on stack, but use their values
    push ecx
    push edx
    push ebx
    push eax    ; i guess this is fine; we pop it atm to see what is happening !! OBSERVE that we do not pop this

    mov ebx, ecx  ; because strlen expects msg to be in ebx
    call strlen

    mov edx, eax ; len(edx)
    mov ebx, 1  ; print to STDOUT
    mov eax, 4  ; Linux kernel read
    int 80h ; request an interrupt on libc

    pop eax
    pop ebx
    pop edx
    pop ecx

    ret

;---------------------------------------
;exit(void)
; Exits :)
_exit:
    mov eax, 1  ; exit syscall
    mov ebx, 0  ; exit code 0 - no error   ; check with echo $?
    int 80h
