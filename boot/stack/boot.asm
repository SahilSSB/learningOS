mov ah, 0x0e

mov bp, 0x8000    ; set base above bios
mov sp, bp        ; loading bootsector 

push 'A'          ; pushing random characters onto the stack
push 'B'
push 'C'

pop bx            ; since we can only pop 16 bits we pop to bx
mov al, bl        ; copy the val in bl into al
int 0x10          ; print al

pop bx            
mov al, bl       
int 0x10          

mov al, [0x7ffe]  ; demonstrating how stack grows downwards from bp
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
