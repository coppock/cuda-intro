CUDA_HOME = /usr/local/cuda

NVCC = $(CUDA_HOME)/bin/nvcc
NVCFLAGS = -ccbin `command -v g++-11` -I..

main: main.cu ../seq.o ../io.o
	$(NVCC) $(NVCFLAGS) -o main main.cu ../seq.o ../io.o
