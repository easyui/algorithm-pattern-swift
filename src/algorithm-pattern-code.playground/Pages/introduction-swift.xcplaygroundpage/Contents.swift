//: [Previous](@previous)

import Foundation

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


let numbers = [12,25,1,35,27]
let numbersSorted = numbers.sorted{ (n1:Int, n2:Int) -> Bool in
    return n2>n1
}
print(numbersSorted)//[1, 12, 25, 27, 35]


class Solution {
    //用的系统api，但是超时了
    func strStr(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else{
            return 0
        }
        
        if let range: Range<String.Index> = haystack.range(of: needle) {
            let index: Int = haystack.distance(from: haystack.startIndex, to: range.lowerBound)
            return index
        }else{
            return -1
        }
    }
    
    //用的官方的解法二，但是超时了
    func strStr_a(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else{
            return 0
        }
        let needleCount = needle.count
        let haystackCount = haystack.count
        
        guard needleCount <= haystackCount else{
            return -1
        }
        let iRange = 0...(haystackCount - needleCount)
        let jRange = 0..<needleCount
        for i in iRange {
            var tempI = i
            for j in jRange {
                let haystackElement = haystack[haystack.index(haystack.startIndex, offsetBy: tempI)]
                let needleElement = needle[needle.index(needle.startIndex, offsetBy: j)]
                if haystackElement == needleElement {
                    tempI += 1
                    if j == needle.count - 1 {
                        return i
                    }
                }else{
                    break
                }
            }
        }
        return -1
    }
    
    //通过:12ms,20.8MB
    //https://leetcode-cn.com/problems/implement-strstr/solution/bian-li-haystackxian-pan-duan-shou-zi-mu-xiang-den/
    func strStr_b(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else{
            return 0
        }
        
        let needleCount = needle.count
        let haystackCount = haystack.count
        
        guard needleCount <= haystackCount else{
            return -1
        }
        
        let iRange = 0...(haystackCount - needleCount)
        let needleStart = needle.first
        
        for i in iRange {
            let startIndex = haystack.index(haystack.startIndex, offsetBy: i)
            let haystackElement = haystack[startIndex]
            
            if haystackElement == needleStart {
                let endIndex = haystack.index(startIndex, offsetBy: needleCount)
                let haystackRange = haystack[startIndex..<endIndex]
                if haystackRange == needle {
                    return i
                }
            }else{
                continue
            }
            
        }
        return -1
    }
    
    //通过:8ms,20.9MB
    //https://leetcode-cn.com/problems/implement-strstr/solution/yi-ci-bian-li-haystackhaystackcount-needlecountcha/
    func strStr_c(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else{
            return 0
        }
        
        let needleCount = needle.count
        let haystackCount = haystack.count
        
        guard needleCount <= haystackCount else{
            return -1
        }
        
        let iRange = 0...(haystackCount - needleCount)
        
        for i in iRange {
            let startIndex = haystack.index(haystack.startIndex, offsetBy: i)
            let endIndex = haystack.index(startIndex, offsetBy: needleCount)
            let haystackRange = haystack[startIndex..<endIndex]
            
            
            if haystackRange == needle {
                return i
            }else{
                continue
            }
        }
        return -1
    }
}

let solution = Solution()
print(solution.strStr("1234567890", "56"))
print(solution.strStr_a("1234567890", "56"))
print(solution.strStr_b("1234567890", "56"))
print(solution.strStr_c("1234567890", "56"))

//: [Next](@next)
