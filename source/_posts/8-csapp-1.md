title: 《深入理解计算机系统》读书笔记 & 要点总结<上>
date: 2013-01-15 10:02:00
tags:
- CSAPP
- 基础知识
categories: 基础知识
toc: false
---

### §第一章 计算机系统漫游

1. 只由ASCII字符构成的文件称为文本文件，所有其他的文件都称为二进制文件。

2. 区分不同数据对象的唯一方法是我们读到这些数据时候的上下文。

3. 汇编为不同的高级语言的编译器提供了通用的输出语言。

4. 从物理上来说，主存是由一组动态随机存取存储器（DRAM）组成的。从逻辑上来说，存储器是一个线性的字节数组，每个字节都有其唯一的地址（即数组索引），这些地址是从0开始的。

5. 利用直接储存器存取（DMA），数据可以不通过处理器而直接从磁盘到达主存。

6. 对处理器而言，从磁盘驱动器上读取一个字的开销要比从主存中读取的开销大100万倍。

7. 高速缓存的局部性原理：即程序具有访问局部区域里的数据和代码的趋势。

8. 操作系统有两个基本的功能：1）防止硬件被失控的应用程序滥用 2）向应用程序提供简单一致的机制来控制复杂而通常大相径庭的低级硬件设备。操作系统通过几个基本的抽象概念（进程、虚拟存储器和文件）来实现这两个功能。

<!-- more -->

9. 进程是对操作系统正在运行的程序的一种抽象。

10. 操作系统保持跟踪进程运行所需的所有状态信息。这种状态，也就是上下文，包括了许多信息，例如PC和寄存器文件的当前值，以及主存的内容。

11. 实现进程这个抽象的概念需要底层硬件和操作系统软件之间的紧密配合。

12. 术语并发（concurrency）是一个通用的概念，指一个同时具有多个活动的系统；而术语并行（parallelism）指的是用并发使一个系统运行的更快。并行可以在计算机系统的多个抽象层次上运用。我们按照系统层次结构中由高到低的顺序重点强调三个层次：线程级并行，指令级并行和单指令、多数据并行。

13. 文件是对I/O的抽象，虚拟存储器是对程序存储器的抽象，进程是对一个正在运行的程序的抽象。

## 第一部分 程序的结构和执行

### §第二章 信息的表示和处理

1. 二值信号能更容易的被表示存储和运输，对二值信号进行存储和执行计算的电子电路非常简单和可靠，制造商能够在一个单独的硅片上集成数百万甚至数十亿个这样的电路。

2. 无符号（unsigned）编码基于传统的二进制表示法，表示大于0或者等于0的数字；补码（two’ s s-complement）是表示有符号整数的最常见的方式；浮点数（floating-point）编码是表示实数的科学计数法的以二为基数的版本。

3. 整数的表示虽然只能编码一个相对较小的数值范围，但是这种表示是精确的；浮点数虽然可以编码一个较大的数值范围，但这种表示是近似的。由于表示的精度有限，浮点运算是不可结合的。

4. 机器级程序将储存器视为一个非常大的字节数组，称为虚拟存储器（virtual memory）。存储器的每个字节都由一个唯一的数字来标识，称为它的地址（address），所有可能的地址集合称为虚拟地址空间（virtual address space）。顾名思义，这个虚拟地址空间只是一个展现给机器级程序的概念性映像，实际的实现是将随机访问存储器（RAM），磁盘存储器，特殊硬件和操作系统软件结合起来，为程序提供一个看上去统一的字节数组。

5. C编译器把每个指针和类型信息联系起来，这样就可以根据指针值的类型，生成不同的机器级代码来访问存储在指针所指向位置处的值。尽管C编译器维护着这个类型信息，但是它生成的实际机器级程序并不包含关于数据类型的信息。每个程序对象可以简单地视为一个字节块，程序本身就是一个字符序列。

