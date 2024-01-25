/* NIST Secure Hash Algorithm */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "sha.h"

int main(int argc, char **argv)
{
    FILE *fin;
    SHA_INFO sha_info;

    if (argc < 2) {
	fin = stdin;
	__asm volatile("xor x0,x0,x0");
	sha_stream(&sha_info, fin);
	__asm volatile("xor x0,x0,x0");
	sha_print(&sha_info);
    } else {
	while (--argc) {
	    fin = fopen(*(++argv), "rb");
	    if (fin == NULL) {
		printf("error opening %s for reading\n", *argv);
	    } else {
		__asm volatile("xor x0,x0,x0");
		sha_stream(&sha_info, fin);
		__asm volatile("xor x0,x0,x0");
		sha_print(&sha_info);
		fclose(fin);
	    }
	}
    }
    return(0);
}
