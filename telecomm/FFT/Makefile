OBJ = main.o fftmisc.o  fourierf.o
FILE = main.c fftmisc.c  fourierf.c
FILE1 = main_reorderloads.o fftmisc_reorderloads.o fourierf_reorderloads.o

OPT = opt
PASS = 'default<O3>,helloworld'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_re = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --enable-misched=true --misched-fusion  -mattr=+f,+lui-addi-fusion --misched=default --misched-cluster 
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm -ansi
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link

fft: ${OBJ} Makefile
	# $(CC) $(CFLAGS)  ${OBJ} -o fft -lm
	# $(CC) $(CFLAGS)  -c fftmisc.c
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ fftmisc.c -o fftmisc.ll;
	$(LLC) $(LLC_FLAGS) -o fftmisc.o fftmisc.ll;

	# $(CC) $(CFLAGS)  -c fourierf.c
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ -I fourier.h -I ddcmath.h -I ddc.h fourierf.c -o fourierf.ll;
	$(LLC) $(LLC_FLAGS) -o fourierf.o fourierf.ll;

	# $(CC) $(CFLAGS)  -c main.c
	$(COMPILER_CLANG) $(FLAGS) main.c  -I /opt/riscv/sysroot/usr/include/ -o main.ll;
	$(LLC) $(LLC_FLAGS) -o main.o main.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) $(OBJ) fourier.h ddcmath.h ddc.h -o main -lm -lc;

fft_reorderloads: ${OBJ} Makefile
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ fftmisc.c -o fftmisc.ll;
	$(OPT) -always-inline fftmisc.ll -S -o fftmisc_inline.ll;
	$(OPT) -passes=$(PASS) fftmisc_inline.ll -S -o fftmisc_inline_after_unroll.ll;
	$(OPT) -passes="helloworld" fftmisc_inline_after_unroll.ll -S -o fftmisc_reorderloads.ll
	# $(LLC) $(LLC_FLAGS)  -o fftmisc_reorderloads.o fftmisc_reorderloads.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ -I fourier.h -I ddcmath.h -I ddc.h fourierf.c -o fourierf.ll;
	$(OPT) -always-inline fourierf.ll -S -o fourierf_inline.ll;
	$(OPT) -passes=$(PASS) fourierf_inline.ll -S -o fourierf_inline_after_unroll.ll;
	$(OPT) -passes="helloworld" fourierf_inline_after_unroll.ll -S -o fourierf_reorderloads.ll
	# $(LLC) $(LLC_FLAGS)  -o fourierf_reorderloads.o fourierf_reorderloads.ll;

	$(COMPILER_CLANG) $(FLAGS) main.c  -I /opt/riscv/sysroot/usr/include/ -o main.ll;
	$(OPT) -always-inline main.ll -S -o main_inline.ll;
	$(OPT) -passes=$(PASS) main_inline.ll -S -o main_inline_after_unroll.ll;
	$(OPT) -passes="helloworld" main_inline_after_unroll.ll -S -o main_reorderloads.ll
	$(LLVM_LINK) -S main_reorderloads.ll fourierf_reorderloads.ll fftmisc_reorderloads.ll -o main_reorderloads_o.ll;
	$(LLC) $(LLC_FLAGS)  -o main_reorderloads.o main_reorderloads.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) $(FILE1)   fourier.h ddcmath.h ddc.h -o main_reorderloads -lm -lc;

clean:
	rm -rf *.o fft output*
