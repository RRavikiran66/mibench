# By default, the code is compiled for a "big endian" machine.
# To compile on a "little endian" machine set the LITTLE_ENDIAN flag.
# To make smaller object code, but run a little slower, don't use UNROLL_LOOPS.
# To use NIST's modified SHA of 7/11/94, define USE_MODIFIED_SHA

CC = gcc
CFLAGS = -O3 -Wall
OPT = opt
PASS = 'default<O3>,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_RE = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion --misched=default -verify-misched --misched-bottomup --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -march=rv64g -mabi=lp64d -mcpu=rocket-rv64 -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link
sha:	#sha_driver.o sha.o
	# $(CC) -o $@ sha_driver.o sha.o
	# strip $@
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ sha.c -o sha.ll;
	$(LLC) $(LLC_FLAGS) -o sha.o sha.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS)  -lm sha.o -I /opt/riscv/sysroot/usr/include/ -o sha -lm;

	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ sha_driver.c -o sha_driver.ll;
	$(LLC) $(LLC_FLAGS) -o sha_driver.o sha_driver.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -lm sha_driver.o sha.o -I /opt/riscv/sysroot/usr/include/ -o sha_driver -lm;

sha_reorderloads:	#sha_driver.o sha.o
	# $(CC) -o $@ sha_driver.o sha.o
	# strip $@
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ sha.c -o sha.ll;
	$(OPT) -passes=always-inline sha.ll -S -o sha_inline.ll
	$(OPT) -passes='loop-unroll' sha_inline.ll -S -o sha_unroll.ll
	$(OPT) -passes=$(PASS) sha_unroll.ll -S -o sha_after_unrollpass.ll;
	$(OPT) -passes="helloworld" sha_after_unrollpass.ll -S -o sha_reorderloads.ll
	$(LLC) $(LLC_FLAGS) -o sha_reorderloads.o sha_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS)  -lm sha_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o sha_reorderloads -lm;

	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ sha_driver.c -o sha_driver.ll;
	$(OPT) -passes=always-inline sha_driver.ll -S -o sha_driver_inline.ll
	$(OPT) -passes=$(PASS) sha_driver_inline.ll -S -o sha_driver_after_unrollpass.ll;
	$(OPT) -passes="helloworld" sha_driver_after_unrollpass.ll -S -o sha_driver_reorderloads.ll
	$(LLVM_LINK) -S sha_reorderloads.ll sha_driver_reorderloads.ll -o sha_driver_reorderloads_o.ll;
	$(OPT) -passes=$(PASS) sha_driver_reorderloads_o.ll -S -o sha_driver_reorderloads_f.ll;
	$(LLC) $(LLC_FLAGS) -o sha_driver_reorderloads.o sha_driver_reorderloads_f.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -lm sha_driver_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o sha_driver_reorderloads -lm;

clean:
	rm -rf *.o sha output*
