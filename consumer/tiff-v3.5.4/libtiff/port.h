/*
 * Warning, this file was automatically created by the TIFF configure script
 * VERSION:	 v3.5.4
 * DATE:	 Tue Apr 5 12:51:15 CEST 2022
 * TARGET:	 x86_64-unknown-linux
 * CCOMPILER:	 /home/ssingh/riscv/riscv-gnu-toolchain/build/bin/riscv64-unknown-linux-gnu-gcc-10.2.0 (GCC)
 */
#ifndef _PORT_
#define _PORT_ 1
#ifdef __cplusplus
extern "C" {
#endif
#include <sys/types.h>
#define HOST_FILLORDER FILLORDER_MSB2LSB
#define HOST_BIGENDIAN	1
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
typedef double dblparam_t;
#ifdef __STRICT_ANSI__
#define	INLINE	__inline__
#else
#define	INLINE	inline
#endif
#define GLOBALDATA(TYPE,NAME)	extern TYPE NAME
#ifdef __cplusplus
}
#endif
#endif
