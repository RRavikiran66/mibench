TIME=/usr/bin/time
TIME_FORMAT="%Es\telapsed\n%Us\tuser\n%Ss\tsystem\n%MkB\n"

TRACE_LOCATION=/home/ravikiran/work/output_mibench
TRACE_LOCATION_base=/home/ravikiran/work/output_mibench_baseline
FILE = bitcnt_1.c bitcnt_2.c bitcnt_3.c bitcnt_4.c bitcnts.c bitfiles.c bitstrng.c bstr_i.c
FILE1 = bitcnt_1_reorderloads.o bitcnt_2_reorderloads.o bitcnt_3_reorderloads.o bitcnt_4_reorderloads.o bitcnts_reorderloads.o bitfiles_reorderloads.o bitstrng_reorderloads.o bstr_i_reorderloads.o 
FILE2 = bitcnt_1.o bitcnt_2.o bitcnt_3.o bitcnt_4.o bitcnts.o bitfiles.o bitstrng.o bstr_i.o  

# ISA=--isa=rv64gc
# RISCV=/home/ravikiran/work/LLVM/ProSpike/build/spike
# PK=/home/ravikiran/work/LLVM/ProSpike/build/pk
# COMPILER="CC=riscv64-unknown-elf-gcc"

# clang -O3 -S --target=riscv64 -march=rv64imafdc -emit-llvm -static -I /usr/include/math.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include  dijkstra_large.c -Xclang -d -fisable-O0-optnone -o dijkstra.ll
# opt -passes='default<O3>,helloworld' dijkstra.ll -S -o dijkstra_reorderloads.ll
# llc -O3  -filetype=obj -o dijkstra.s dijkstra.ll
# riscv64-unknown-elf-gcc -S -march=rv64gc -mabi=lp64 your_source_file.c -o your_output_file.s
OPT = opt
PASS = 'default<O3>,helloworld'
LLC = llc 
LLC_FLAGS = -O3 -filetype=obj 
COMPILER_CLANG = clang 
FLAGS = -O3 -S --target=riscv64 -march=rv64imafd -emit-llvm -static -Xclang -d -fisable-O0-optnone -lm -ansi
INCLUDE = -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdio.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/stdlib.h -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/math.h
RISCV_COMPILER = riscv64-unknown-elf-gcc
RISCV_FLAGS = -march=rv64imafd -mabi=lp64d -mcpu=sifive-u74 -lm --sysroot=/opt/riscv/sysroot
RISCV=/home/ravikiran/work/Spike/build/spike
PK=/home/ravikiran/work/riscv-tools/riscv-pk/build/pk
ISA=rv64g
#COMPILER="CC=/home/ssingh/llvm-build/bin/clang"

#FLAGS="CFLAGS=-O3 -static --sysroot=/home/ssingh/riscv/riscv-gnu-toolchain/build/sysroot --gcc-toolchain=/home/ssingh/riscv/riscv-gnu-toolchain/build --target=riscv64-unknown-linux-gnu -march=rv64g -mabi=lp64d"
#LDFLAGS="LDFLAGS=-static --sysroot=/home/ssingh/riscv/riscv-gnu-toolchain/build/sysroot --gcc-toolchain=/home/ssingh/riscv/riscv-gnu-toolchain/build --target=riscv64-unknown-linux-gnu -march=rv64g -mabi=lp64d"

FFLAG=long
LABEL=$(FFLAG)

# FLAGS="CFLAGS=-O3 -static"
#FLAGS="CFLAGS=-O3 -static -mcpu=$(FFLAG) --sysroot=/home/ssingh/riscv/riscv-gnu-toolchain/build/sysroot --gcc-toolchain=/home/ssingh/riscv/riscv-gnu-toolchain/build --target=riscv64-unknown-linux-gnu -march=rv64g -mabi=lp64d"

.PHONY: clean clean

build_all: basicmath bitcount qsort susan dijkstra stringsearch sha CRC32

build_all_reorder: basicmath_reordered bitcount_reordered qsort_reordered susan_reordered dijkstra_reordered stringsearch_reordered sha_reordered CRC32_reordered

build_automotive: basicmath bitcount qsort susan
build_consumer: jpeg lame typeset mad 
build_network: dijkstra patricia
#build_office: ghostscript ispell rsynth sphinx stringsearch
#build_office: ispell rsynth sphinx stringsearch
#build_office: rsynth sphinx stringsearch
build_office: rsynth stringsearch

