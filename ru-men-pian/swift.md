# swift 语言入门

## 基本语法

[中文版 Apple 官方 Swift 教程《The Swift Programming Language》](https://github.com/SwiftGGTeam/the-swift-programming-language-in-chinese)

## 常用库

### 数组

Swift语言中没有内设的栈和队列， 可通过数组或链表模拟栈和队列（链表的加入和删除的时间复杂度是O\(1\)，但因为Swift没有现成的链表，而数组又有很多的API可以直接使用，所以下面用数组实现）

#### 栈

* 栈是后进先出的结构。你可以理解成有好几个盘子要垒成一叠，哪个盘子最后叠上去，下次使用的时候它就最先被抽出去
* 在iOS开发中，如果你要在你的App中添加撤销操作（比如删除图片，恢复删除图片），那么栈是首选数据结构
* 几个基本操作：push、pop、isEmpty、peek、size

```swift
/// 栈
class Stack<Element> {
    var stack: [Element]
    /// 检查栈空
    var isEmpty: Bool { return stack.isEmpty }
    /// 栈顶元素
    var peek: Element? { return stack.last }
    /// 栈大小
    var size: Int { return stack.count }

    init() {
        stack = [Element]()
    }

    /// push压入
    /// - Parameter object: 元素
    func push(object: Element) {
        stack.append(object)
    }

    /// pop弹出
    /// - Returns: 元素
    func pop() -> Element? {
        return stack.popLast()
    }
}
```

#### 队列

* 队列是先进先出的结构。这个正好就像现实生活中排队买票，谁先来排队，谁先买到票
* iOS开发中多线程的GCD和NSOperationQueue就是基于队列实现的
* 几个基本操作：enqueue、dequeue、isEmpty、peek、size

```swift
/// 队列
class Queue<Element> {
    var left: [Element]
    var right: [Element]
    /// 队列是否为空
    var isEmpty: Bool { return left.isEmpty && right.isEmpty }
    /// 队列长度
    var size: Int { return left.count + right.count }
    /// 队列顶元素
    var peek: Element? { return left.isEmpty ? right.first : left.last }

    init() {
        left = [Element]()
        right = [Element]()
    }

    /// 入队
    /// - Parameter object: 元素
    func enqueue(object: Element) {
        right.append(object)
    }

    /// 出队
    /// - Returns: 元素
    func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }

        return left.popLast()
    }
}
```

### 字典

基本用法

```swift
// 创建
var m = [String: Int]()
// 设置kv
m["hello"] = 1
// 删除k
m["hello"] = nil

if let removedValue = m.removeValue(forKey: "hello") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// 遍历
for (k, v) in m {
    print("\(k): \(v)")
}
```

注意点

* 一个字典的 Key 类型必须遵循 Hashable 协议

### 标准库

#### sort、sorted

区别：

* sort\(\)方法直接改变当前数组。
* sorted\(\)方法返回一个当前数组的 copy 排序后返回。

注意：

* 选择使用哪一个方法，要看具体的使用环境，如果不想改变数组而只是单纯的想获取排序后的结果，则应该使用sorted\(\) 。
* 如果想要改变数组，应当注意如果该数组是函数的参数，Swift 的函数的参数默认是常量类型，想要改变必须加入inout修饰。
* sorted\(\)是值类型拷贝，如果数组太大，会消耗太多内存。

```swift
let numbers = [12,25,1,35,27]
let numbersSorted = numbers.sorted{ (n1:Int, n2:Int) -> Bool in
    return n2>n1
}
print(numbersSorted)//[1, 12, 25, 27, 35]
```

## 刷题注意点

* leetcode 中，全局变量不要当做返回值，否则刷题检查器会报错

