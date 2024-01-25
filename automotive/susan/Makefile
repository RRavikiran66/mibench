# FLAGS="CFLAGS=-O3 -static -mcpu=macroop-fusion-rv64 --sysroot=/opt/riscv/bin/sysroot --gcc-toolchain=/opt/riscv --target=riscv64-unknown-linux-gnu -march=rv64gc -mabi=lp64d"
# LDFLAGS="LDFLAGS=-static -mcpu=macroop-fusion-rv64 --sysroot=/opt/riscv/bin/sysroot --gcc-toolchain=/opt/riscv --target=riscv64-unknown-linux-gnu -march=rv64gc -mabi=lp64d"
# ##############
OPT = opt
PASS = 'default<O3>,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate' #-mem2reg -simplifycfg -loops -lcssa -loop-simplify -loop-rotate -loop-unroll -unroll-count=3 -unroll-allow-partial -debug
LLC = llc
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64 
LLC_FLAGS_RE = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --unroll-full-max-count=9999 --enable-unroll-and-jam#--enable-misched=true --pre-RA-sched=source --enable-memcpy-dag-opt --misched-fusion  -mattr=+f,+lui-addi-fusion
COMPILER_CLANG = clang 
FLAGS = -g -finline-functions -O3 -S -static -nostdlib --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm -pg
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/ -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -march=rv64g -mabi=lp64d -mcpu=generic-rv64  -lm
#--misched=ilpmax --enable-misched=true --pre-RA-sched=source --misched-fusion  -mattr=+f,+macrofusion,+lui-addi-fusion
#--debug-only=machine-scheduler --misched-fusion --misched-cluster --pre-RA-sched=source --enable-memcpy-dag-opt --misched=default --enable-misched=true --misched-postra   -mattr=+f,+lui-addi-fusion
# --stats --misched=default -verify-misched --misched-bottomup --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion
all: susan susan_reorderloads

susan: susan.c Makefile 
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ susan.c -o susan.ll;	
	$(LLC) $(LLC_FLAGS) -o susan.o susan.ll;
	$(RISCV_COMPILER) -static  -lm susan.o -o susan $(RISCV_FLAGS);

susan_reorderloads: susan.c Makefile
	$(COMPILER_CLANG) $(FLAGS) -ansi -I /opt/riscv/sysroot/usr/include/ susan.c -o susan.ll;
	$(OPT) -passes=always-inline  susan.ll -S -o susan_inline.ll;
	$(OPT) -passes='loop-unroll'  susan_inline.ll -S -o susan_unroll.ll; 
	$(OPT) -passes=$(PASS) susan_unroll.ll -S -o susan_reorderloads_1.ll;
	$(OPT) -passes='helloworld' susan_reorderloads_1.ll -S -o susan_reorderloads.ll;	
	$(LLC) $(LLC_FLAGS) -o susan_reorderloads.o susan_reorderloads.ll;
	$(RISCV_COMPILER) -static  -lm susan_reorderloads.o -o susan_reorderloads $(RISCV_FLAGS);

clean:
	rm -rf susan output*
