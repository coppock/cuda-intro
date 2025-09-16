#include <stdio.h>

#include "check.h"
extern "C"
{
#include "io.h"
#include "seq.h"
}

#define N 100 * MEGA
#define BLOCK_SIZE 256

__global__ void sum(float *a, int n)
{
	int i;

	i = blockIdx.x * blockDim.x + threadIdx.x;
	for (; n > gridDim.x; n = (n + 1) / 2)
	{
		if (i < (n + 1) / 2)
			a[i] += a[i + (n + 1) / 2];
		__syncthreads();
	}
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
	CHECK_CUDA(cudaMalloc(&a.d, N * sizeof(float)));
	CHECK_CUDA(cudaMemcpy(a.d, a.h, N * sizeof(float), cudaMemcpyHostToDevice));
	clock_gettime(CLOCK_MONOTONIC, &t);
	for (k = N; k > 1; k = (k - 1) / BLOCK_SIZE / 2 + 1)
	{
		if (k <= 10)
			print(a.h, k);
		sum<<<(k / 2 - 1) / BLOCK_SIZE + 1, k / 2 > BLOCK_SIZE ? BLOCK_SIZE : k / 2>>>(a.d, k);
	}
	time_(t);
	CHECK_CUDA(cudaMemcpy(a.h, a.d, N * sizeof(float), cudaMemcpyDeviceToHost));
	print(a.h, 1);
	return 0;
}
