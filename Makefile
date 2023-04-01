SRC = init
SRC += rbtree-ec
SRC += rbtree-jffs2
SRC += rbtree-linux
SRC += rbtree-rtems-compact-extract
SRC += rbtree-rtems-compact-insert
SRC += rbtree-rtems-compact-next
SRC += rbtree-rtems-extract
SRC += rbtree-rtems-insert
SRC += rbtree-rtems-next
SRC += test-bheap
SRC += test-rbtree-bsd
SRC += test-rbtree-bsd-for-rtems
SRC += test-rbtree-chain
SRC += test-rbtree-ec
SRC += test-rbtree-jffs2
SRC += test-rbtree-linux
SRC += test-rbtree-llrb
SRC += test-rbtree-rb
SRC += test-rbtree-rb-new
SRC += test-rbtree-rb-old
SRC += test-rbtree-rtems
SRC += test-rbtree-rtems-compact
SRC += test-rbtree-tailq

OBJS = $(SRC:%=%.o)
deps := $(OBJS:%.o=.%.o.d)

BIN = rb-bench

CFLAGS += -O2 -g -Wall -Wextra

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

%.o: %.c
	$(CC) -o $@ $(CFLAGS) -c -MMD -MF .$@.d $<

clean:
	rm -f $(BIN) $(OBJS) $(deps)

REPORTS = $(wildcard reports/*.xml)

images: $(REPORTS:%.xml=%.png)

%.png: %.xml
	python plot.py $< $@

-include $(deps)
