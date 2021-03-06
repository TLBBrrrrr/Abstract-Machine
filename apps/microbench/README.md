# MicroBench

CPU正确性和性能测试用基准程序。对AbstractMachine的要求：

1. 如果有正确实现的 `_cycles()`和 `_uptime()`，可以输出正确的统计时间。若这两个函数没有实现(返回`0`)，仍可进行正确性测试。
2. 使用`_putc(ch)`输出。
3. 堆区`_heap`必须初始化(堆区可为空)。如果`_heap.start == _heap.end`，即分配了空的堆区，只能运行不使用堆区的测试程序。每个基准程序会预先指定堆区的大小，堆区不足的基准程序将被忽略。

## 已有的基准程序

| 名称    | 描述                      | 堆区使用  | 栈区使用    |
| ----- | ----------------------- | ----- | ------- |
| qsort | 快速排序随机整数数组              | 640KB | O(logn) |
| queen | 位运算实现的n皇后问题             | 0     | O(n)    |
| bf    | Brainf**k解释器，快速排序输入的字符串 | 32KB  | O(1)    |

## 增加一个基准程序`foo`

在`src/`目录下建立名为`foo`的目录，将源代码文件放入。

每个基准程序需要实现三个函数：

* `void bench_foo_prepare();`：进行准备工作，如初始化随机数种子、为数组分配内存等。运行时环境不保证全局变量和堆区的初始值，因此基准程序使用的全局数据必须全部初始化。
* `void bench_foo_run();`：实际运行基准程序。只有这个函数会被计时。
* `const char* bench_foo_validate();`：验证基准程序运行结果。正确返回空指针，否则返回错误信息。

在`benchmark.h`的`BENCHMARK_LIST`中增加相应的`def`项：

* `def(foo, "foo", 堆区用量, 是否开启, 描述字符串)`

## 基准程序可以使用的库函数

* `srand(int seed)`：用seed初始化随机数种子。
* `rand()`：返回一个0..32767之间的随机数。
* `bench_alloc`/`bench_free`：内存分配/回收。目前回收是空操作。

