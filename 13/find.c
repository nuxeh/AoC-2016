#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#if 0
#define FAVENUM 1350
#else
#define FAVENUM 10
#endif

char *num2bin(int num) {
	static char out[32];
	out[0] = '\0';

	unsigned int bit;
	for (bit = pow(2, 31); bit > 0; bit >>= 1) {
		printf("bit: %u\n", bit);
		strcat(out, ((num & bit) == bit) ? "1" : "0");
	}

	/* printf("sizeof(int) %d\n", sizeof(int)); */

	return out;
}


int main(void)
{
	int x;
	int y;
	int res;

	for (x=0; x<80; x++) {
		for (y=0; y<40; y++) {
			res = (x * x) + (3 * x) + (2 * x * y) + y + (y * y);
			res += FAVENUM;

			printf("x: %d y: %d res: %d bin: %s\n", x, y, res, num2bin(res));
		}
	}

}
