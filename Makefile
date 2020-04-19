#OBJPATH=../../obj/JBoot

#ASM=nasm
#ASMFLAGS=-f bin

# TODO: THIS SHOULD BE ALL THE WAY AROUND. '.npp.asm' goes into NasmPP, '.asm' goes out.
#NASMPP_OBJ=$(shell find . -type f -iname '*.asm' | sed 's/\.asm/\.asm.npp/g' | xargs -I {} echo "$(OBJPATH)/"{})
#ASM_OBJ=$(shell find . -type f -iname '*.asm.npp' | sed 's/\.asm.npp/\.bin/g' | xargs -I {} echo "$(OBJPATH)/"{})

# TODO TODO TODO JUST WANT IT TO WORK
.PHONY: build finished

build:
	nasm CD/JBoot.asm -f bin -o ../../iso/boot/CD.bin
	./nasmPP.py HDD/stage1.asm
	./nasmPP.py HDD/stage2.asm
	nasm HDD/stage1.asm.npp -f bin -o ../../iso/boot/HDDs1.bin
	nasm HDD/stage2.asm.npp -f bin -o ../../iso/boot/HDDs2.bin
	rm HDD/*.asm.npp

finished:
	@echo -e "\e[1;33mJBoot compiled.\e[0m"
