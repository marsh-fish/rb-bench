/*
 * Copyright (c) 2014 Sebastian Huber <sebhub@gmail.com>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "compat.h"
#include "rbtree-linux.h"
#include "test.h"

typedef struct {
  test_data data;
  struct rb_node node;
} test_rb_linux_node;

static void test_rb_linux_init_tree(void *tree)
{
  struct rb_root *r = tree;

  r->rb_node = NULL;
}

static void test_rb_linux_init_node(void *node, int key)
{
  test_rb_linux_node *n = node;

  n->data.key = key;
}

static test_data *test_rb_linux_get_data(void *node)
{
  test_rb_linux_node *n = node;

  return &n->data;
}

static void test_rb_linux_insert(void *tree, void *node)
{
  struct rb_root *root = tree;
  test_rb_linux_node *n = node;
  struct rb_node **next = &root->rb_node;
  struct rb_node *parent = NULL;

  while (*next != NULL) {
    const test_rb_linux_node *c = container_of(*next, test_rb_linux_node, node);

    parent = *next;

    if (n->data.key < c->data.key) {
      next = &(*next)->rb_left;
    } else {
      next = &(*next)->rb_right;
    }
  }

  rb_link_node(&n->node, parent, next);
  rb_linux_insert_color(&n->node, root);
}

static void test_rb_linux_extract(void *tree, void *node)
{
  test_rb_linux_node *n = node;

  rb_linux_erase(&n->node, tree);
}

void test_rbtree_linux(void)
{
  struct rb_root tree;

  test(
    "Linux",
    &tree,
    sizeof(test_rb_linux_node),
    test_rb_linux_init_tree,
    test_rb_linux_init_node,
    test_rb_linux_get_data,
    test_rb_linux_insert,
    test_rb_linux_extract
  );
}
