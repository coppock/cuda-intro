#include <assert.h>
#include <stdlib.h>

float *geometric(float a_0, float r, int n)
{
	float *a;
	int i;

	a = malloc(n * sizeof(float));
	assert(a != NULL);
	a[0] = a_0;
	for (i = 1; i < n; i++)
		a[i] = a[i - 1] * r;
	return a;
}

float *arithmetic(float b_0, float d, int n)
{
	float *b;
	int i;

	b = malloc(n * sizeof(float));
	assert(b != NULL);
	b[0] = b_0;
	for (i = 1; i < n; i++)
		b[i] = b[i - 1] + d;
	return b;
}
