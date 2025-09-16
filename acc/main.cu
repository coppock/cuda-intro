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
	int i;

	i = blockIdx.x * blockDim.x + threadIdx.x;
	if (i < N)
		a[i] += b[i];
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
	CHECK_CUDA(cudaMalloc(&a.d, N * sizeof(float)));
	CHECK_CUDA(cudaMalloc(&b.d, N * sizeof(float)));
	CHECK_CUDA(cudaMemcpy(a.d, a.h, N * sizeof(float), cudaMemcpyHostToDevice));
	CHECK_CUDA(cudaMemcpy(b.d, b.h, N * sizeof(float), cudaMemcpyHostToDevice));
	clock_gettime(CLOCK_MONOTONIC, &t);
	accumulate<<<(N + BLOCK_SIZE - 1) / BLOCK_SIZE, BLOCK_SIZE>>>(a.d, b.d, N);
        CHECK_CUDA(cudaDeviceSynchronize());
	time_(t);
	CHECK_CUDA(cudaMemcpy(a.h, a.d, N * sizeof(float), cudaMemcpyDeviceToHost));
#if N <= 10
	print(a.h, N);
#endif
	return 0;
}
