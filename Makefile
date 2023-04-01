SRC = init
SRC += rbtree-ec
SRC += rbtree-linux
SRC += test-bheap
SRC += test-rbtree-freebsd
SRC += test-rbtree-ec
SRC += test-rbtree-linux
SRC += test-rbtree-llrb
SRC += test-rbtree-jemalloc

OBJS = $(SRC:%=%.o)
deps := $(OBJS:%.o=.%.o.d)

BIN = rb-bench

UNAME=$(shell uname)
CFLAGS = -DPLATFORM=\"$(UNAME)\"

CFLAGS += -O2 -Wall -Wextra

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c -MMD -MF .$@.d $<

test-rbtree-jemalloc.c: rbtree-jemalloc.h
rbtree-jemalloc.h:
	curl -o $@ https://raw.githubusercontent.com/jemalloc/jemalloc/dev/include/jemalloc/internal/rb.h

test-rbtree-freebsd.c: rbtree-freebsd.h
rbtree-freebsd.h:
	curl -o $@ https://raw.githubusercontent.com/freebsd/freebsd-src/main/sys/sys/tree.h

clean:
	rm -f $(BIN) $(OBJS) $(deps)

distclean: clean
	rm -f rbtree-jemalloc.h rbtree-freebsd.h

REPORTS = $(wildcard reports/*.xml)

images: $(REPORTS:%.xml=%.png)

%.png: %.xml
	python plot.py $< $@

-include $(deps)
