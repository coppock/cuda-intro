#include <math.h>
#include <time.h>

#include "check.h"
extern "C"
{
#include "io.h"
#include "seq.h"
}

#define N 10
#define BLOCK_SIZE 256

__global__ void accumulate(float *a, float *b, int n)
{
	// TODO: Implement the accumulation on the GPU.
}

int main(void)
{
	struct
	{
		float *h, *d;
	} a, b;
	struct timespec t;

	a.h = geometric(M_PI, M_E, N);
	b.h = geometric(M_SQRT2, M_LN2, N);
#if N <= 10
	print(a.h, N);
	print(b.h, N);
#endif
	// TODO: Allocate a.d and b.d on the GPU.
	// TODO: Copy a.h to a.d and b.h to b.d.
	clock_gettime(CLOCK_MONOTONIC, &t);
	// TODO: Launch the kernel.
	// TODO: Synchronize with the device.
	time_(t);
	// TODO: Copy the result back to the host.
#if N <= 10
	print(a.h, N);
#endif
	return 0;
}
