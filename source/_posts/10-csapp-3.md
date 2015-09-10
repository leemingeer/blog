title: 《深入理解计算机系统》读书笔记 & 要点总结<下>
date: 2013-01-17 10:02:00
tags:
- CSAPP
- 基础知识
categories: 基础知识
toc: false
---

### §第六章 存储器层次结构

1. 在简单模型中，存储器系统是一个线性的字节数组，而CPU能够在一个常数时间内访问每个存储器位置。实际上，存储器系统（memory system）是一个具有不同容量、成本和访问时间的存储器层次结构。CPU寄存器保存着最常用的数据。靠近CPU的小的、快速的高速缓冲存储器（cache memory）作为一部分存储在相对慢速的主存储器（main memory）中的数据和指令的缓冲区域。主存暂时存放存储在容量较大、慢速磁盘上的数据，而这些磁盘又常常作为存储在通过网络连接的其它机器的磁盘上的数据的缓冲地带。

2. 如果程序所需的数据存储在CPU寄存器中，那么在指令的执行期间，在0个周期内就能访问到它们。如果在高速缓冲存储器内，需要1~30个周期。如果存储在主存中，需要50~200个周期。而如果在磁盘上，则需要大约几千万个周期。

3.存储器层次结构围绕着计算机程序的一个称为局部性（locality）的基本属性。具有良好局部性的程序倾向于一次又一次的访问相同的数据项集合，或是倾向于访问邻近的数据项集合。局部性通常有两种不同的形式：时间局部性（temporal locality）和空间局部性（spatial locality）。

4. 由于历史原因，虽然ROM中有的类型既可以读又可以写，但是整体上还是叫做只读存取器（Read-Only Memory，ROM），存储在ROM中的 程序常常被称为固件（firmware）。

5. 理解存储器层次结构本质的程序员能够利用这些知识编写出更有效的程序，无论具体的存储器系统是怎样实现的。特别地，我们推荐以下技术：1）将注意力集中在内循环上，大部分计算和存储器访问都发生在这里。2）通过按照数据对象存储在存储器中的顺序、以步长为1来读取数据，从而使程序的空间局部性最大。3）一旦程序中读入了一个数据对象，就尽可能多的使用它，从而使程序中的时间局部性最大。

<!-- more -->

### §第七章 链接

引言：现代操作系统与硬件合作，为每个程序提供一种幻象，好像这个程序是在独占的使用处理器和主存，而实际上，在任何时刻，系统上都有多个程序在运行。

1. 链接（linking）是将各种代码和数据部分收集起来并组合成一个单一文件的过程（感觉该句描述欠妥，应该是针对目标文件而非代码文件），这个文件可以被加载（或被拷贝）到存储器执行。链接可以执行于编译时（compile time），也就是在源代码被翻译为机器代码时；也可以运行于加载时（load time），也就是程序被加载器（loader）加载到存储器并执行时；甚至执行与运行时（run time），由应用程序执行。

2. 链接器对目标机器知之甚少，产生目标文件的编译器和汇编器已经完成了大部分工作了。

3. 当编译器遇到一个不是在当前模块中被定义的符号（变量或函数名）时，它就会假设该符号是在其它某个模块中被定义的，生成一个链接器符号表条目，并把它交给链接器处理。如果链接器在它的任何输入模块中都找不到这个被引用的符号，它就输出一条错误信息并终止。

4. 所有的编译系统都提供一种机制，将所有相关的目标模块打包成一个单独的文件，称为静态库（static library），它可以用做链接器的输入。

5. 共享库（shared library）是致力于解决静态库缺陷的一个现代创新产物。共享库是一个目标模块，在运行时，可以加载到任意的 存储器地址，并和一个在存储器中的程序链接起来。这个过程称为动态链接（dynamic linking），是由一个叫做动态链接器（dynamic linker）的程序执行的。

6. 每个Unix程序都有一个运行时存储器映像，在32位Linux系统中，代码段总是从地址0x08048000处开始。数据段是在接下来的一个4KB对齐的地址处。运行时堆在读/写段之后接下来的第一个4KB对齐的地址处，并通过调用malloc库向上增长。用户栈总是从最大的合法用户地址开始，向下增长的（向低存储器地址方向增长）。从栈的上部开始的段是为操作系统驻留存储器部分（也就是内核）的代码和数据保留的。

### §第八章 异常控制流

