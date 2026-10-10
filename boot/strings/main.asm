[org 0x7c00]

mov bx, HELLO
call print

call print_nl

mov bx, BYEBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

jmp $

%include "print.asm"
%include "printhex.asm"

HELLO:
  db 'Hello, World', 0

BYEBYE:
  db 'Bye Bye', 0

times 510-($-$$) db 0
dw 0xaa55
