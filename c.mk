CFLAGS = -I..
LDLIBS = -lm

main: main.c ../seq.o ../io.o
	$(CC) $(CFLAGS) -o main main.c ../seq.o ../io.o $(LDLIBS)
