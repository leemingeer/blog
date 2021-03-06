title: 对技术的一点点看法
date: 2013-02-08 16:00:00
tags:
- 个人总结
categories: 个人总结
toc: false
---

那个C++写的网络数据包捕获分析的程序终于告一段落了。因为学校明年的教学安排有Java程序设计，再加上去年C++的教学方式让我到现在还心有余悸，所以我觉得还是提前翻翻Java的基础知识比较好，免得到时候再一次被动。

C++虽然只是学了一点点皮毛，但是OOP的基础概念之类的东西还是知道一些的。我在看Java基础的同时依旧在复习C++。这两种语言实现OOP的方式不尽相同，这样一边比较着一边辩证学习倒也颇有乐趣。

相较于Java，窃以为C++确实在对OOP的支持上确实略有逊色。我还是坚持自己以前的看法，即C++是大杂烩式的语言，以至于很难把C++归到哪一类。至于C++和OOP的关系，窃以为只能说是C++提供了一些特性，这些特性在一定程度上支持面向对象编程罢了，而不能说C++是一门OOP语言。C++的确是一门没有完全成熟的语言，很多所谓熟悉C++的人不过是在用C++的语法在写C语言程序罢了。就像Linus说的那样，“C++是一门糟糕的(horrible)语言。而且因为有大量不够标准的程序员在使用而使情况更糟，以至于极容易产生彻头彻尾的垃圾(total and utter crap)”。

我这么说并不是我不喜欢C++而找茬，相反，我个人很喜欢C++，但是我不掩盖C++的确存在的不足。**我向来不认同说某种语言比某种语言好的论述，因为这要分情况来研究。假如语言是工具，我们总不能说榔头总是胜过锯子吧？这得分情况讨论，不是吗？**

好了，不谈这些会挨喷的话题了，毕竟对技术的看法都是个在人学习和理解的基础上产生的，不同的环境和不同的学习历程就会有不一样的看法。我们不可能强求别人认可自己的观点，也没有必要非得去争个脸红脖子粗，没意义的，看法也不过就是看法么。

上面的话各位看官批判着去看就好了，貌似我从很早就学会了审视的去看别人的文章，有时也刻意的去“找找茬”。不过我们真应该学会批判着去看待技术类文章，和作者意见相同或者相左没有什么大不了的，学会自己思考才是最关键的。我喜欢那种独立思考之后再和别人的思维碰撞的感觉，方法上孰优孰劣倒是退居其次，重要的是通过这种方式，自己能学到新的思路和方法。

毕竟年关将近，只有零散的时间去研究技术。我们就不谈具体的技术细节了，来说说我最近做项目的一些感慨吧。再次声明，我毕竟在这一行阅历有限，谈到的不过是自己这两年学习的感触和一些方法的总结。**这些方法不见得适用于任何人，也不见得每个人都能认同我的看法。不过即使意见相左，您也没必要非得和我争个青红皂白不可，您批判着看就可以，哪怕是全盘否定都行，我向来也不愿意在这些问题上浪费时间。**

<!-- more -->

首先，我从来不认同“天赋”这两个字，事实上大多数人的智商都在一个水平线上。窃以为所谓的“天赋”不过是对于某一个相关学科长时间的浸淫从而产生的这一学科相关的思维惯性和更加牢固的掌握了这一学科相关的方法论罢了。不能因为我们看不到别人背后的努力，就把别人的成功简单的归咎于“天赋”。这是严重错误的。这是对自己的欺骗和不负责任。如果我们就这样欺骗着自己，作为自己不努力的一种借口，以此让自己心安理得。那么我们永远浮于表面，永远这么循环着。**我现在是很弱，可是哪怕我现在还只是菜菜中的垃圾，那我也得先成为垃圾中的战斗机再说。**

接下来说点实际的东西吧，对于计算机科学相关专业学习的安排问题。我很庆幸自己当时死咬着C语言不放。那段时间无论什么东西我都尝试着用C语言去实现，自己去尝试学习静态库、动态库、编译过程、链接以及可执行程序装载的问题，还有C语言的一些有意思的细节。另外还有Windows下的GUI编程（Native API）、Windows/Linux的系统编程和网络编程、最原始的MySQL数据库编程接口、数据结构和算法的一些实现等等。虽然没有上升到去读ISO的C标准那样的程度，但是自己尝试探索的细节问题给自己带来的益处现在越来越明显了。因为对C语言很熟悉了，所以我可以专注于所面对的问题本身，而不是纠结于这里一个函数指针错误，那里一个链接符号冲突之类的低层次问题。所以我的个人看法就是，**如果你当前研究的问题总是被语法层面的问题所束缚，那么请先学好语言本身吧。**倒是不至于像我这样研究C语言相关语句翻译出来的汇编语言大概的模样，但是至少不能让语法问题成为学习其他内容的拦路虎吧。

