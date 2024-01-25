OPT = opt
PASS = 'default<O3>,mem2reg,simplifycfg,lcssa,loop-simplify'
LLC = llc 
LLC_FLAGS_RE = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -mcpu=rocket-rv64 -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
# -misched-cluster --misched-fusion --misched=default --enable-misched=true -verify-misched --misched-bottomup --enable-misched=true -mattr=+f,+lui-addi-fusion
all:  dijkstra_large dijkstra_small

dijkstra_large: dijkstra_large.c Makefile
	# $(CC) $(CFLAGS) dijkstra_large.c -o dijkstra_large
	# $(CC) $(CFLAGS) dijkstra_large.c -o dijkstra_large -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ dijkstra_large.c -o dijkstra_large.ll;
	$(LLC) $(LLC_FLAGS) -o dijkstra_large.o dijkstra_large.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm dijkstra_large.o -I /opt/riscv/sysroot/usr/include/ -o dijkstra_large -lm;

dijkstra_large_reorderloads: dijkstra_large.c Makefile
	# $(CC) $(CFLAGS) dijkstra_large.c -o dijkstra_large
	# $(CC) $(CFLAGS) dijkstra_large.c -o dijkstra_large -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ dijkstra_large.c -o dijkstra_large.ll;
	$(OPT) -passes=always-inline dijkstra_large.ll -o dijkstra_large_inline.ll
	$(OPT) -passes='loop-unroll' dijkstra_large_inline.ll -o dijkstra_large_unroll_int.ll
	$(OPT) -passes=$(PASS) dijkstra_large_unroll_int.ll -S -o dijkstra_large_unroll.ll;
	$(OPT) -passes="helloworld" dijkstra_large_unroll.ll -S -o dijkstra_large_reorderloads.ll
	$(LLC) $(LLC_FLAGS) -o dijkstra_large_reorderloads.o dijkstra_large_reorderloads.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm dijkstra_large_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o dijkstra_large_reorderloads -lm;

dijkstra_small: dijkstra_small.c Makefile
	# $(CC) $(CFLAGS) dijkstra_small.c -o dijkstra_small 
	# $(CC) $(CFLAGS) dijkstra_small.c -o dijkstra_small -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ dijkstra_small.c -o dijkstra_small.ll;
	$(LLC) $(LLC_FLAGS) -o dijkstra_small.o dijkstra_small.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm dijkstra_small.o -I /opt/riscv/sysroot/usr/include/ -o dijkstra_small -lm;

dijkstra_small_reorderloads: dijkstra_small.c Makefile
	# $(CC) $(CFLAGS) dijkstra_small.c -o dijkstra_small 
	# $(CC) $(CFLAGS) dijkstra_small.c -o dijkstra_small -lm
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ dijkstra_small.c -o dijkstra_small.ll;
	$(OPT) -passes=always-inline dijkstra_small.ll -o dijkstra_small_inline.ll
	$(OPT) -passes='loop-unroll' dijkstra_small_inline.ll -o dijkstra_small_unroll_int.ll
	$(OPT) -passes=$(PASS) dijkstra_small_unroll_int.ll -S -o dijkstra_small_unroll.ll;
	$(OPT) -passes="helloworld" dijkstra_small_unroll.ll -S -o dijkstra_small_reorderloads.ll
	$(LLC) $(LLC_FLAGS) -o dijkstra_small_reorderloads.o dijkstra_small_reorderloads.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) -mcmodel=medany -lm dijkstra_small_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o dijkstra_small_reorderloads -lm;
clean:
	rm -rf dijkstra_large dijkstra_small output*
