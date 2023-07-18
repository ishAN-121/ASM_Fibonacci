SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .data
    prompt1 db 'Enter the string to be encrypted ' , 0xa, 0xd 
    len1 equ $ - prompt1
    prompt2 db 'Enter character to be xored with : ' , 0xa, 0xd 
    len2 equ $ - prompt2
    result db 'The Encryption is : ' , 0xa , 0xd
    len3 equ $ - result
    newline db 0xa
    res_string times 50 db 0

section .bss
    string resb 50
    key resb 1
section .text
   
    global _start

    _start : 

    mov eax , SYS_WRITE ;Writing the prompt
    mov ebx, STDOUT
    mov ecx, prompt1
    mov edx, len1
    int 0x80

    mov eax, SYS_READ ; Inputting the string
    mov ebx, STDIN
    mov ecx, string
    mov edx, 50
    int 0x80

    mov eax, SYS_WRITE ;Write prompt
    mov ebx, STDOUT
    mov ecx, prompt2
    mov edx, len2
    int 0x80

    mov eax, SYS_READ ; Input key
    mov ebx, STDIN
    mov ecx, key
    mov edx, 1
    int 0x80

    mov esi , string ;saving addresses of input , key and resultant string
    mov edi , key
    mov eax , res_string

    loop:

        mov cl , byte [esi] ; taking first character
        xor cl , [edi] ; xorring the character
        mov byte [eax] , cl; changing with the resultant string
        inc esi ;incrementing values of the addresses
        inc eax
        cmp byte [esi+1] , 0 ;checking for the null value of string
        jne loop

        mov eax, SYS_WRITE ;Writing result prompt
        mov ebx, STDOUT
        mov ecx, result
        mov edx, len3
        int 0x80

        mov eax, SYS_WRITE ;Writing the xorred string
        mov ebx, STDOUT
        mov ecx, res_string
        mov edx, 50
        int 0x80

        mov eax, SYS_WRITE ;Adding newline at end
        mov ebx, STDOUT
        mov ecx, newline
        mov edx, 1
        int 0x80

        mov eax, SYS_EXIT
        xor ebx, ebx 
        int 0x80 