最先接触C语言的同学恐怕整天都是接触数学运算之类的实现吧？甚至不少同学以为C语言就是用来算算数学题的。别抱怨，这样做的目的就是尽快掌握语法之类的东西，至于二级指针、函数指针、volatile、inline这些东西到底有什么意义。这要我们自己去研究，而不是去指望学校的教学安排。**学校永远不会教给我们什么是代码格式，什么是版本控制，什么是代码重构，什么是单元测试。**我不想在这里吐槽中国的大学教育，不过国外的资料确实值得我们借鉴。倘若真不知道该自己学点什么，去看看斯坦福和哈佛计算机本科的课表吧。顺便推荐下网易公开课的相关内容，很不错。

C语言基础差不多的时候，我们开设了C++的课程。当时因为一些小程序需要GUI界面，所以图形库的选择就是摆在面前的问题。那本厚厚的《计算机图形学》抛开不论，我们考虑到现实需求，还是先选择成熟的架构比较好。有不少人选择了MFC，其实说实话，MFC是在已有的Native API的基础上进行封装的，这就等于已经存在了成员函数而要去设计类了。所以MFC能做到现在的这个程度已经不容易了，可以说是很不错了。虽然微软近年来对.NET逐渐加大支持而慢慢放弃了对MFC的关注，但是MFC之前的封装的架构依旧值得学习。

说了这么多不是为了挺MFC，因为我个人觉得有更好的选择，比如Qt，说来惭愧，我也是最近因为事实上的项目需求才开始看Qt。以前接触过一点点MFC的东西，相比之下Qt的实现我感觉更加的高明和清晰可读，考虑到企业的实际选择，我觉得Qt还是适合学学的。最近Qt官方动作不断，发行了Qt 5.0之后也宣布Qt即将登录Android和IOS平台。记得有人这么评价Qt，“一个不甘心只做图形库的图形库”，至于以后Qt走向何方，难说。倘若非MFC不可的话，我个人建议还是先去学学Windows API，那本经典的《Windows程序设计（第五版）》是永恒的经典。别嫌弃C语言写GUI程序的啰嗦和乏味，看完这本书，你会明白MFC里面那些莫名其妙出现的消息到底是怎么来的，窗口类究竟是怎么创建一个窗口的。这比一开始就模模糊糊的学习MFC好太多了。

其实很多东西都是相通的，面对这么多相关的技术让我们常常感觉无所适从。其实先踏踏实实的学完其中一样，相关的内容是很容易理解和掌握的。这话也许你都听腻了是吧，那我们举个例子，一个我最近项目中发现的。通俗地讲，我们现在往一个窗口上贴一张图片，我们先来看看Windows API函数Bitblt的使用方法：

```c
BOOL BitBlt (HDC hdcDest,  int nXDest, int nYDest, int nWidth, int nHeight,
HDC hdcSrc, int nXSrc, int nYSrc, DWORD dwRop);
```

姑且不管这些参数的意思，我们再看看Java中Graphics类的成员函数drawImage的一个重载版本的参数：

```c
DrawImage(Image, Int32, Int32, Int32, Int32, Int32, Int32,GraphicsUnit)：
```

先不管句柄指针之类的参数，这些int参数的含义是一样的。如果你懂得原理，会使用其中任意一个，那么其他的看看参数就会使用了。

如果你觉得这只是个例，那么我告诉你Qt里QPainter类的成员函数drawPixmap，也是差不多的。MFC因为就是封装的BitBlt所以无需再说。

这个例子我只是想说明很多东西都是相通的，踏踏实实的学习一种，掌握牢固便是王道。而不要过多的蜻蜓点水般的涉猎，这么做没有好处的。**不要追求那些新生的技术名词，基础的东西在未来几十年依旧有生存空间，新生的技术必然在基础上有所承载，不可能凭空出现。**反观现在，很多技术在目前就是炒作，比如我觉得很多所谓的云存储就是网盘改个名字罢了；而我们学校所谓的云计算平台无非就是一堆虚拟机加上一个虚拟机软件，再通过Windows原生的远程协助工具对外开放，服务端做个端口映射罢了。当然我这么说不是不提倡那些技术（我没那个资格，另外我说的不是深层次，而是目前实际商用的实现版本），而是说对于本科阶段来说，那些东西懂一些确实是添彩，但是在基础没有掌握牢靠的前提下，别太过浮于表面了。说的俗一点，当你向面试官夸夸其谈自己研究的深奥东西的时候，你却连面试官提出的诸如“进程间通信有哪些方法，能给出几个实现吗？”，“归并排序能给个实现吗？”这样的简单问题都为难的话就说不过去了。我想你应该懂我的意思了。

好了，最近时间有限，就到这里了。这种文章我也不会再写的，一来争议肯定很大，二来我还是喜欢自己研究技术细节，而不是在方法论和技术喜好上多加评判。每个人总有自己的喜好和对技术的看法，强迫别人接受自己的看法或者被一些人强迫改变看法在我看来是一件很无聊的事情。总之罗哩罗嗦的说了很多废话，有您爱听的，也有您不喜欢的，全都是我个人的看法，您批判着看吧。另祝新年快乐！