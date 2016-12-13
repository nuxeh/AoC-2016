#include <stdlib.h>
#include <stdio.h>

#if 0
#define FAVENUM 1350
#else
#define FAVENUM 10
#endif


int main(void)
{
	int x;
	int y;
	int res;

	for (x=0; x<9; x++) {
		for (y=0; y<6; y++) {
			res = (x * x) + (3 * x) + (2 * x * y) + y + (y * y);
			res += FAVENUM;

			printf("x: %d y: %d res: %d\n", x, y, res);
		}
	}



}
