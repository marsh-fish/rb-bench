SRC = init
SRC += rbtree-ec
SRC += rbtree-linux
SRC += test-bheap
SRC += test-rbtree-bsd
SRC += test-rbtree-ec
SRC += test-rbtree-linux
SRC += test-rbtree-llrb
SRC += test-rbtree-jemalloc

OBJS = $(SRC:%=%.o)
deps := $(OBJS:%.o=.%.o.d)

BIN = rb-bench

CFLAGS += -O2 -g -Wall -Wextra

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c -MMD -MF .$@.d $<

clean:
	rm -f $(BIN) $(OBJS) $(deps)

REPORTS = $(wildcard reports/*.xml)

images: $(REPORTS:%.xml=%.png)

%.png: %.xml
	python plot.py $< $@

-include $(deps)
