CFLAGS = -Wall -O -g -Iinclude

bin = a2
t1 = a2
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

clean:
	rm -f $(bin) $(obj)

