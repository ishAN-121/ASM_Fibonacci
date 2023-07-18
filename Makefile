xor_cipher: xor_cipher.o
		ld -m elf_i386 xor_cipher.o -o xor_cipher 
		./xor_cipher

xor_cipher.o: xor_cipher.asm
		nasm -f elf32 xor_cipher.asm

clean:
	rm -rf xor_cipher.o xor_cipher