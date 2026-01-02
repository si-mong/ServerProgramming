CFLAGS = -Wall -O -g -Iinclude

bin = ex1
t1 = ex1
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

$(t1).o: $(t1).c
	$(CC) $(CFLAGS) -c $< -o $@
        
clean:
	rm -f $(bin) $(obj)

