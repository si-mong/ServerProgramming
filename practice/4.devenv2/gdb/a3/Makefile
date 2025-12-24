CFLAGS = -Wall -O -g -Iinclude

bin = a3
t1 = a3
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

clean:
	rm -f $(bin) $(obj)