1. 现代操作系统通过使控制流发生突变对系统状态的变化做出响应。一般而言，我们把这些突变称为异常控制流（Exceptional Control Flow，ECF）。异常控制流发生在计算机系统的各个层次。比如，在硬件层，硬件检测到的事件会触发控制突然转移到异常处理程序。在操作系统层，内核通过上下文转换将控制从一个用户进程转移到另一个用户进程。在应用层，一个进程可以发送信号到另一个进程，而接收者会将控制突然转移到它的一个信号处理程序。一个程序可以通过回避通常的栈规则，并执行到其他函数中任意位置的非本地跳转来对错误做出反应。

2. 异常（exception）是异常控制流的一种形式，它一部分是由硬件实现的，一部分是由操作系统实现的。异常就是控制流中的突变，用来响应处理器状态中的某些变化。

3. 在任何情况下，当处理器检测到有事件发生时，它就会通过一张叫做异常表（exception table）的跳转表（即16位下的中断向量表和32位下的中断描述符表），进行一个间接过程调用（异常），到一个专门设计用来处理这类事件的操作系统子程序（异常处理程序（exception handler））。

4. 系统中把每种可能发生的异常都分配了一个唯一的非负整数的异常号（exception number）。异常号是到异常表的索引，异常表的起始地址放在一个叫做异常表基址寄存器（exception table base register）的特殊CPU寄存器里。（x86叫中断描述符表寄存器IDT（Interrupt Descriptor Table））。

5. 异常可以分为四类：中断（interrupt）、陷阱（trap）、故障（fault）和终止（abort）。

6.中断是异步产生的，是来自处理器外部的I/O设备的信号的结果。硬件中断不是由任何一条专门的指令造成的，从这个意义上来说它是异步的。硬件中断的异常处理程序通常称为中断处理程序（interrupt handler）。I/O设备，例如网络适配器、磁盘控制器和定时器芯片，通过向处理器芯片上的一个引脚发信号，并将异常号放到系统总线上，以触发中断，这个异常号标识了引起中断的设备。

7. 陷阱是有意的异常，实质性一条指令的结果。就像中断处理程序一样，陷阱处理程序将控制返回到下一条指令。陷阱最重要的用途就是在用户程序和内核之间提供一个像过程一样的接口，叫做系统调用。

8. 故障是由错误引起的，它可能被故障处理程序修正。当故障发生时，处理器将控制转移到故障处理程序。如果处理程序能够修正这个错误情况，它就会将控制返回到引起故障的指令，从而重新执行它。否则，处理程序返回到内核的abort例程，abort例程会终止引起故障的应用程序。

9. 终止是不可恢复的致命错误造成的结果，通常是一些硬件错误，例如DRAM或者SRAM位被损坏时发生的奇偶错误。终止处理程序从不将控制返回给应用程序。

10. 为了使描述更具体，让我们来看看为IA32系统定义的一些异常。有高达256种不同的异常类型。0~31的号码是由Intel架构师定义的异常，因此对任何IA32的系统都是一样的。32~255的号码对应的是操作系统中定义的中断和陷阱。

11. 每个Linux系统调用都有一个唯一的整数号（系统调用号），对应于一个到内核中跳转表的偏移量。历史上系统调用是通过异常128（0x80）提供的。

12. C程序用syscall函数可以直接调用任何系统调用。然而，实际中几乎没有必要这么做。对于大多数系统调用，标准C库提供了一组方便的包装函数。这些包装函数将参数打包到一起，以适当的系统调用号陷入内核，然后将系统调用的返回状态传递给调用程序。

13. 所有的Linux系统调用的参数都是通过寄存器而不是栈来传递数据的。按照惯例，%eax寄存器保存系统调用号，寄存器%ebx、%ecx、%edx、%esi、%edi和%ebp最多包含任意6个参数。栈指针%esp不能使用，因为当进入内核，模式时，内核会覆盖它。

14. 进程是计算机科学中最深刻最成功的概念之一。进程的经典定义就是一个执行中的程序的实例。系统中的每个程序都是运行在某个进程的上下文（context）中的。上下文是由程序正常运行所需的状态组成的。这个状态包括存放在存储器中的程序代码和数据，它的栈、通用目的寄存器的内容、程序计数器、环境变量以及打开的文件描述符的集合。

15. 内核为每个程序维持一个进程上下文。上下文就是内核重新启动一个被抢占的进程所需要的状态。它由一些对象的值组成，这些对象包括通用的目的寄存器、浮点寄存器、程序计数器、用户栈、状态寄存器、内核栈和各种内核数据结构，比如描绘地址空间的页表、包含有关当前进程信息的进程表，以及包含进程已打开文件的信息的文件表。

### §第九章 虚拟存储器

- 本章明年结合保护模式的编程再读。

- 后续系统级编程和网络编程等章节不再总结概念，以实践为第一要务。