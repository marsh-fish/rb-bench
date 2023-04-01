# Red-Black Tree Implementation Benchmark

The following implementations are tested

* [BSD](https://github.com/freebsd/freebsd/blob/master/sys/sys/tree.h)
* [Eternally Confuzzled](http://eternallyconfuzzled.com/tuts/datastructures/jsw_tut_rbtree.aspx)
* [Jason Evans - Newer](http://www.canonware.com/download/rb/rb_newer/)
* [Jason Evans - New](http://www.canonware.com/download/rb/rb_new/)
* [Jason Evans - Old](http://www.canonware.com/download/rb/rb_old/)
* [Left-Leaning](http://www.25thandclement.com/~william/projects/llrb.h.html)
* [Linux](https://github.com/torvalds/linux/blob/master/include/linux/rbtree.h)

The test program produces an XML file.  Use the plot.py script to print some
diagrams.

Some sample reports:

![Freescale T4240RDB](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-qoriq_t4240rdb.png)
![Freescale P1020RDB](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-qoriq_p1020rdb.png)
![Altera Cyclone V](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-altcycv_devkit.png)
![Xilinx Zynq](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-xilinx_zynq_zc702.png)
![Aeroflex Gaisler NGMP](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-ngmp.png)
![Freescale MCF5484](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-m5484FireEngine.png)
![Linux](https://raw.githubusercontent.com/sebhub/rb-bench/master/reports/test-linux.png)
