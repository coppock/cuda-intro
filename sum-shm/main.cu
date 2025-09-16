#include <stdio.h>

#include "check.h"
extern "C"
{
#include "io.h"
#include "seq.h"
}

#define N 100 * MEGA
#define BLOCK_SIZE 512

__global__ void sum(float *a, int n)
{
	int i;
	__shared__ float s[BLOCK_SIZE];

	i = blockIdx.x * blockDim.x + threadIdx.x;
	s[threadIdx.x] = a[i];
	__syncthreads();
	for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
	{
		if (threadIdx.x < stride)
			s[threadIdx.x] += s[threadIdx.x + stride];
		__syncthreads();
	}
	if (threadIdx.x == 0)
		a[blockIdx.x] = s[0];
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
	for (k = N; k > 1; k = (k - 1) / BLOCK_SIZE + 1)
	{
		if (k <= 10)
			print(a.h, k);
		sum<<<(k - 1) / BLOCK_SIZE + 1, k / 2 > BLOCK_SIZE ? BLOCK_SIZE : k / 2>>>(a.d, k);
	}
	time_(t);
	CHECK_CUDA(cudaMemcpy(a.h, a.d, N * sizeof(float), cudaMemcpyDeviceToHost));
	print(a.h, 1);
	return 0;
}
