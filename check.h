#ifndef _CHECK_H
#define _CHECK_H

#include <stdio.h>
#include <stdlib.h>

#include <cuda_runtime.h>

#define CHECK_CUDA(expr)                                                                            \
	do                                                                                          \
	{                                                                                           \
		cudaError_t error;                                                                  \
		error = expr;                                                                       \
		if (error != cudaSuccess)                                                           \
		{                                                                                   \
			fprintf(stderr, __FILE__ ":%d: %s: CUDA expression `" #expr "` failed: %s", \
				__LINE__, __func__, cudaGetErrorString(error));                     \
			abort();                                                                    \
		}                                                                                   \
	} while (0)

#endif // !defined(_CHECK_H)
