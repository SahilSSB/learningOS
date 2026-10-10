mov ah, 0x0e

; First attempt
mov al, "1"
int 0x10
mov al, theSecret
int 0x10

; Second attempt
mov al, "2"
int 0x10
mov al, [theSecret]
int 0x10

; Third attempt
mov al, "3"
int 0x10
mov bx, [theSecret]
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
mov al, "4"
int 0x10
mov al, [0x7c1e]
int 0x10

jmp $

theSecret:
  db "X"


times 510-($-$$) db 0
dw 0xaa55
