print:
  pusha

; iterating through the string byte by byte until null character
start:
  mov al, [bx]  ; bx is the base address of the string
  cmp al, 0     ; check for null character
  je done

  mov ah, 0x0e
  int 0x10  

  add bx, 1     ; increment pointer
  jmp start     ; loop back

  done:
  popa
  ret


; newlineeeee
print_nl:
  pusha

  mov ah, 0x0e
  mov al, 0x0a ; newline char
  int 0x10
  mov al, 0x0d ; carriage return
  int 0x10

  popa
  ret
