#include <stdio.h>
#include <time.h>

void print(float *a, int n)
{
	for (int i = 0; i < n; i++)
		printf("%f%c", a[i], i == n - 1 ? '\n' : ' ');
}

void time_(struct timespec t_i)
{
	struct timespec t_f;

	clock_gettime(CLOCK_MONOTONIC, &t_f);
	if (t_f.tv_nsec < t_i.tv_nsec) {
		--t_f.tv_sec;
		t_f.tv_nsec += 1000000000;
	}
	t_f.tv_sec -= t_i.tv_sec;
	t_f.tv_nsec -= t_i.tv_nsec;
	printf("%ld.%.9ld\n", t_f.tv_sec, t_f.tv_nsec);
}
