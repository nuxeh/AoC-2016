#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#if 0
#define FAVENUM 1350
#else
#define FAVENUM 10
#endif

#if 1
#define DEBUG(s,f) printf(s,f)
#else
#define DEBUG(s,f)
#endif

char num2bin(int num, char *out) {
	char *bitvalue;
	char count;

	out[0] = '\0';
	count = 0;

	unsigned int bit;
	for (bit = pow(2, 31); bit > 0; bit >>= 1) {
		bitvalue = ((num & bit) == bit) ? "1" : "0";
		DEBUG("bit: %u\n", bit);

		strcat(out, bitvalue);

		if (bitvalue == "1")
			count++;
	}

	/* printf("sizeof(int) %d\n", sizeof(int)); */

	return count;
}


int main(void)
{
	int x;
	int y;
	int res;
	char bin[32];
	char count;

	for (x=0; x<80; x++) {
		for (y=0; y<40; y++) {
			res = (x * x) + (3 * x) + (2 * x * y) + y + (y * y);
			res += FAVENUM;

			count = num2bin(res, bin);
			DEBUG("count: %d even: %d\n", count, count % 2);

			printf("x: %d y: %d res: %d bin: %s\n", x, y, res, bin);
		}
	}

}
