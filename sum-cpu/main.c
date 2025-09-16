#include <math.h>
#include <time.h>

#include "io.h"
#include "seq.h"

#define N 10

float sum(float *a, int n)
{
	float s;
	int i;

	s = 0.0;
	for (i = 0; i < n; i++)
		s += a[i];
	return s;
}

int main(void)
{
	float *a;
	struct timespec t;

	a = geometric(M_PI, M_LN2, N);
	clock_gettime(CLOCK_MONOTONIC, &t);
	a[0] = sum(a, N);
	time_(t);
	print(a, 1);
	return 0;
}
