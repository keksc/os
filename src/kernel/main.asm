org 0x7C00
bits 16

%define endl 0x0D, 0x0A

start:
  jmp main

; outputs a string
; Params:
;   -ds:si points to string
print:
; save the registers that we will modify
  push si
  push ax

.loop:
  lodsb ; load next char in al
  or al, al ; check if next char is 0 
  jz .done

  ; call bios interrupt
  mov ah, 0x0E
  mov bh, 0
  int 0x10

  jmp .loop

.done:
  pop ax
  pop si 
  ret


main:
; setup data segments
  mov ax, 0 
  mov ds, ax
  mov es, ax

; setup stack segments
  mov ss, ax
  mov sp, 0x7C00;downwards from where the program began so sure that it wont overwhite

  mov si, msg_hello
  call print

  hlt

.halt:
  jmp .halt

msg_hello: db 'Hello world!', endl, 0

times 510-($-$$) db 0
dw 0AA55h
