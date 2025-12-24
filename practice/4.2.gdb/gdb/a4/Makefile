CFLAGS = -Wall -g -Iinclude

bin = a4
t1 = a4
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

clean:
	rm -f $(bin) $(obj)