#build_security: blowfish pgp rijndael sha
#build_security: blowfish rijndael sha
build_security: blowfish sha

build_telecomm: CRC32 FFT adpcm gsm

build_llvm: basicmath bitcount qsort susan dijkstra CRC32 FFT stringsearch sha

basicmath:
	cd automotive/basicmath; make basicmath_large; make basicmath_small

basicmath_reordered:
	cd automotive/basicmath; make basicmath_large_reorderloads; make basicmath_small_reorderloads

bitcount:
	cd automotive/bitcount; make bitcnts

bitcount_reordered:
	cd automotive/bitcount; make bitcnts_reorderloads

qsort:
	cd automotive/qsort; make qsort_large; make qsort_small

qsort_reordered:
	cd automotive/qsort; make qsort_large_reorderloads; make qsort_small_reorderloads

susan:
	cd automotive/susan; make susan

susan_reordered:
	cd automotive/susan; make susan_reorderloads

jpeg:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C consumer/jpeg/jpeg-6a

lame:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C consumer/lame/lame3.70

typeset:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C consumer/typeset/lout-3.24

dijkstra:
	cd network/dijkstra; make dijkstra_large; make dijkstra_small;	

dijkstra_reordered:
	cd network/dijkstra; make dijkstra_large_reorderloads; make dijkstra_small_reorderloads;

patricia:
	$(COMPILER_CLANG) $(FLAGS) -I /home/ravikiran/work/chipyard/riscv-tools-install/riscv64-unknown-elf/include/ network/patricia/patricia.c -o network/patricia/patricia.ll;
	# $(OPT) -passes=$(PASS) network/patricia/patricia.ll -S -o network/patricia/patricia_reorderloads.ll;
	$(LLC) $(LLC_FLAGS) -o network/patricia/patricia.o network/patricia/patricia.ll;
	# $(LLC) $(LLC_FLAGS) -o network/patricia/patricia_reorderloads.o network/patricia/patricia_reorderloads.ll;
	# $(RISCV_COMPILER) $(RISCV_FLAGS) network/patricia/patricia_reorderloads.o -o network/patricia/patricia_reorderloads;
	$(RISCV_COMPILER) $(RISCV_FLAGS) network/patricia/patricia.o -o network/patricia/patricia;


stringsearch:
	cd office/stringsearch; make search_large; make search_small;

stringsearch_reordered:
	cd office/stringsearch; make search_large_reordered; make search_small_reordered;

blowfish:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C security/blowfish

sha:
	cd security/sha; make sha;

sha_reordered:
	cd security/sha; make sha_reorderloads;

CRC32:
	cd telecomm/CRC32; make crc;

CRC32_reordered:
	cd telecomm/CRC32; make crc_32_reorderloads;

FFT:
	cd telecomm/FFT; make fft;

adpcm:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C telecomm/adpcm/src

gsm:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C telecomm/gsm

ghostscript:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C office/ghostscript/src

ispell:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C office/ispell

rsynth:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C office/rsynth

sphinx:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C office/sphinx/src

pgp:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) linux -C security/pgp/src

rijndael:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C security/rijndael

adpcm:
	$(MAKE) -k  $(COMPILER) $(FLAGS) $(LDFLAGS) -C telecomm/adpcm/src

run_qsort:
	@echo qsort_large
	cd automotive/qsort; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name qsort_large_$(LABEL) --config-name baseline_qsortlarge $(PK) ./qsort_large input_large.dat > output_large.log
	cd  ../output_mibench/; gzip -d -f qsort_large_long_p0-Trace.gz
	cd  ../output_mibench/; cut -f1 qsort_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_large.txt
	cd ../output_mibench; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/qsort/qsort_large > qsort_large.objdump
	
	@echo qsort_small
	cd automotive/qsort; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name qsort_small_$(LABEL) --config-name baseline_qsortsmall $(PK) ./qsort_small input_small.dat > output_small.log
	cd  ../output_mibench/; gzip -d -f qsort_small_long_p0-Trace.gz
	cd  ../output_mibench/; cut -f1 qsort_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_small.txt
	cd ../output_mibench; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/qsort/qsort_small > qsort_small.objdump

run_str_search:
	@echo stringsearch_large
	cd office/stringsearch; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name stringsearch_large_$(LABEL) --config-name baseline_stringsearchlarge $(PK) ./pbmsrch_large 100 > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f stringsearch_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 stringsearch_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/office/stringsearch/pbmsrch_large > stringsearch_large.objdump

	@echo stringsearch_small
	cd office/stringsearch; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name stringsearch_small_$(LABEL) --config-name baseline_stringsearchsmall $(PK) ./pbmsrch_small 100 > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f stringsearch_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 stringsearch_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/office/stringsearch/pbmsrch_small > stringsearch_small.objdump

