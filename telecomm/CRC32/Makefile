OPT = opt
PASS = 'default<O3>,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_re = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion --misched=default -verify-misched --misched-bottomup --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion

COMPILER_CLANG = clang 
FLAGS = -O3 -S -static -nostdlib --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -march=rv64g -mabi=lp64d -mcpu=rocket-rv64 -lm --sysroot=/opt/riscv/sysroot

crc: crc_32.c Makefile
	# $(CC) $(CFLAGS) crc_32.c -o crc 
	# $(CC) $(CFLAGS) crc_32.c -o crc_32 -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ crc_32.c -o crc_32.ll;
	$(LLC) $(LLC_FLAGS) -o crc_32.o crc_32.ll
	$(RISCV_COMPILER) $(RISCV_FLAGS) -lm crc_32.o -I /opt/riscv/sysroot/usr/include/ -o crc_32;

crc_32_reorderloads: crc_32.c Makefile
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ crc_32.c -o crc_32.ll;
	$(OPT) -passes=always-inline crc_32.ll -S -o crc_32_inline.ll;
	$(OPT) -passes='loop-unroll' crc_32_inline.ll -S -o crc_32_unroll_int.ll;
	$(OPT) -passes=$(PASS) crc_32_unroll_int.ll -S -o crc_32_unroll.ll;
	$(OPT) -passes="helloworld" crc_32_unroll.ll -S -o crc_32_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o crc_32_reorderloads.o crc_32_reorderloads.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -lm crc_32_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o crc_32_reorderloads;

clean:
	rm -rf crc output*
