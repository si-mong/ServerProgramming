CFLAGS = -Wall -O -g -Iinclude # 'include'

bin=hello
t1=src/main
t2=src/mathops

obj=${t1}.o ${t2}.o

all: $(bin)
$(bin): $(obj)
	$(CC) $(obj) -o $@

clean:
	rm -f $(bin) *.o
