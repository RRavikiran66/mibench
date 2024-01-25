FILE1 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_small.c 
FILE2 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_large.c 
FILE3 = bmhasrch.o  bmhisrch.o  bmhsrch.o  pbmsrch_small.o 
FILE4 = bmhasrch.o  bmhisrch.o  bmhsrch.o  pbmsrch_large.o
FILE5 = bmhasrch_reorderloads.o  bmhisrch_reorderloads.o  bmhsrch_reorderloads.o  pbmsrch_small_reorderloads.o 
FILE6 = bmhasrch_reorderloads.o  bmhisrch_reorderloads.o  bmhsrch_reorderloads.o  pbmsrch_large_reorderloads.o  
OPT = opt
PASS = 'default<O3>,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_RE = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion --misched=default -verify-misched --misched-bottomup --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -mcpu=rocket-rv64 -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link
all: search_small search_large

search_small: ${FILE1} Makefile
	# $(CC) $(CFLAGS) ${FILE1} -o search_small
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhasrch.c -o bmhasrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhasrch.o bmhasrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhasrch.o -o bmhasrch;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhisrch.c -o bmhisrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhisrch.o bmhisrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2.o -o bitcnt_2;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhsrch.c -o bmhsrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhsrch.o bmhsrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhsrch.o -o bmhsrch;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ pbmsrch_small.c -o pbmsrch_small.ll;
	$(LLC) $(LLC_FLAGS) -o pbmsrch_small.o pbmsrch_small.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) pbmsrch_small.o -o pbmsrch_small;
	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE3} -o pbmsrch_small;

search_small_reordered: ${FILE1} Makefile
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhasrch.c -o bmhasrch.ll;
	$(OPT) -passes=$(PASS) bmhasrch.ll -S -o bmhasrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhasrch_reorderloads.o bmhasrch_reorderloads.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhisrch.c -o bmhisrch.ll;
	$(OPT) -passes=$(PASS) bmhisrch.ll -S -o bmhisrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhisrch_reorderloads.o bmhisrch_reorderloads.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhsrch.c -o bmhsrch.ll;
	$(OPT) -passes=$(PASS) bmhsrch.ll -S -o bmhsrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhsrch_reorderloads.o bmhsrch_reorderloads.ll;

	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ pbmsrch_small.c -o pbmsrch_small.ll;
	$(OPT) -passes='loop-unroll'  pbmsrch_small.ll -S -o pbmsrch_small_unroll.ll;
	$(OPT) -passes=$(PASS) pbmsrch_small_unroll.ll -S -o pbmsrch_small_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o pbmsrch_small_reorderloads.o pbmsrch_small_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) pbmsrch_small_reorderloads.o -o pbmsrch_small_reorderloads;
	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE5} -o pbmsrch_small_reorderloads;

search_large_reordered: ${FILE2} Makefile
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhasrch.c -o bmhasrch.ll;
	$(OPT) -passes=$(PASS) bmhasrch.ll -S -o bmhasrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhasrch_reorderloads.o bmhasrch_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhasrch_reorderloads.o -o bmhasrch_reorderloads;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhisrch.c -o bmhisrch.ll;
	$(OPT) -passes=$(PASS) bmhisrch.ll -S -o bmhisrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhisrch_reorderloads.o bmhisrch_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2_reorderloads.o -o bitcnt_2_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhsrch.c -o bmhsrch.ll;
	$(OPT) -passes=$(PASS) bmhsrch.ll -S -o bmhsrch_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o bmhsrch_reorderloads.o bmhsrch_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhsrch_reorderloads.o -o bmhsrch_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ pbmsrch_large.c -o pbmsrch_large.ll;
	$(OPT) -passes='loop-unroll'  pbmsrch_large.ll -S -o pbmsrch_large_unroll.ll;
	$(OPT) -passes=$(PASS) pbmsrch_large_unroll.ll -S -o pbmsrch_large_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o pbmsrch_large_reorderloads.o pbmsrch_large_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) pbmsrch_large_reorderloads.o -o pbmsrch_large_reorderloads;

	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE6} -o pbmsrch_large_reorderloads;

search_large: ${FILE2} Makefile
	# $(CC) $(CFLAGS) ${FILE2} -o search_large
	# $(CC) $(CFLAGS) ${FILE1} -o search_small
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhasrch.c -o bmhasrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhasrch.o bmhasrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhasrch.o -o bmhasrch;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhisrch.c -o bmhisrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhisrch.o bmhisrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2_reorderloads.o -o bitcnt_2_reorderloads;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2.o -o bitcnt_2;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bmhsrch.c -o bmhsrch.ll;
	$(LLC) $(LLC_FLAGS) -o bmhsrch.o bmhsrch.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bmhsrch.o -o bmhsrch;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ pbmsrch_large.c -o pbmsrch_large.ll;
	$(LLC) $(LLC_FLAGS) -o pbmsrch_large.o pbmsrch_large.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) pbmsrch_large.o -o pbmsrch_large;

	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE4} -o pbmsrch_large;

clean:
	rm -rf search_small search_large output*
