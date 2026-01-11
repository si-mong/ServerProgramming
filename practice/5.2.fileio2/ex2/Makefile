CFLAGS = -Wall -O -g -Iinclude

bin = a.out
t1 = ex2
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

$(t1).o: $(t1).c
	$(CC) $(CFLAGS) -c $< -o $@
	
clean:
	rm -f $(bin) $(obj)


