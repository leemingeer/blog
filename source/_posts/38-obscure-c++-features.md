## 你可能不知道的C++特性(译文)

原文地址：http://madebyevan.com/obscure-cpp-features/

这篇文章收集了一些令人费解的C++特性，来自我这些年对这门语言不同角落的探索。C++是一门庞大的语言，让我总是能学到新的东西。希望你能从这篇文章学到一些新的东西，即使你的C++已经掌握的很好:)。下面的特性将按照理解的难易程度进行排列。

### 方括号的真实含义

通过`ptr[3]`这样的形式访问一个数组实际上就是在访问`*(ptr + 3)`。这个表达式相当于`*(3 + ptr)`，因此也可以写作`3[ptr]`，这是完全有效的代码。

### Most vexing parse

"Most vexing parse"是Scott Meyers所发明的术语，用来描述具有二义性的C++声明语法所导致的违反直觉的行为：

```c++
// 像这样的：
// 1) 定义一个std::string类型的变量foo并使用std::string()初始化?
// 2) 声明了一个返回std::string类型并拥有一个参数的函数，
//    这个参数是一个函数指针，指向一个没有参数并返回std::string类型的函数？
std::string foo(std::string());

// 像这样的:
// 1) 定义一个int类型的变量并使用int(x)初始化?
// 2) 声明了一个返回int类型并拥有一个参数的函数，
//    这个参数是一个名为x的int类型？
int bar(int(x));
```
C++标准规定按照上述两种解释中的第二种处理，即使第一种解释看起来更直观一些。程序员可以通过将变量的初始值包含在圆括号中的方式来消除歧义：

```c++
// 括号解决歧义
std::string foo((std::string()));
int bar((int(x)));
```
第二个歧义的原因是`int y = 3;`等价于`int(y) = 3;`.

### 可替代的标记符

标记符`and, and_eq, bitand, bitor, compl, not, not_eq, or, or_eq, xor, xor_eq, <%, %>, <:, :>`可以取代符号`&&, &=, &, |, ~, !, !=, ||, |=, ^, ^=, {, }, [, ].`，当你键盘上缺少必要的操作符时可以用来替代。

### 重定义关键字

### Placement new

### Branch on variable declaration

### Ref-qualifiers on member functions

### Turing complete template MetaProgramming

### Pointer-to-member operators

### Static methods on instances

### Overloading ++ and --

### Operator overloading and evaluation order

### Functions as template parameters

### Template template parameters

### Function try blocks
