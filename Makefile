# Do not run make outside of jotaOS!
RESULT_PATH=../../iso/boot

ASM=nasm
ASMFLAGS=-f bin
NASMPP=python3 ./nasmPP.py

.PHONY: build cd hdd

build: cd hdd clean

# CD will never be more than one file
cd:
	$(ASM) CD/JBoot.asm -o $(RESULT_PATH)/CD.bin $(ASMFLAGS)

# HDD will never be more than these two files
hdd:
	$(NASMPP) HDD/stage1.asm
	$(NASMPP) HDD/stage2.asm
	$(ASM) HDD/stage1.asm.npp -o $(RESULT_PATH)/HDDs1.bin $(ASMFLAGS)
	$(ASM) HDD/stage2.asm.npp -o $(RESULT_PATH)/HDDs2.bin $(ASMFLAGS)

# Remove temporal files
clean:
	rm HDD/*.asm.npp
