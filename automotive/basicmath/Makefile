FILE1 = basicmath_small.c   rad2deg.c  cubic.c   isqrt.c
FILE2 = basicmath_large.c   rad2deg.c  cubic.c   isqrt.c

OPT = opt
PASS = 'default<O3>,helloworld,mem2reg,simplifycfg,lcssa,loop-simplify,loop-rotate' 
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_re = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --dot-cfg-mssa=dot --stats --misched=default -verify-misched --misched-bottomup --unroll-full-max-count=9999 --enable-unroll-and-jam --misched-cluster --misched-fusion --enable-misched=true -mattr=+f,+lui-addi-fusion
# --enable-misched=true  --misched-fusion  -mattr=+f,+macrofusion,+lui-addi-fusion --misched-cluster
COMPILER_CLANG = clang 
FLAGS = -O3 -S -static -nostdlib --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -mcpu=rocket-rv64 -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot
LLVM_LINK = llvm-link
all: basicmath_small basicmath_small_reorderloads basicmath_large basicmath_large_reorderloads

basicmath_small: ${FILE1} Makefile
	# gcc -static -O3 ${FILE1} -o basicmath_small -lm

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ rad2deg.c -o rad2deg.ll;
	$(LLC) $(LLC_FLAGS) -o rad2deg.o rad2deg.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ cubic.c -o cubic.ll;
	$(LLC) $(LLC_FLAGS) -o cubic.o cubic.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ isqrt.c -o isqrt.ll;
	$(LLC) $(LLC_FLAGS) -o isqrt.o isqrt.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ basicmath_small.c -o basicmath_small.ll;
	$(LLC) $(LLC_FLAGS) -o basicmath_small.o basicmath_small.ll;	
	$(RISCV_COMPILER) $(RISCV_FLAGS) basicmath_small.o cubic.o isqrt.o rad2deg.o -I /opt/riscv/sysroot/usr/include/ -o basicmath_small -lm;

# basicmath_small_reorderloads: ${FILE1} Makefile
# 	# gcc -static -O3 ${FILE1} -o basicmath_small -lm

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ rad2deg.c -o rad2deg.ll;
# 	$(OPT) -passes=$(PASS) rad2deg.ll -S -o rad2deg_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o rad2deg_reorderloads.o rad2deg_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ cubic.c -o cubic.ll;
# 	$(OPT) -passes=$(PASS) cubic.ll -S -o cubic_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o cubic_reorderloads.o cubic_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ isqrt.c -o isqrt.ll;
# 	$(OPT) -passes=$(PASS) isqrt.ll -S -o isqrt_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o isqrt_reorderloads.o isqrt_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ basicmath_small.c -o basicmath_small.ll;
# 	$(OPT) -passes='loop-unroll' basicmath_small.ll -S -o basicmath_small_unroll.ll;
# 	$(OPT) -passes=$(PASS) basicmath_small_unroll.ll -S -o basicmath_small_reorderloads.ll;
# 	$(LLVM_LINK) -S rad2deg_reorderloads.ll isqrt_reorderloads.ll cubic_reorderloads.ll basicmath_small_reorderloads.ll -o basicmath_small_reorderloads_o.ll
# 	$(LLC) $(LLC_FLAGS)  -o basicmath_small_reorderloads_o.o basicmath_small_reorderloads_o.ll;
# 	$(RISCV_COMPILER) $(RISCV_FLAGS) basicmath_small_reorderloads_o.o -I /opt/riscv/sysroot/usr/include/ -o basicmath_small_reorderloads -lm;
# 	# $(RISCV_COMPILER) $(RISCV_FLAGS) basicmath_small_reorderloads.o cubic_reorderloads.o isqrt_reorderloads.o rad2deg_reorderloads.o -I /opt/riscv/sysroot/usr/include/ -o basicmath_small_reorderloads -lm;

basicmath_large: ${FILE2} Makefile
	# gcc -static -O3 ${FILE2} -o basicmath_large -lm

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ rad2deg.c -o rad2deg.ll;
	$(LLC) $(LLC_FLAGS) -o rad2deg.o rad2deg.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ cubic.c -o cubic.ll;
	$(LLC) $(LLC_FLAGS)  -o cubic.o cubic.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ isqrt.c -o isqrt.ll;
	$(LLC) $(LLC_FLAGS) -o isqrt.o isqrt.ll;

	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ basicmath_large.c -o basicmath_large.ll;
	$(LLC) $(LLC_FLAGS) -o basicmath_large.o basicmath_large.ll;
	$(RISCV_COMPILER) $(RISCV_FLAGS) basicmath_large.o cubic.o isqrt.o rad2deg.o -I /opt/riscv/sysroot/usr/include/ -o basicmath_large -lm;

# basicmath_large_reorderloads: ${FILE2} Makefile
# 	# gcc -static -O3 ${FILE2} -o basicmath_large -lm

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ rad2deg.c -o rad2deg.ll;
# 	$(OPT) -passes=$(PASS) rad2deg.ll -S -o rad2deg_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o rad2deg_reorderloads.o rad2deg_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ cubic.c -o cubic.ll;
# 	$(OPT) -passes=$(PASS) cubic.ll -S -o cubic_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o cubic_reorderloads.o cubic_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ isqrt.c -o isqrt.ll;
# 	$(OPT) -passes=$(PASS) isqrt.ll -S -o isqrt_reorderloads.ll;
# 	$(LLC) $(LLC_FLAGS)  -o isqrt_reorderloads.o isqrt_reorderloads.ll;

# 	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ basicmath_large.c -o basicmath_large.ll;
# 	$(OPT) -passes='loop-unroll' basicmath_large.ll -S -o basicmath_large_unroll.ll;
# 	$(OPT) -passes=$(PASS) basicmath_large.ll -S -o basicmath_large_reorderloads.ll;
# 	$(LLVM_LINK) -S rad2deg_reorderloads.ll isqrt_reorderloads.ll cubic_reorderloads.ll basicmath_large_reorderloads.ll -o basicmath_large_reorderloads_o.ll
# 	$(LLC) $(LLC_FLAGS)  -o basicmath_large_reorderloads_o.o basicmath_large_reorderloads_o.ll;
# 	$(RISCV_COMPILER) $(RISCV_FLAGS) basicmath_large_reorderloads_o.o -I /opt/riscv/sysroot/usr/include/ -o basicmath_large_reorderloads -lm;

clean:
	rm -rf basicmath_small basicmath_large output*