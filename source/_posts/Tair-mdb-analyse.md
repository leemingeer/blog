title: Tair mdb 存储引擎的实现
date: 2015-03-28 16:00:00
tags: tair 源码分析
---

[Tair](http://tair.taobao.org/)是一个高性能、分布式、可扩展、高可靠的NoSQL存储系统。本文基于Tair v3.1.2.43版本，探究其mdb存储引擎的实现。

Tair目前有mdb、ldb和rdb等存储引擎。其中mdb是Tair最早的一款内存型产品，也是在公司内部应用最广泛的集中式缓存。特别适用容量小（一般在M级别，50G之内），读写QPS高（万级别）的应用场景。由于是内存型产品，因此无法保证数据的安全性，对数据安全有要求的应用建议在后端加持久化数据源（例如MySQL）。本文接下来详细讨论Tair mdb存储引擎的实现。

Tair的存储引擎接口是src\storage\storage_manager.hpp里的虚基类storage\_manager。所有的Tair存储引擎均继承实现了storage\_manager这个虚基类。src\dataserver\tair\_manager.cpp文件中的tair\_manager::initialize函数根据配置文件中storage\_engine的设置初始化相应的存储引擎。

![dataserver.conf 配置文件中存储引擎的配置](/images/35/1.png)

![src\dataserver\tair\_manager.cpp 代码文件中存储引擎的初始化](/images/35/2.png)

<!-- more -->

mdb引擎默认使用POSIX共享内存的方式进行内存的分配和管理。mdb引擎会在初始化的时候创建或者使用已存在的共享内存。其配置使用内存的方式和共享内存命名的前缀均在其配置文件中进行设置。如图所示：

![dataserver.conf 配置文件中mdb存储引擎存储方式的配置](/images/35/3.png)

src\storage\mdb目录是mdb存储引擎的实现，这里的实现、测试和接口文件都放在同一个目录中。其中有关mdb存储实现的文件如下：

	◇ db\_define.{hpp,cpp} —— mdb引擎相关的配置信息和定义。
	◇ mdb\_factory.{hpp,cpp} —— mdb引擎初始化工厂类的实现。
	◇ mdb\_manager.{hpp,cpp} —— mdb引擎管理结构的实现。
	◇ mdb\_instance.{hpp,cpp} —— mdb实例相关的实现。
	◇ mem\_cache.{hpp,cpp}  —— MemCache结构的实现。
	◇ mem\_pool.{hpp,cpp} —— MemPool结构的实现。
	◇ cache\_hashmap.{hpp,cpp} —— 全局缓存KV结构映射的Hash表的实现。
	◇ mdb\_stat\_manager.{hpp,cpp} —— mdb引擎状态管理相关实现。
	◇ mdb\_stat.hpp —— mdb引擎读取写入统计的相关数据结构的定义和实现。
	◇ lock_guard.hpp —— pthread\_mutex\_t的简单RAII封装。

其中mdb\_define.{hpp,cpp}里定义了mdb引擎的配置变量，打开共享内存的操作函数以及获取时间、判断当前时间的hour是否在给定区间等函数。

mdb\_factory.{hpp,cpp}用于创建mdb引擎，mdb\_factory.hpp中定义的接口如下：

![mdb\_factory.hpp文件中定义的创建mdb存储引擎的接口](/images/35/4.png)

create_mdb_manager读取配置文件中的配置信息，然后创建mdb\_manager对象并返回。这个函数在src\dataserver\tair\_manager.cpp文件中的tair\_manager::initialize函数中被调用。

mdb\_manager.{hpp,cpp}定义了mdb引擎管理类mdb\_manager的实现，mdb\_manager类继承自storage\_manager虚基类，实现了相关的虚函数接口。其定义std::vector<mdb\_instance*>结构保存所有的mdb实例。mdb\_instance类在mdb\_instance.{hpp,cpp}中定义和实现。mdb\_manager类的initialize函数会调用init\_area\_stat函数创建/打开名为mdb\_param::mdb\_path+”.stat”这个存储mdb引擎状态信息的共享内存块，其大小为TAIR\_MAX\_AREA\_COUNT\ * sizeof(mdb\_area\_stat)。然后会根据配置文件里的实例个数信息创建mdb_instance实例。配置如下：

![mdb引擎中实例个数的配置](/images/35/5.png)

mdb\_instance创建时会创建名为mdb\_param::mdb\_path+”.000”开始计数的共享内存块。创建的实例中bucket的个数由以下配置决定：

![mdb引擎中实例bucket个数的配置](/images/35/6.png)

mdb\_instance 、mem\_cache、mem\_pool、cache\_hashmap这几个类构成了mdb存储引擎的核心。创建完成后，其包含指向关系如下：

![mdb引擎中内存管理类的包含指向关系](/images/35/7.png)

对应的内存结构图大致如下：

![mdb引擎中内存管理结构的组织关系](/images/35/8.png)

其中MemPool以页的形式管理通过共享内存分配的内存，分配或者释放一个内存页。其定义了uint8\_t page\_bitmap[BITMAP\_SIZE]，以位的形式来管理内存页；MemCache比页低一级，采用slab算法将内存分配给具体的item；HashTable以一个巨大的Hash表存储key的映射关系。下面阐述对共享内存具体的分配情况。内存布局如图所示：

![mdb引擎共享内存结构的内存布局](/images/35/9.png)

cache meta的结构如下：

![mdb引擎共享内存结构的内存布局meta详细结构](/images/35/10.png)

hash buckets的结构如下：

![mdb引擎共享内存结构的内存布局hash buckets详细结构](/images/35/11.png)

slab use这里，当前的代码实际上仅放置了一个mdb\_cache\_info：

![mdb引擎共享内存结构的内存布局slab use详细结构](/images/35/12.png)

下面是内存管理结构中的一些定义：

mdb\_id的定义：

![mdb\_id结构的定义](/images/35/13.png)

其中item\_id的图示如下：

![item_id结构的定义图示](/images/35/14.png)

一些换算关系如下：
> page\_addr = S0 + (pag\e_id \* page\_size)
> item\_addr = S0 + (page\_id \* page\_size) + sizeof(page\_info) + (slab\_size \* offset\_in\_page)

最后是slab分配器和K/V存储相关的细节。mem\_cache类使用slab\_manager类对从mem\_pool中申请到的内存页进行管理。页信息的结构定义如下：

![mem\_cache中page\_info结构的定义](/images/35/15.png)

mem\_cache里的pages被放置在三个链表中，分别是Free页链表、Full页链表和Partial页链表。Free页链表、Full页链表是简单的双向链表，用于链接空页和满页。Partial页链表如下图：

![mem\_cache中Partial页链表结构](/images/35/16.png)

下图是不同的Area里放置item的图示：

![Area里放置相关的item的图示](/images/35/17.png)

最后剩下的mdb\_stat\_manager.{hpp,cpp}和mdb\_stat.hpp定义和实现了访问统计相关的功能，其创建的共享内存块为相应的mdb实例的名称+“mdbstat”，此处不再赘述。
