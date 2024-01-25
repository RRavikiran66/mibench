FILE = bitcnt_1.c bitcnt_2.c bitcnt_3.c bitcnt_4.c bitcnts.c bitfiles.c bitstrng.c bstr_i.c
FILE1 = bitcnt_1_reorderloads.o bitcnt_2_reorderloads.o bitcnt_3_reorderloads.o bitcnt_4_reorderloads.o bitcnts_reorderloads.o bitfiles_reorderloads.o bitstrng_reorderloads.o bstr_i_reorderloads.o 
FILE2 = bitcnt_1.o bitcnt_2.o bitcnt_3.o bitcnt_4.o bitcnts.o bitfiles.o bitstrng.o bstr_i.o  
OPT = opt
PASS = 'default<O3>,helloworld'
PASS_unroll = 'default<O3>,loop-unroll,mem2reg,simplifycfg,lcssa,loop-simplify,loop-unroll'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj -mcpu=rocket-rv64
LLC_FLAGS_RE = -O3 -filetype=obj -mcpu=macroop-fusion-inorder-rv64 --stats --enable-alias-fusion
COMPILER_CLANG = clang 
FLAGS = -O3 -S -static -nostdlib --target=riscv64 -march=rv64g -emit-llvm -static -Xclang -disable-O0-optnone -lm
INCLUDE = -I /opt/riscv/sysroot/usr/include/stdio.h -I /opt/riscv/sysroot/usr/include/stdlib.h -I /opt/riscv/sysroot/usr/include/math.h
RISCV_COMPILER = riscv64-unknown-linux-gnu-gcc
RISCV_FLAGS = -static -mcpu=rocket-rv64 -march=rv64g -mabi=lp64d -lm --sysroot=/opt/riscv/sysroot

# --misched=ilpmax  --enable-misched=true  --misched-fusion  -mattr=+f,+lui-addi-fusion --misched-cluster

bitcnts: ${FILE} Makefile
	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_1.c -o bitcnt_1.ll;
	$(LLC) $(LLC_FLAGS) -o bitcnt_1.o bitcnt_1.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_1.o -o bitcnt_1;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_2.c -o bitcnt_2.ll;
	$(LLC) $(LLC_FLAGS) -o bitcnt_2.o bitcnt_2.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2.o -o bitcnt_2;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_3.c -o bitcnt_3.ll;
	$(LLC) $(LLC_FLAGS) -o bitcnt_3.o bitcnt_3.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_3.o -o bitcnt_3;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_4.c -o bitcnt_4.ll;
	$(LLC) $(LLC_FLAGS) -o bitcnt_4.o bitcnt_4.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_4.o -o bitcnt_4;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnts.c -o bitcnts.ll;
	$(LLC) $(LLC_FLAGS) -o bitcnts.o bitcnts.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnts.o -o bitcnts;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitfiles.c -o bitfiles.ll;
	$(LLC) $(LLC_FLAGS) -o bitfiles.o bitfiles.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitfiles.o -o bitfiles;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitstrng.c -o bitstrng.ll;
	$(LLC) $(LLC_FLAGS) -o bitstrng.o bitstrng.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitstrng.o -o bitstrng;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bstr_i.c -o bstr_i.ll;
	$(LLC) $(LLC_FLAGS) -o bstr_i.o bstr_i.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bstr_i.o -o bstr_i;

	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE2} -o bitcnts;

bitcnts_reorderloads: ${FILE} Makefile
	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_1.c -o bitcnt_1.ll;
	$(OPT) -passes=$(PASS) bitcnt_1.ll -S -o bitcnt_1_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)   -o bitcnt_1_reorderloads.o bitcnt_1_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_1_reorderloads.o -o bitcnt_1_reorderloads;


	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_2.c -o bitcnt_2.ll;
	$(OPT) -passes=$(PASS) bitcnt_2.ll -S -o bitcnt_2_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)    -o bitcnt_2_reorderloads.o bitcnt_2_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_2_reorderloads.o -o bitcnt_2_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_3.c -o bitcnt_3.ll;
	$(OPT) -passes=$(PASS) bitcnt_3.ll -S -o bitcnt_3_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)    -o bitcnt_3_reorderloads.o bitcnt_3_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_3_reorderloads.o -o bitcnt_3_reorderloads;


	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnt_4.c -o bitcnt_4.ll;
	$(OPT) -passes=$(PASS) bitcnt_4.ll -S -o bitcnt_4_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)   -o bitcnt_4_reorderloads.o bitcnt_4_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnt_4_reorderloads.o -o bitcnt_4_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitcnts.c -o bitcnts.ll;
	$(OPT) -passes=always-inline bitcnts.ll -S -o bitcnts_inline.ll
	$(OPT) -passes=$(PASS_unroll) bitcnts_inline.ll -S -o bitcnts_unroll.ll;
	$(OPT) -passes="helloworld" bitcnts_unroll.ll -S -o bitcnts_reorderloads.ll
	$(LLC) $(LLC_FLAGS)    -o bitcnts_reorderloads.o bitcnts_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitcnts_reorderloads.o -o bitcnts_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitfiles.c -o bitfiles.ll;
	# $(OPT) -passes=$(PASS) bitfiles.ll -S -o bitfiles_reorderloads.ll; //not work check
	$(LLC) $(LLC_FLAGS)   -o bitfiles_reorderloads.o bitfiles.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitfiles_reorderloads.o -o bitfiles_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bitstrng.c -o bitstrng.ll;
	$(OPT) -passes=$(PASS) bitstrng.ll -S -o bitstrng_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)   -o bitstrng_reorderloads.o bitstrng_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bitstrng_reorderloads.o -o bitstrng_reorderloads;

	# $(CC) $(CFLAGS) ${FILE} -o bitcnts
	$(COMPILER_CLANG) $(FLAGS) -I /opt/riscv/sysroot/usr/include/ bstr_i.c -o bstr_i.ll;
	$(OPT) -passes=$(PASS) bstr_i.ll -S -o bstr_i_reorderloads.ll;
	$(LLC) $(LLC_FLAGS)   -o bstr_i_reorderloads.o bstr_i_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) bstr_i_reorderloads.o -o bstr_i_reorderloads;

	$(RISCV_COMPILER) $(RISCV_FLAGS) ${FILE1} -o bitcnts_reorderloads;
clean:
	rm -rf bitcnts output*
