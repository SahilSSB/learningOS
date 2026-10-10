The bootsector is stored at `0x7c00`

Lets try to define X as the data and try to print it out.
```asm
theSecret:
    db "X"
```
We will now try to access theSecret in several ways:
- `mov al, theSecret`
- `mov al, [theSecret]`
- `mov al, theSecret + 0x7c00`
- `mov al, 2d + 0x7c00`, where 2d is the position of X 


