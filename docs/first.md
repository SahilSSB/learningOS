## Thought process
We first need to create an empty loop, which we can do using:
```asm
loop:
    jmp loop

times 510-($-$$) db 0
dw 0xaa55
```
This creates an infinite loop where 'loop' is a label
`times 510-($-$$)` makes the program fir into 512 bytes with last 2 bytes being the magic number which is 0xaa55 --> which is the final signature of the bootsector. So 510 padded with 0's to pad us till the 510th byte. In $-$$, the $$ evaluates to the assembly position at the beginning of the line containing the express and $, the line itself. 

### Hexdump of boot.bin
__The code is__
```asm
mov ah, 0x0e
mov al, 'A'
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
```

```hex
00000000: b40e b041 cd10 ebfe 0000 0000 0000 0000  ...A............
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000020: 0000 0...
000001e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000001f0: 0000 0000 0000 0000 0000 0000 0000 55aa  ..............U.
```
B4 moves 0E into AH 
B0 moves 41(A) into AL
CD 10 is the interrupt

Setting AH to 0x0e puts the BIOS in into teletype routine.

