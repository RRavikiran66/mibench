FILE1 = qsort_small.c
FILE2 = qsort_large.c
OPT = opt
PASS = 'default<O3>,helloworld,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_re = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion --misched=default -verify-misched --misched-bottomup --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion --unroll-full-max-count=9999 --enable-unroll-and-jam
COMPILER_CLANG = clang 
FLAGS = -O3 -flto -S -static -nostdlib --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm -ansi
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -mcpu=rocket-rv64 -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link

all: qsort_small qsort_large

qsort_small: qsort_small.c Makefile
	# $(CC) $(CFLAGS) qsort_small.c -o qsort_small -lm
	$(COMPILER_CLANG) $(FLAGS) -std=gnu89 -I /opt/riscv/sysroot/usr/include/ -I /home/ravikiran/work/riscv-tools/riscv-gnu-toolchain/newlib/newlib/libc/include qsort.c -o qsort.ll;
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ -I /home/ravikiran/work/riscv-tools/riscv-gnu-toolchain/newlib/newlib/libc/include qsort_small.c -o qsort_small.ll;
	$(LLC) $(LLC_FLAGS) -o qsort_small.o qsort_small.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm qsort_small.o -I /opt/riscv/sysroot/usr/include/ -o qsort_small -lm;

qsort_small_reorderloads: qsort_small.c Makefile
	# $(CC) $(CFLAGS) qsort_small.c -o qsort_small -lm
	$(COMPILER_CLANG) $(FLAGS) -std=gnu89 -I /opt/riscv/sysroot/usr/include/ -I /home/ravikiran/work/riscv-tools/riscv-gnu-toolchain/newlib/newlib/libc/include qsort.c -o qsort.ll;
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ -I /home/ravikiran/work/riscv-tools/riscv-gnu-toolchain/newlib/newlib/libc/include qsort_small.c -o qsort_small.ll;
	$(OPT) -passes='loop-unroll' qsort.ll -S -o qsort_unroll.ll;
	$(OPT) -passes=$(PASS) qsort_unroll.ll -S -o qsort_reorderloads.ll;
	$(OPT) -passes=$(PASS) qsort_small.ll -S -o qsort_small_reorderloads.ll;
	$(LLVM_LINK) -S qsort_reorderloads.ll qsort_small_reorderloads.ll -o qsort_small_reorderloads_o.ll
	$(LLC) $(LLC_FLAGS) -o qsort_small_reorderloads_o.o qsort_small_reorderloads_o.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm qsort_small_reorderloads_o.o -I /opt/riscv/sysroot/usr/include/ -o qsort_small_reorderloads -lm;

qsort_large: qsort_large.c Makefile
	# $(CC) $(CFLAGS) qsort_large.c -o qsort_large -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ qsort_large.c -o qsort_large.ll;
	$(LLC) $(LLC_FLAGS) -o qsort_large.o qsort_large.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm qsort_large.o -I /opt/riscv/sysroot/usr/include/ -o qsort_large -lm;

qsort_large_reorderloads: qsort_large.c Makefile
	# $(CC) $(CFLAGS) qsort_large.c -o qsort_large -lm
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ qsort_large.c -o qsort_large.ll;
	$(COMPILER_CLANG) $(FLAGS) -std=gnu89 -I /opt/riscv/sysroot/usr/include/ -I /home/ravikiran/work/riscv-tools/riscv-gnu-toolchain/newlib/newlib/libc/include qsort.c -o qsort.ll;
	$(OPT) -passes='loop-unroll' qsort.ll -S -o qsort_unroll.ll;
	$(OPT) -passes=always-inline qsort_large.ll -S -o qsort_large_inline.ll;
	$(OPT) -passes=$(PASS) qsort_large_inline.ll -S -o qsort_large_reorderloads.ll;
	$(OPT) -passes=$(PASS) qsort_unroll.ll -S -o qsort_reorderloads.ll;
	$(LLVM_LINK) -S qsort_reorderloads.ll qsort_large_reorderloads.ll -o qsort_large_reorderloads_o.ll
	$(LLC) $(LLC_FLAGS) -o qsort_large_reorderloads_o.o qsort_large_reorderloads_o.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm qsort_large_reorderloads_o.o -I /opt/riscv/sysroot/usr/include/ -o qsort_large_reorderloads -lm;

clean:
	rm -rf qsort_small qsort_large output*
