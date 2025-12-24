CFLAGS = -Wall -g -Iinclude

bin = a5
t1 = a5
obj = $(t1).o

all: $(bin)

$(bin): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@

clean:
	rm -f $(bin) $(obj)

