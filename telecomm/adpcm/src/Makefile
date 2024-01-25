#
# Makefile for adpcm and test programs
# -------------------

#####################################################################
# Added by C. Lee.
#
# On Sun machines, gcc need to be informed whether the machines have
# integer multipliers by specifying this option: -mv8.
#
# Also, on Sun machines, in order to use the SPIXTOOLS and SHADE,
# uncomment this option: -static.
#
# CC = gcc
# LFLAGS = -mv8
# LFLAGS = $(LFLAGS) -static
# #
# # End of addition
# ######################################################################
# CFLAGS = -static -O3

# May need this on a sun:
# CFLAGS=-O -I/usr/demo/SOUND
OPT = opt
PASS = 'default<O3>,helloworld'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=sifive-u74
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64imafdc -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdio.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdlib.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/math.h
RISCV_COMPILER = riscv64-unknown-elf-gcc
RISCV_FLAGS = -mcpu=sifive-u74 -march=rv64imafdc -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link
ALLSRC=README adpcm.2 Makefile adpcm.h libst.h adpcm.c timing.c rawcaudio.c rawdaudio.c suncaudio.c sgicaudio.c sgidaudio.c hello.adpcm.uu

all: adpcm.o rawcaudio rawdaudio timing
	cp rawcaudio rawdaudio rawcaudio_reorderloads timing ../bin/.

sgi: all sgicaudio sgidaudio

sun: all suncaudio sundaudio

adpcm.o: adpcm.h

suncaudio: suncaudio.o adpcm.o
	$(CC) adpcm.o suncaudio.o -o suncaudio -L/usr/demo/SOUND -laudio

sundaudio: suncaudio
	cp suncaudio sundaudio

sgicaudio: sgicaudio.o adpcm.o
	$(CC) sgicaudio.o adpcm.o -o sgicaudio -laudiofile -lm

sgidaudio: sgidaudio.o adpcm.o
	$(CC) sgidaudio.o adpcm.o -o sgidaudio -laudiofile -lm

rawcaudio: rawcaudio.o adpcm.o
	$(CC) $(CFLAGS) rawcaudio.o adpcm.o -o rawcaudio
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ rawcaudio.c -o rawcaudio.ll;
	$(OPT) -passes=$(PASS) rawcaudio.ll -S -o rawcaudio_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o rawcaudio.o rawcaudio.ll;
	$(LLC) $(LLC_FLAGS) -o rawcaudio_reorderloads.o rawcaudio_reorderloads.ll;  
	$(LLVM_LINK) -S rawcaudio_reorderloads.ll -o rawcaudio_reorderloads_o.ll;
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ adpcm.c -o adpcm.ll;
	$(OPT) -passes=$(PASS) adpcm.ll -S -o adpcm_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o adpcm.o adpcm.ll;
	$(LLC) $(LLC_FLAGS) -o adpcm_reorderloads.o adpcm_reorderloads.ll;

	$(LLVM_LINK) -S adpcm_reorderloads.ll rawcaudio_reorderloads.ll -o adpcm_reorderloads_o.ll;
	$(LLC) $(LLC_FLAGS) -o adpcm_reorderloads_o.o adpcm_reorderloads_o.ll;

	$(RISCV_COMPILER) $(RISCV_FLAGS) adpcm_reorderloads_o.o  -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ -o rawcaudio_reorderloads -lm -lc;
	$(RISCV_COMPILER) $(RISCV_FLAGS) rawcaudio.o adpcm.o -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/math.h -o rawcaudio -lm -lc;

# rawdaudio: rawdaudio.o adpcm.o
# 	$(CC) $(CFLAGS) rawdaudio.o adpcm.o -o rawdaudio

# rawdaudio_reorderloads: rawcaudio_reorderloads.o adpcm.o
# 	$(CC) $(CFLAGS) rawcaudio_reorderloads.o adpcm.o -o rawcaudio_reorderloads

timing: timing.o adpcm.o
	$(CC) $(CFLAGS) timing.o adpcm.o -o timing

adpcm.shar: $(ALLSRC)
	shar $(ALLSRC) > adpcm.shar

# Added by C. Lee
clean:
	rm -f *.o ; rm rawcaudio rawdaudio timing ; rm -f ../bin/* ../output*
