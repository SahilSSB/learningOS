## We're going to print strings in this part
So we're gonna need two things, we need to learn how to write control structures using jmp and calling functions

A string is a seq of bytes with a null terminator
We can achieve conditional jump by:
- First running a comparison instruction `cmp` 
- Issuing a specific conditional jump instruction

>[!tip] Jump statements available:
> - je target --> jump if equal
> - jne target --> jump if not equal
> - jl target --> jump if less than 
> - jle target --> jump if less than or equal 
> - jg target --> jump if greater than 
> - jge target --> jump if greater than or equal

At the CPU level, a function is nothing but a jump to the address of a useful routine and jumping back to the instruction immediately after the first jump

Including Exernal Files:
```asm
%include "file.asm"
```

### Understanding the code

we're trying run `while (string[i] != '\0') { printf(string[i]); i++}`
we move the base addr of the string into al and then compare the value of al with null termintor.

if it is equal, we jump to the done label where we pop from all registers and transfer control to the new address by popping `IP` or `EIP`

what `ret` basically does is that it pops the top 16-bit value off the stack and unconditionally jumps to that memory address

- when you run call print, the CPU automatically pushes the memory address of the very next instruction ,the one immediately following the call onto the stack. Then, it jumps to the print label.
- when the function runs, our print logic executes.
- when the CPU hits ret, it pops that saved return address off the top of the stack and loads it directly into the instruction pointer/`IP`.
- the CPU picks up right where it left off before the function was called.

>[!caution] Because ret blindly assumes whatever is currently at the top of the stack is a valid return address, your stack must be perfectly balanced before you run it. If you execute pusha at the start of your function but forget to run popa right before ret, the CPU will pop your register data into the instruction pointer, try to jump to that random data as if it were a memory address, and instantly crash the OS.

Then we increment the base address and jump back to the start of the loop.

Pretty simple :P

To print a newline, we jus print the newline character and then a carriage return character to reset the position to the beginning of the line

### Trying to print hex values
We need to learn how to print hex values too and not just ascii characters

This one is little tricky 
lets assume we recieve data in `dx`
we take the last byte of `dx` and convert it into ascii 
>[!note]
> - '0' is 0x30 in ascii and '9' is 0x39 so we just add 0x30 to byte N 
> - 'A' is 0x41 in ascii and 'F' is 0x46 so we add up 0x40

assuming we use `ax` the working register, we move the last nibble of dx into ax and mask ax with 0x000f which will preserve its last nibble

now we add 0x30 into `al` since the lower 8 bits of ax is made up of `al`
we compare `0x39` with `al` to check if the value is between 0 - 9 or not and if it is lesser we jump to the next step 

if it is greater, we add +7 to to represent 'A' to 'F'. Here's why we do that:

if our digit is '10' which should be 'A', according to our instructions: add al, 0x30 makes it 58, but 58 in ascii is a colon ':', we therefore add 7 to it to make it into 'A' since ascii 'A' is '65'

In step2 we get the correct position of the string to place our ascii character which is done using `base addr + str len - index of char`

moving `0x0000 + 5` into `bx` and subtracting that with `cx` does this for us

`al` has the ascii character and we copy this on `[bx]`

we now rotate the digits of our original data by 4 which helps us shift the register by 4 bits at a time which shifts each nibble or hex digit by one position. Assume you have `0x1234` in dx initially then doing `ror dx, 4` would make it `0x4123` on the first iteration, then `0x3412` on the second and so on. This helps us mask each nibble perfectly on every single iteration 

We increment cx and jump back into the loop

__the end:__
we mov the memory addres of `hex_out`/`0x0000` into `bx` and then `call` print, pop everything and `ret`

