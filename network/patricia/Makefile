OPT = opt
PASS = 'default<O3>,helloworld'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64gc -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdio.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdlib.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/math.h
RISCV_COMPILER = riscv64-unknown-elf-gcc
RISCV_FLAGS = -static -mcmodel=medany -march=rv64gc -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot/

patricia: patricia.c patricia_test.c
	$(CC) $(CFLAGS) patricia.c patricia_test.c -o patricia
	$(COMPILER_CLANG) $(FLAGS) -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ patricia.c -o patricia.ll;
	$(OPT) -passes=$(PASS) patricia.ll -S -o patricia_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o patricia.o patricia.ll;
	$(LLC) $(LLC_FLAGS) -o patricia_reorderloads.o patricia_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) patricia_reorderloads.o patricia_test.c -I /home/ravikiran/work/chipyard/riscv-tools-install/sysroot/usr/include/ -o patricia_reorderloads -lm;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) patricia.o patricia_test.c -I /home/ravikiran/work/chipyard/riscv-tools-install/sysroot/usr/include/ -o patricia -lm;

	$(COMPILER_CLANG) $(FLAGS) -Wall -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ --sysroot=/opt/riscv/sysroot/ patricia_test.c -o patricia_test.ll;
	$(OPT) -passes=$(PASS) patricia_test.ll -S -o patricia_test_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o patricia_test.o patricia_test.ll;
	$(LLC) $(LLC_FLAGS) -o patricia_test_reorderloads.o patricia_test_reorderloads.ll;


	$(RISCV_COMPILER) $(RISCV_FLAGS) patricia_reorderloads.o patricia_test_reorderloads.o -o patricia_reorderloads;
	$(RISCV_COMPILER) $(RISCV_FLAGS) patricia.o patricia_test.o -o patricia;
	
clean:
	rm -rf patricia output*