6. 每台计算机都有一个字长（word size），指明整数和指针数据的标称大小（nominal size）。因为虚拟地址是以这样的一个字来编码的，所以字长决定的最重要的系统参数就是虚拟地址空间的最大大小。也就是说，对于一个字长为w的机器而言，虚拟地址的尺寸范围为0~2w-1，程序最多访问2w个字节。

7. 在几乎所有的机器上，多字节对象都被存储为连续的字节序列，对象的地址为所使用字节中的最小地址。

8. 最低有效字节在最前面的方式，称为小端法（little endian）。大多数Intel兼容机都采用这种模式；最高有效字节在最前面的方式，称为大端法（big endian）。大多数IBM和Sun Microsystems的机器采用这种模式。这些规则并没有严格按照企业界限来划分。许多比较新的微处理器采用双端法（bi-endian），可以配制作为小端或者大端运行。

9. 在使用ASCII码作为字符码的任何系统上都将得到相同的结果，与字节顺序和字大小无关。因为，文本数据比二进制数据具有更强的平台独立性。

10. 计算机系统的一个基本概念就是从机器的角度看，程序仅仅是字节序列。机器没有任何关于初始源程序的任何信息，除了可能有些用来帮助调试的辅助表而已。

11. C语言标准并没有明确定义应该使用哪种类型的右移。对于无符号数据（也就是以限定词unsigned声明的整形对象），右移必须是逻辑的。而对于有符号数据，算数的和逻辑的都是可以的。不幸的是，这就意味着任何一种假设或者另一种右移的假设都潜在着可移植问题。然而，实际上，几乎所有的编译器/机器组合都对有符号数采用算术右移，且许多程序员都假设机器会采取这种右移。另一方面，Java对于如何进行右移有着明确的定义。表达式x>>k会将x算术右移k个位置，而x>>>k会对x做逻辑右移。

12. 在许多机器上，当移动一个w位的值时，移位指令只考虑位移量的低log2w位，因此实际上位移量就是通过k mod w来计算的。不过这种行为对于C程序来说是没有保证的，所以移位数量应该保证小于字长。

13. 在C表达式中搞错优先级是很常见的事情，所以当你拿不准的时候，最好加上括号。

14. C和C++都支持有符号数和无符号数，而Java只支持有符号数。

15. C语言标准并没有要求有符号数采用补码的形式存储，但几乎所有的机器都是这么做的。

16. C库中的<limits.h>头文件定义了一组常量，来限定编译器运行的这台机器的不同整型的取值范围。

17. 强制类型转换的结果保持位值不变，只是改变了解释这些位的方式（仅指有符号数和无符号数）。

18. 由于C语言对同时包含有符号数和无符号数的表达式进行计算时，会隐式的将有符号数强制类型转换为无符号数，并假设这两个数都是非负的，并执行这个运算。这种方法对于标准的算术运算来说并无多大差异，但是对于像<和>这样的关系运算符来说，将导致非直观的结果。

19. IA32非同一般的属性是，浮点寄存器使用一种特殊的80位的扩展精度格式。与存储器中保存值所使用的 普通32位单精度和64位双精度格式相比，它提供了更大的表示范围和更高的精度。

20. 目前大多数机器仍使用32位字长。大多数机器对整数使用补码编码，而对浮点数使用IEEE浮点编码。

21. 由于编码的长度有限，与传统整数和实数运算相比，计算机运算具有完全不同的属性。当超出表示范围时，有限长度能够引起数值溢出。当浮点数非常接近于0.0，从而转换成0时，也会下溢。

22. 浮点表示通过将数字编码为x×2y的形式来近似的表示实数。最常见的浮点表示方法是由IEEE标准754定义的。它提供了几种不同的精度，最常见的是单精度（32位）和双精度（64位）。IEEE浮点也能表示特殊值+ ，- ，和NaN。必须十分小心的使用浮点运算，因为浮点运算只有有限的范围和精度，而且不遵守普遍的算术属性，比如结合性。

* 关于IEEE标准754，另行总结。