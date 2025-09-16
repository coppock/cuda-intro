#include <stdio.h>

#include "check.h"
extern "C"
{
#include "io.h"
#include "seq.h"
}

#define N 10
#define BLOCK_SIZE 512

__global__ void sum(float *a, int n)
{
	// TODO: Implement the summation on the GPU using shared memory.
}

int main(void)
{
	struct
	{
		float *h, *d;
	} a;
	struct timespec t;
	int k;

	a.h = geometric(M_PI, M_LN2, N);
	// TODO: Allocate a.d on the GPU.
	// TODO: Copy a.h to a.d.
	clock_gettime(CLOCK_MONOTONIC, &t);
	// TODO: Launch the kernel repeatedly until we have the final sum.
	// TODO: Synchronize with the device.
	time_(t);
	// TODO: Copy the result back to the host.
	print(a.h, 1);
	return 0;
}
