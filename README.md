# ARCHIVED
JBoot is no more. I'm using Limine now. The code you'll find in this repository will hardly be of any use, don't waste your time.

# JBoot

JBoot is the bootloader for jotaOS.

I do not use GRUB or an existing bootloader for three reasons:
- I wanted to create a bootloader, which is a hard task by itself.
- The bootloader must be able to understand JOTAFS, the filesystem the OS uses when it's installed on disk.
- Grub is HUGE (a bunch of MBs), and I want a tiny ISO.

So, the purpose was to make this REALLY simple. JBoot consists in two stages.

- Stage 1 basically loads the CD filesystem and runs the stage 2.
- Stage 2 enables A20, goes into unreal mode, loads the kernel into memory,
prepares the information that will be necessary later, goes into protected
mode, parses the ELF and moves the segments around, and finally jumps to the kernel.

Once the kernel has the control, it can read important data left by JBoot.
- At 0x9000, there's a byte containing the boot drive ID.
- At 0xA000, there's the list returned by INT 0x15, EAX = 0xE820. The kernel will need this last one in order to figure out how much RAM is available.

JBoot is actually two different bootloaders:
- CD, which boots from an ISO9660 formatted disk.
- HDD, which boots from the JOTAFS formatted drive.

## nasmPP
There is also an extra file in this repository, _nasmPP.py_, which is a really simple NASM preprocessor that adds the _%export_ and _%reference_ directives.
- _%export_ declares a header (a function or variable) in the stage 1.
- _%reference_ lets you access that memory from the stage 2, so there's no need to repeat code.