run_all:
	# cd .. && rm -r output_mibench_baseline/*
	@echo bitcount
	cd automotive/bitcount;  $(RISCV) --isa=$(ISA) -m8000  --trace-location $(TRACE_LOCATION_base) --trace-name bitcount_$(LABEL) --config-name baseline_bitcount $(PK) ./bitcnts 1125000 > output.log
	cd  ../output_mibench_baseline/; gzip -d -f -f bitcount_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 bitcount_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_bitcnts.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/bitcount/bitcnts > bitcnts.objdump

	@echo crc
	cd telecomm/CRC32; $(RISCV) --isa=$(ISA) -m8000  --trace-location $(TRACE_LOCATION_base) --trace-name crc_$(LABEL) --config-name baseline_crc $(PK) ./crc_32 ../adpcm/data/large.pcm > output.log
	cd  ../output_mibench_baseline/;  gzip -d -f crc_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 crc_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_crc.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/telecomm/CRC32/crc_32 > crc_32.objdump

	@echo dijkstra_small
	cd network/dijkstra; $(RISCV) --isa=$(ISA) -m8000  --trace-location $(TRACE_LOCATION_base) --trace-name dijkstra_small_$(LABEL) --config-name baseline_dijkstrasmall $(PK) ./dijkstra_small input.dat > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f dijkstra_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 dijkstra_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_dijkstra_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/network/dijkstra/dijkstra_small > dijkstra_small.objdump

	@echo dijkstra_large
	cd network/dijkstra; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name dijkstra_large_$(LABEL) --config-name baseline_dijkstralarge $(PK) ./dijkstra_large input.dat > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f dijkstra_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 dijkstra_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_dijkstra_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/network/dijkstra/dijkstra_large > dijkstra_large.objdump

	@echo sha_small
	cd security/sha; $(RISCV) --isa=$(ISA) -m8000  --trace-location $(TRACE_LOCATION_base) --trace-name sha_small_$(LABEL) --config-name baseline_shasmall $(PK) ./sha_driver input_large.asc > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f sha_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 sha_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_sha_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/security/sha/sha_driver > sha_small.objdump

	@echo sha_large
	cd security/sha; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name sha_large_$(LABEL) --config-name baseline_shalarge $(PK) ./sha_driver input_small.asc > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f sha_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 sha_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_sha_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/security/sha/sha_driver > sha_large.objdump

	@echo stringsearch_large
	cd office/stringsearch; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name stringsearch_large_$(LABEL) --config-name baseline_stringsearchlarge $(PK) ./pbmsrch_large 100 > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f stringsearch_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 stringsearch_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/office/stringsearch/pbmsrch_large > stringsearch_large.objdump

	@echo stringsearch_small
	cd office/stringsearch; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name stringsearch_small_$(LABEL) --config-name baseline_stringsearchsmall $(PK) ./pbmsrch_small 100 > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f stringsearch_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 stringsearch_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/office/stringsearch/pbmsrch_small > stringsearch_small.objdump

	@echo susan
	cd automotive/susan; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name susan_$(LABEL) --config-name baseline_susan $(PK) ./susan input_large.pgm output_large.pgm -s > output.log
	cd  ../output_mibench_baseline/; gzip -d -f susan_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 susan_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_susan.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/susan/susan > susan.objdump

	@echo qsort_small
	cd automotive/qsort; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name qsort_small_$(LABEL) --config-name baseline_qsortsmall $(PK) ./qsort_small input_small.dat > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f qsort_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 qsort_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/qsort/qsort_small > qsort_small.objdump

	@echo qsort_large
	cd automotive/qsort; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name qsort_large_$(LABEL) --config-name baseline_qsortlarge $(PK) ./qsort_large input_large.dat > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f qsort_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 qsort_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/qsort/qsort_large > qsort_large.objdump
	
	# @echo fft 
	# -cd telecomm/FFT; $(RISCV) --isa=$(ISA)  --trace-location $(TRACE_LOCATION_base) --trace-name fft_$(LABEL) $(PK) ./main 2048 32768 > output.log

	@echo basicmath_small
	cd automotive/basicmath; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name basicmath_small_$(LABEL) --config-name baseline_basicmathsmall $(PK) ./basicmath_small 1 > output_small.log
	cd  ../output_mibench_baseline/; gzip -d -f basicmath_small_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 basicmath_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_basicmath_small.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/basicmath/basicmath_small > basicmath_small.objdump

	@echo basicmath_large
	cd automotive/basicmath; $(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION_base) --trace-name basicmath_large_$(LABEL) --config-name baseline_basicmathlarge $(PK) ./basicmath_large 1 > output_large.log
	cd  ../output_mibench_baseline/; gzip -d -f basicmath_large_long_p0-Trace.gz
	cd  ../output_mibench_baseline/; cut -f1 basicmath_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_basicmath_large.txt
	cd ../output_mibench_baseline; riscv64-unknown-linux-gnu-objdump -D ../mibench/automotive/basicmath/basicmath_large > basicmath_large.objdump

