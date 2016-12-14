#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#if 1
#define WIDTH    80
#define HEIGHT   80
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

#define START_X 1
#define START_Y 1

#if 1
#define DEBUG(...) fprintf(stderr, __VA_ARGS__)
#else
#define DEBUG(...)
#endif

void display();
void solve_path();
char get_dof(char x, char y);

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

#ifdef MORE_DEBUG
			DEBUG("x: %d y: %d\tres: %d "
                              "bin: \t%s count: %d even: %d\n",
			      x, y, res, bin, count, even);
#endif

			buffer[(y * WIDTH) + x] = even;
		}
	}

	/* add degrees of freedom */
	int xx, yy;
	for (xx=0; xx<WIDTH; xx++) {
		for (yy=0; yy<HEIGHT; yy++) {
			if (buffer[(yy * WIDTH) + xx] == 1) {
				buffer[(yy * WIDTH) + xx] = get_dof(xx, yy) + 2;
			}
		}
	}

	//solve_path();
	display();
	free(buffer);

}

void display()
{
	int x, y;
	char chars[4] = {0};
	int val;

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
			val = buffer[(y*WIDTH)+x];
			if (val == 7)
				DEBUG("*");
			else if (x == START_X && y == START_Y)
				DEBUG("S");
			else if (x == FINISH_X && y == FINISH_Y)
				DEBUG("F");
			else if (val == 0 || val == 2)
				DEBUG("#");
			else if (val > 2 && val < 7)
				DEBUG("%d", val - 2);
			else
				DEBUG(" ");
		}
		DEBUG("\n");
	}
}

typedef enum {
	UP = 2,
	DOWN,
	LEFT,
	RIGHT
} direction;

const char *dir_str[5] = {"^", ".", "<", ">"};


void solve_path() {

	char path;
	char x, y;
	char i, dof;
	static char *buf_copy;
	static char recheck_x[1000] = {0};
	static char recheck_y[1000] = {0};
	char recheck_count;

	x = START_X;
	y = START_Y;

	/* copy the buffer */
	buf_copy = calloc(WIDTH * HEIGHT, sizeof(char));
	memcpy(buf_copy, (void *)buffer, WIDTH * HEIGHT);

	do {

		/* look for possible movements */
		dof = 0;
		//for (i = 0; i < 4; i++) {
			/* can move up */
			if (y <= 0 && buf_copy[((y-1)*WIDTH)+x] == 1) {
				buffer[((y-1)*WIDTH)+x] = 7;
				dof++;
			}
			/* can move down */
			if (y <= HEIGHT && buf_copy[((y+1)*WIDTH)+x] == 1) {
				buffer[((y+1)*WIDTH)+x] = 7;
				dof++;
			}
			/* can move left */
			if (x >= 0 && buf_copy[(y*WIDTH)+x-1] == 1) {
				buffer[(y*WIDTH)+(x-1)] = 7;
				dof++;
			}
			/* can move right */
			if (x <= WIDTH && buf_copy[(y*WIDTH)+x+1] == 1) {
				buffer[(y*WIDTH)+(x+1)] = 7;
				dof++;
			}
		//}


		DEBUG("dof: %d\n", dof);
		if (dof > 0) {
			recheck_count++;
			recheck_x[recheck_count] = x;
			recheck_y[recheck_count] = y;
		}

		if (recheck_count == 1000) {
			printf("re-check space exceeded!");
			exit(1);
		}

		break;

	} while (x != FINISH_X && y != FINISH_Y);

}

char get_dof(char x, char y)
{
	char dof;

	dof = 0;
	/* can move up */
	if (y > 1 && buffer[((y-1)*WIDTH)+x] == 1) {
		dof++;
	}
	/* can move down */
	if (y < HEIGHT && buffer[((y+1)*WIDTH)+x] == 1) {
		dof++;
	}
	/* can move left */
	if (x > 0 && buffer[(y*WIDTH)+x-1] == 1) {
		dof++;
	}
	/* can move right */
	if (x < WIDTH && buffer[(y*WIDTH)+x+1] == 1) {
		dof++;
	}
	return dof;
}
