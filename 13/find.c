#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#if 0
#define WIDTH  80
#define HEIGHT 40
#define FAVENUM  1350
#define FINISH_X 31
#define FINISH_Y 39
#else
#define WIDTH    10
#define HEIGHT   7
#define FAVENUM  10
#define FINISH_X 7
#define FINISH_Y 4
#endif

#if 1
#define DEBUG(...) fprintf(stderr, __VA_ARGS__)
#else
#define DEBUG(...)
#endif

void display();

char num2bin(int num, char *out) {
	char *bitvalue;
	char count;

	out[0] = '\0';
	count = 0;

	unsigned int bit;
	for (bit = pow(2, 31); bit > 0; bit >>= 1) {
		bitvalue = ((num & bit) == bit) ? "1" : "0";
		//DEBUG("bit: %u\n", bit);

		strcat(out, bitvalue);

		if (bitvalue == "1")
			count++;
	}

	/* printf("sizeof(int) %d\n", sizeof(int)); */

	return count;
}


static char *buffer;

int main(void)
{
	int x;
	int y;
	int res;
	char bin[32];
	char count, even;

	buffer = calloc(WIDTH * HEIGHT, sizeof(char));

	for (x=0; x<WIDTH; x++) {
		for (y=0; y<HEIGHT; y++) {
			res = (x * x) + (3 * x) + (2 * x * y) + y + (y * y);
			res += FAVENUM;

			count = num2bin(res, bin);
			even = !(count % 2);

			DEBUG("x: %d y: %d\tres: %d "
                              "bin: \t%s count: %d even: %d\n",
			      x, y, res, bin, count, even);

			buffer[(y * WIDTH) + x] = even;
		}
	}

	display();

	free(buffer);

}

void display()
{
	int x, y;
	char chars[4] = {0};

	/* print top (x) coordinates */
	DEBUG("   ");
	for  (x=0; x<WIDTH; x++) {
		snprintf(chars, 4, "%02d", x);
		DEBUG("%c", chars[0]);

	}
	DEBUG("\n   ");
	for  (x=0; x<WIDTH; x++) {
		snprintf(chars, 4, "%02d", x);
		DEBUG("%c", chars[1]);
	}
	DEBUG("\n");

	/* print left (y) coordinates and map */
	for (y=0; y<HEIGHT; y++) {
		DEBUG("%02d ", y);
		for (x=0; x<WIDTH; x++) {
			if (x == 1 && y == 1)
				DEBUG("S");
			else if (x == FINISH_X && y == FINISH_Y)
				DEBUG("F");
			else if (buffer[(y*WIDTH)+x] == 0)
				DEBUG("#");
			else
				DEBUG(" ");
		}
		DEBUG("\n");
	}
}