run_all_unroll:
	@echo bitcount
	-cd automotive/bitcount;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name bitcount_$(LABEL) --config-name unroll_bitcount $(PK) ./bitcnts_reorderloads 1125000 > output.log
	-cd  ../output_mibench/; gzip -d -f bitcount_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 bitcount_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_bitcnts.txt

	@echo crc
	-cd telecomm/CRC32;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name crc_$(LABEL) --config-name unroll_crc $(PK) ./crc_32_reorderloads ../adpcm/data/large.pcm > output.log
	-cd  ../output_mibench/; gzip -d -f crc_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 crc_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_crc.txt

	@echo dijkstra_small
	-cd network/dijkstra;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name dijkstra_small_$(LABEL) --config-name unroll_dijkstrasmall $(PK) ./dijkstra_small_reorderloads input.dat > output_small.log
	-cd  ../output_mibench/; gzip -d -f dijkstra_small_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 dijkstra_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_dijkstra_small.txt

	@echo dijkstra_large
	-cd network/dijkstra;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name dijkstra_large_$(LABEL) --config-name unroll_dijkstralarge $(PK) ./dijkstra_large_reorderloads input.dat > output_large.log
	-cd  ../output_mibench/;gzip -d -f dijkstra_large_long_p0-Trace.gz
	-cd  ../output_mibench/;cut -f1 dijkstra_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_dijkstra_large.txt

	@echo sha_small
	-cd security/sha;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name sha_small_$(LABEL) --config-name unroll_shasmall $(PK) ./sha_driver_reorderloads input_large.asc > output_small.log
	-cd  ../output_mibench/; gzip -d -f sha_small_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 sha_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_sha_small.txt

	@echo sha_large
	-cd security/sha;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name sha_large_$(LABEL) --config-name unroll_shalarge $(PK) ./sha_driver_reorderloads input_small.asc > output_large.log
	-cd  ../output_mibench/; gzip -d -f sha_large_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 sha_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_sha_large.txt

	@echo stringsearch_large
	-cd office/stringsearch;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name stringsearch_large_$(LABEL) --config-name unroll_stringsearchlarge $(PK) ./pbmsrch_large_reorderloads 100 > output_large.log
	-cd  ../output_mibench/; gzip -d -f stringsearch_large_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 stringsearch_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_large.txt

	@echo stringsearch_small
	-cd office/stringsearch;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name stringsearch_small_$(LABEL) --config-name unroll_stringsearchsmall $(PK) ./pbmsrch_small_reorderloads 100 > output_small.log
	-cd  ../output_mibench/; gzip -d -f stringsearch_small_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 stringsearch_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_stringsearch_small.txt

	@echo susan
	-cd automotive/susan;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name susan_$(LABEL) --config-name unroll_susan $(PK) ./susan_reorderloads input_large.pgm output_large.pgm -s > output.log
	-cd  ../output_mibench/; gzip -d -f susan_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 susan_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_susan.txt

	@echo qsort_small
	-cd automotive/qsort;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name qsort_small_$(LABEL) --config-name unroll_qsortsmall $(PK) ./qsort_small_reorderloads input_small.dat > output_small.log
	-cd  ../output_mibench/; gzip -d -f qsort_small_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 qsort_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_small.txt

	@echo qsort_large
	-cd automotive/qsort;$(RISCV) --isa=$(ISA) -m8000 --trace-location $(TRACE_LOCATION) --trace-name qsort_large_$(LABEL) --config-name unroll_qsortlarge $(PK) ./qsort_large_reorderloads input_large.dat > output_large.log
	-cd  ../output_mibench/; gzip -d -f qsort_large_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 qsort_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_qsort_large.txt

	# @echo fft 
	# -cd telecomm/FFT; $(RISCV) --isa=$(ISA)  --trace-location $(TRACE_LOCATION) --trace-name fft_$(LABEL) $(PK) ./main 2048 32768 > output.log

	@echo basicmath_small
	-cd automotive/basicmath;$(RISCV) --isa=$(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_small_$(LABEL) --config-name unroll_basicmathsmall $(PK) ./basicmath_small_reorderloads 1 > output_small.log
	-cd  ../output_mibench/; gzip -d -f basicmath_small_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 basicmath_small_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_basicmath_small.txt

	@echo basicmath_large
	-cd automotive/basicmath;$(RISCV) --isa=$(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_large_$(LABEL) --config-name unroll_basicmathlarge $(PK) ./basicmath_large_reorderloads 1 > output_large.log
	-cd  ../output_mibench/; gzip -d -f basicmath_large_long_p0-Trace.gz
	-cd  ../output_mibench/; cut -f1 basicmath_large_long_p0-Trace | sort | uniq -c | sort -rn > pc_order_basicmath_large.txt

run_all_reordered:

	@echo bitcount
	-cd automotive/bitcount; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name bitcount_$(LABEL) $(PK) ./bitcnts_reorderloads 1125000 > output.log

	@echo crc
	-cd telecomm/CRC32; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name crc_$(LABEL) $(PK) ./crc_32_reorderloads ../adpcm/data/large.pcm > output.log

	@echo dijkstra_small
	-cd network/dijkstra; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name dijkstra_$(LABEL) $(PK) ./dijkstra_small_reorderloads 100 input.dat > output.log

	@echo dijkstra_large
	-cd network/dijkstra; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name dijkstra_$(LABEL) $(PK) ./dijkstra_large_reorderloads 100 input.dat > output.log

	@echo sha_small
	-cd security/sha; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name sha_$(LABEL) $(PK) ./sha_driver_reorderloads input_large.asc > output.log

	@echo sha_large
	-cd security/sha; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name sha_$(LABEL) $(PK) ./sha_driver_reorderloads input_small.asc > output.log

	@echo stringsearch_large
	-cd office/stringsearch; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name stringsearch_$(LABEL) $(PK) ./pbmsrch_large_reorderloads 100 > output.log

	@echo stringsearch_small
	-cd office/stringsearch; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name stringsearch_$(LABEL) $(PK) ./pbmsrch_small_reorderloads 100 > output.log

	@echo susan
	-cd automotive/susan; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name susan_$(LABEL) $(PK) ./susan_reorderloads input_large.pgm output_large.pgm -s

	@echo qsort_small
	-cd automotive/qsort; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name qsort_$(LABEL) $(PK) ./qsort_small_reorderloads input_small.dat > output.log

	@echo qsort_large
	-cd automotive/qsort; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name qsort_$(LABEL) $(PK) ./qsort_large_reorderloads input_large.dat > output.log

	@echo fft 
	-cd telecomm/FFT; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name fft_$(LABEL) $(PK) ./main_reorderloads 2048 32768 > output.log

	@echo basicmath_small
	-cd automotive/basicmath; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_$(LABEL) $(PK) ./basicmath_small_reorderloads 1 > output.log

	@echo basicmath_large
	-cd automotive/basicmath; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_$(LABEL) $(PK) ./basicmath_large_reorderloads 1 > output.log

#Setup for the LLVM

run_llvm:
	@echo basicmath
	-cd automotive/basicmath; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_$(LABEL) pk ./basicmath_small > output_$(LABEL).log
	@echo bitcount
	-cd automotive/bitcount; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name bitcount_$(LABEL) pk ./bitcnts 1125000 > output_$(LABEL).log
	@echo qsort
	-cd automotive/qsort; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name qsort_$(LABEL) pk ./qsort_large input_large.dat > output_$(LABEL).log
	@echo susan
	-cd automotive/susan; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name susan_$(LABEL) pk ./susan input_large.pgm output_large.smoothing.pgm -s > output_$(LABEL).log
	@echo patricia
	-cd network/patricia; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name patricia_$(LABEL) pk ./patricia large.udp > output_$(LABEL).log
	@echo dijkstra
	-cd network/dijkstra; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name dijkstra_$(LABEL) pk ./dijkstra_large input.dat > output_$(LABEL).log
	@echo adpcm	
	 -cd telecomm/adpcm; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name adpcm_$(LABEL) pk ./src/rawcaudio < data/large.pcm > output_$(LABEL).log
	@echo crc
	-cd telecomm/CRC32; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name crc_$(LABEL) pk ./crc ../adpcm/data/large.pcm > output_$(LABEL).log
	@echo fft 
	-cd telecomm/FFT; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name fft_$(LABEL) pk ./fft 8 32768 > output_$(LABEL).log
	@echo stringsearch
	-cd office/stringsearch; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name stringsearch_$(LABEL) pk ./search_large > output_$(LABEL).log
	@echo rsynth
	-cd office/rsynth; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name rsynth_$(LABEL) pk ./say -a -q -o large_output.au < largeinput.txt > output_$(LABEL).log

run_adpcm:
	@echo adpcm
	-cd telecomm/adpcm; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name adpcm_$(LABEL) pk ./bin/rawcaudio < data/large.pcm > output.log
run_basicmath:
	@echo basicmath
	-cd automotive/basicmath; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name basicmath_$(LABEL) pk ./basicmath_large > output.log
run_bitcount:
	@echo bitcount
	-cd automotive/bitcount; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name bitcount_$(LABEL) pk ./bitcnts 1125000 > output.log
run_blowfish:
	@echo blowfish
	-cd security/blowfish; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name blowfish_$(LABEL) pk ./bf e input.asc output.enc 1234567890ab-cdeffedcba0987654321
run_crc:
	@echo crc
	-cd telecomm/CRC32; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name crc_$(LABEL) pk ./crc ../adpcm/data/large.pcm > output.log
run_dijkstra:
	@echo dijkstra
	-cd network/dijkstra; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name dijkstra_$(LABEL) pk ./dijkstra 100 input.dat > output.log
run_fft:
	@echo fft 
	-cd telecomm/FFT; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name fft_$(LABEL) pk ./fft 2048 32768 > output.log
run_gsm:
	@echo gsm
	-cd telecomm/gsm; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name gsm_$(LABEL) pk ./bin/toast -fps -c data/large.au > output.log
run_jpeg:
	@echo jpeg
	-cd consumer/jpeg; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name jpeg_$(LABEL) pk jpeg -d -fct int -progressive -opt -outfile output_encode.jpeg input.ppm
run_patricia:
	@echo patricia
	-cd network/patricia; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name patricia_$(LABEL) pk ./patricia large.udp > output.log
# run_qsort:
# 	@echo qsort
# 	-cd automotive/qsort; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name qsort_$(LABEL) pk ./qsort input.dat > output.log
run_sha:
	@echo sha
	-cd security/sha; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name sha_$(LABEL) pk ./sha input.asc > output.log
run_stringsearch:
	@echo stringsearch
	-cd office/stringsearch; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name stringsearch_$(LABEL) pk ./search 100 > output.log
run_susan:
	@echo susan
	-cd automotive/susan; $(RISCV) $(ISA)  --trace-location $(TRACE_LOCATION) --trace-name susan_$(LABEL) pk ./susan input_large.pgm output.smoothing.pgm -s

.PHONY clean:
	-rm -rf bin/basicmath
	-rm -rf bin/bitcount
	-rm -rf bin/blowfish
	-rm -rf bin/jpeg
	-rm -rf bin/crc
	-rm -rf bin/dijkstra
	-rm -rf bin/djpeg
	-rm -rf bin/fft
	-rm -rf bin/lame
	-rm -rf bin/lout
	-rm -rf bin/patricia
	-rm -rf bin/qsort
	-rm -rf bin/qsort
	-rm -rf bin/rawcaudio
	-rm -rf bin/rawdaudio
	-rm -rf bin/sha
	-rm -rf bin/stringsearch
	-rm -rf bin/susan
	-rm -rf bin/toast
	-rm -rf bin/untoast
	-rm -rf bin/lout.li

clean:
	-rm -rf bin/*output*
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C automotive/basicmath clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C automotive/bitcount clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C automotive/qsort clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C automotive/susan clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C consumer/jpeg/jpeg-6a clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C consumer/lame/lame3.70 clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C consumer/typeset/lout-3.24 clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C network/dijkstra clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C network/patricia clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C office/stringsearch clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C security/blowfish clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C security/sha clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C telecomm/CRC32 clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C telecomm/FFT clean
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C telecomm/adpcm/src clean 
	$(MAKE) -k  $(COMPILER) $(FLAGS) -C telecomm/gsm clean 
