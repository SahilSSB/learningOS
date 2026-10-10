## Understanding Stack
- Implemented using two special cpu registers `sp` and `bp` that maintain address of base stack and stack top.
- Stack expands as we push data onto it so we set it far away from the important regions in the memory
>[!tip] the stack grows ___downwards___ from the base pointer so when we push a value, it gets stored below not above
### Snippet
```asm
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
```
We first set BP(base pointer) which points at some place in the stack to a position above the BIOS, since the stack grows downwards in memeory, and store the value of BP in SP(stack pointer)
When we `push 'A'` the sp decrements from 0x8000 to 0x7ffe which is basically doing sp = sp - 2.
After we `push 'C'` sp is at 0x7ffa.

popping reads C into bx and now sp moves to 0x7ffc or sp = sp + 2.
we store C in al then print it

doing the same thing results in printing B and A. So the final order is CBA
