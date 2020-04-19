# Do not run make outside of jotaOS!
RESULT_PATH=../../iso/boot

ASM=nasm
ASMFLAGS=-f bin
NASMPP=python3 ./nasmPP.py

.PHONY: build hdd clean

build: $(RESULT_PATH)/CD.bin hdd clean

# CD will never be more than one file
$(RESULT_PATH)/CD.bin: CD/JBoot.asm
	$(ASM) $< -o $@ $(ASMFLAGS)

# HDD will never be more than these two files
hdd: $(RESULT_PATH)/HDDs1.bin $(RESULT_PATH)/HDDs2.bin

$(RESULT_PATH)/HDDs%.bin: HDD/stage%.asm
	$(NASMPP) $<
	$(ASM) $<.npp -o $@ $(ASMFLAGS)

# Remove temporal files
clean:
	rm HDD/*.asm.npp &> /dev/null || true

