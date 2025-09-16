#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "io.h"
#include "seq.h"

#define N 10

void accumulate(float *a, float *b, int n)
{
	// TODO: Implement the accumulation on the CPU.
}

int main(void)
{
	float *a, *b;
	struct timespec t;

	a = geometric(M_PI, M_E, N);
	b = arithmetic(M_SQRT2, M_SQRT1_2, N);
#if N <= 10
	print(a, N);
	print(b, N);
#endif
	clock_gettime(CLOCK_MONOTONIC, &t);
	accumulate(a, b, N);
	time_(t);
#if N <= 10
	print(a, N);
#endif
	return 0;
}
