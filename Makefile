CUDA_HOME = /usr/local/cuda

CFLAGS = -I$$PWD
NVCC = $(CUDA_HOME)/bin/nvcc
NVCFLAGS = -ccbin `command -v g++-11` -I..
LDLIBS = -lm

all:
	cd acc-cpu && $(MAKE)
	cd acc && $(MAKE)
	cd sum && $(MAKE)
	cd sum-cpu && $(MAKE)
	cd sum-sync && $(MAKE)
	cd sum-shm && $(MAKE)
