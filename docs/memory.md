The bootsector is stored at `0x7c00`

Lets try to define X as the data and try to print it out.
```asm
theSecret:
    db "X"
```
We will now try to access theSecret in several ways:
- `mov al, theSecret`
    - This tries to load the immediate offset into al, but we want to print the character at the offset and not the offset, so it fails. This is basically like a pointer printing an address than the value at that address
- `mov al, [theSecret]`
    - This tries to take the address from the start of memory, rather than the start of our loaded code. This lands it around the interrupt vector. And hence it fails  
- `mov al, theSecret + 0x7c00`
    - We add the offset theSecret to the address where we think the bios loaded the code, which is 0x7c00 using the `add` instruction which prints out X
- `mov al, 1e + 0x7c00`, where 1e is the position of X
    - We precalculate the address of X in this case with the address of the bootsector

From here we have figured out that the bios loads the boot sector at `0x7c00` so we globally add this offset always using `[org 0x7c00]`

once we do this, the 2nd and 4rd case work.
