# 栈和队列

## 简介

栈的特点是后入先出

![image.png](https://img.fuiboom.com/img/stack.png)

根据这个特点可以临时保存一些数据，之后用到依次再弹出来，常用于 DFS 深度搜索

队列一般常用于 BFS 广度搜索，类似一层一层的搜索

## Stack 栈

[min-stack](https://leetcode-cn.com/problems/min-stack/)（

> 设计一个支持 push，pop，top 操作，并能在常数时间内检索到最小元素的栈。

思路：用两个栈实现，一个最小栈始终保证最小值在顶部

```swift
//https://leetcode-cn.com/problems/min-stack/solution/chu-liao-zheng-chang-zhan-ling-wai-wei-hu-yi-ge-da/
class MinStack {
    private var stack: [Int]
    private var minStack: [Int]

    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        minStack = [Int]()
    }

    func push(_ x: Int) {
        stack.append(x)
        guard let min = minStack.last ,min < x else{
            minStack.append(x)
            return
        }
    }

    func pop() {
        if let last = stack.popLast(){
            if let min = minStack.last ,min >= last{
                minStack.popLast()
            }
        }
    }

    func top() -> Int {
        return stack.last!
    }

    func getMin() -> Int {
        return minStack.last!
    }
}

let stack = MinStack()
stack.push(-2)
stack.push(0)
stack.push(-3)
stack.getMin()
stack.pop()
stack.top()
stack.getMin()
```

[evaluate-reverse-polish-notation](https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/)

> **波兰表达式计算** > **输入:** ["2", "1", "+", "3", "*"] > **输出:** 9
> **解释:** ((2 + 1) \* 3) = 9

思路：通过栈保存原来的元素，遇到表达式弹出运算，再推入结果，重复这个过程

```swift
//https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/solution/ni-bo-lan-biao-da-shi-hou-zhui-biao-da-shi-de-zhan/
    func evalRPN(_ tokens: [String]) -> Int {
        var values = [Int]()
        for item in tokens {
            switch item {
            case "+":
                if let x = values.popLast(),let y = values.popLast(){
                    values.append(y + x)
                }
            case "-":
                if let x = values.popLast(),let y = values.popLast(){
                    values.append(y - x)
                }
            case "*":
                if let x = values.popLast(),let y = values.popLast(){
                    values.append(y * x)
                }
            case "/":
                if let x = values.popLast(),let y = values.popLast(){
                    values.append(y / x)
                }

            default:
                values.append(Int(item)!)
            }
        }
        return values.popLast()!
    }
```

[decode-string](https://leetcode-cn.com/problems/decode-string/)

> 给定一个经过编码的字符串，返回它解码后的字符串。
> s = "3[a]2[bc]", 返回 "aaabcbc".
> s = "3[a2[c]]", 返回 "accaccacc".
> s = "2[abc]3[cd]ef", 返回 "abcabccdcdcdef".

思路：通过栈辅助进行操作

```swift
    //https://leetcode-cn.com/problems/decode-string/solution/zhan-cao-zuo-by-hu-cheng-he-da-bai-sha/
func decodeString(s string) string {
        var stk = [String]()
        var index = 0

        while index < s.count {
            let item = s[s.index(s.startIndex, offsetBy: index)]
            if item.isNumber {
                var num = Int(String(item))!
                while true{
                    let nextItem = s[s.index(s.startIndex, offsetBy: index + 1)]
                    if nextItem.isNumber {
                        num = num * 10 + Int(String(nextItem))!
                        index += 1
                    }else{
                        break
                    }
                }
                stk.append(String(num))
            }else if item == "]" {
                var repeatedStr = ""
                var lastStr = stk.popLast()!
                while lastStr != "[" {
                    repeatedStr = lastStr +  repeatedStr
                    lastStr = stk.popLast()!
                }
                let multipleNum = Int(stk.popLast()!)!
                var multipleStr = repeatedStr
                for _ in 1..<multipleNum {
                    multipleStr += repeatedStr
                }
                stk.append(multipleStr)
            }else{
                stk.append(String(item))
            }
            index += 1
        }

        return stk.joined()
}
```

[binary-tree-inorder-traversal](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/)

> 给定一个二叉树，返回它的*中序*遍历。

```swift
// 思路：通过stack 保存已经访问的元素，用于原路返回
//https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/zhan-shi-xian-by-hu-cheng-he-da-bai-sha/
    func inorderTraversal_b(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [TreeNode]()
        var current = root
        while current != nil || !stack.isEmpty {
            while current != nil{
                stack.append(current!)
                current = current!.left
            }
            current = stack.popLast()!
            res.append(current!.val)
            current = current!.right
        }
        return res
    }
    
//ps:递归实现 https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/di-gui-by-hu-cheng-he-da-bai-sha-2/
```

[clone-graph](https://leetcode-cn.com/problems/clone-graph/)

> 给你无向连通图中一个节点的引用，请你返回该图的深拷贝（克隆）。

```swift
    //https://leetcode-cn.com/problems/clone-graph/solution/swift-shen-du-you-xian-di-gui-by-hu-cheng-he-da-ba/
    public class Node {
        public var val: Int
        public var neighbors: [Node?]
        public init(_ val: Int) {
            self.val = val
            self.neighbors = []
        }
    }
    
    func cloneGraph(_ node: Node?) -> Node? {
        var visited = [Int : Node?]()
        func dfs(_ node: Node?) -> Node?{
            guard let current = node else{
                return nil
            }
            
            if let visitedItem = visited[current.val]{
                return visitedItem
            }
            
            let clonedNode = Node(current.val)
            visited[clonedNode.val] = clonedNode
            
            for neighbor in current.neighbors {
                clonedNode.neighbors.append(dfs(neighbor))
            }
            
            return clonedNode
        }
        
        return dfs(node)
    }
```

[number-of-islands](https://leetcode-cn.com/problems/number-of-islands/)

> 给定一个由  '1'（陆地）和 '0'（水）组成的的二维网格，计算岛屿的数量。一个岛被水包围，并且它是通过水平方向或垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。

思路：通过深度搜索遍历可能性（注意标记已访问元素）

```swift
    //https://leetcode-cn.com/problems/number-of-islands/solution/swiftshen-du-you-xian-di-gui-by-hu-cheng-he-da-bai/
    func numIslands(_ grid: [[Character]]) -> Int {
        var copydGrid = grid
        let rn = grid.count
        guard rn > 0 else{
            return 0
        }
        let cn = copydGrid[0].count
        
        func dfs(_ r: Int,_ c:Int) {
            guard r >= 0 && r < rn && c >= 0 && c < cn && copydGrid[r][c] == "1" else{
                return
            }
            copydGrid[r][c] = "0"
            dfs(r-1, c)//上
            dfs(r+1, c)//下
            dfs(r, c-1)//左
            dfs(r, c+1)//右
        }
        
        var islandCount = 0
        for r in 0..<rn {
            for c in 0..<cn {
                if copydGrid[r][c] == "1" {
                    islandCount += 1
                    dfs(r,c)
                }
            }
        }
        return islandCount
    }
```

[largest-rectangle-in-histogram](https://leetcode-cn.com/problems/largest-rectangle-in-histogram/)

> 给定 _n_ 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。
> 求在该柱状图中，能够勾勒出来的矩形的最大面积。


```swift
    //单调栈
    //https://leetcode-cn.com/problems/largest-rectangle-in-histogram/solution/swift-dan-diao-zhan-bian-li-by-hu-cheng-he-da-bai-/
    func largestRectangleArea_b(_ heights: [Int]) -> Int {
        let nums = heights.count
        if nums == 0 {
            return 0
        }
        var maxArea = 0
        var stack = [Int]()
        for i in 0..<nums {
            while !stack.isEmpty && heights[stack.last!] > heights[i] {
                let highest = heights[stack.popLast()!]
                //下面这个while处理相等的，其实也可以不处理
                while !stack.isEmpty && heights[stack.last!] == highest {
                    stack.popLast()!
                }
                let width = stack.isEmpty ? i : (i - stack.last! - 1)//栈为空的特殊情况处理
                maxArea = max(maxArea,highest * width)
            }
            stack.append(i)
        }
        
        //遍历完后需要处理栈中剩余元素
        while !stack.isEmpty {
            let highest = heights[stack.popLast()!]
            //下面这个while处理相等的，其实也可以不处理
            while !stack.isEmpty && heights[stack.last!] == highest {
                stack.popLast()!
            }
            let width = stack.isEmpty ? nums : (nums -  stack.last! - 1)//栈为空的特殊情况处理
            maxArea = max(maxArea,highest * width)
        }
        
        return maxArea
    }
```

优化：

```swift
//单调栈+哨兵
    //https://leetcode-cn.com/problems/largest-rectangle-in-histogram/solution/swift-dan-diao-zhan-shao-bing-bian-li-by-hu-cheng-/
    func largestRectangleArea(_ heights: [Int]) -> Int {
        if heights.count == 0 {
            return 0
        }
        
        let heights = [0] + heights + [0]
        let nums = heights.count
 
        var stack = [Int]()
        stack.append(heights[0])

        var maxArea = 0

        for i in 1..<nums {
            while heights[stack.last!] > heights[i] {
                let highest = heights[stack.popLast()!]
                let width = i - stack.last! - 1
                maxArea = max(maxArea,highest * width)
            }
            stack.append(i)
        }

        return maxArea
    }
```

## Queue 队列

常用于 BFS 宽度优先搜索

[implement-queue-using-stacks](https://leetcode-cn.com/problems/implement-queue-using-stacks/)

> 使用栈实现队列

```swift
//swift栈实现
//https://leetcode-cn.com/problems/implement-queue-using-stacks/solution/swift-zhan-shi-xian-by-hu-cheng-he-da-bai-sha/
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

class MyQueue {
    var leftStack: Stack<Int>
    var rightStack: Stack<Int>

    /** Initialize your data structure here. */
    init() {
        leftStack = Stack()
        rightStack = Stack()

    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        rightStack.push(object: x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        self.checkLeftStack()
        return leftStack.pop()!
    }
    
    /** Get the front element. */
    func peek() -> Int {
        self.checkLeftStack()
        return leftStack.peek!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    private func checkLeftStack(){
        if leftStack.isEmpty {
            while !rightStack.isEmpty {
                leftStack.push(object: rightStack.pop()!)
            }
                          
        }
    }
}
```

[01-matrix](https://leetcode-cn.com/problems/01-matrix/)

> 给定一个由 0 和 1 组成的矩阵，找出每个元素到最近的 0 的距离。
> 两个相邻元素间的距离为 1

```swift
//https://leetcode-cn.com/problems/01-matrix/solution/swift-yan-du-bian-li-by-hu-cheng-he-da-bai-sha/

// BFS 从0进队列，弹出之后计算上下左右的结果，将上下左右重新进队列进行二层操作
// 0 0 0 0
// 0 x 0 0
// x x x 0
// 0 x 0 0

// 0 0 0 0
// 0 1 0 0
// 1 x 1 0
// 0 1 0 0

// 0 0 0 0
// 0 1 0 0
// 1 2 1 0
// 0 1 0 0
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        var queue = [(Int,Int)]()
        var res = matrix
        for (x, row) in matrix.enumerated() {
            for (y, item) in row.enumerated() {
                if item == 0{
                    queue.append((x,y))//入队
                }else{
                    res[x][y] = -1
                }
                
            }
        }
        while !queue.isEmpty {
            let point: (x: Int,y: Int) = queue.removeFirst()
            for item: (x: Int,y: Int)  in [(0,-1),(0,1),(-1,0),(1,0)] {
                let x = point.x + item.x
                let y = point.y + item.y
                if x >= 0 && x < rowCount && y >= 0 && y < columnCount && res[x][y] == -1 {
                    res[x][y] = res[point.x][point.y] + 1
                    queue.append((x,y))//入队
                }
            }
        }
        return res
    }

//动态规划解题：https://leetcode-cn.com/problems/01-matrix/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha/
```
相似题目：[1162. 地图分析](https://leetcode-cn.com/problems/as-far-from-land-as-possible/)

## 总结

- 熟悉栈的使用场景
  - 后入先出，保存临时值
  - 利用栈 DFS 深度搜索
- 熟悉队列的使用场景
  - 利用队列 BFS 广度搜索

## 练习

- [ ] [min-stack](https://leetcode-cn.com/problems/min-stack/)
- [ ] [evaluate-reverse-polish-notation](https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/)
- [ ] [decode-string](https://leetcode-cn.com/problems/decode-string/)
- [ ] [binary-tree-inorder-traversal](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/)
- [ ] [clone-graph](https://leetcode-cn.com/problems/clone-graph/)
- [ ] [number-of-islands](https://leetcode-cn.com/problems/number-of-islands/)
- [ ] [largest-rectangle-in-histogram](https://leetcode-cn.com/problems/largest-rectangle-in-histogram/)
- [ ] [implement-queue-using-stacks](https://leetcode-cn.com/problems/implement-queue-using-stacks/)
- [ ] [01-matrix](https://leetcode-cn.com/problems/01-matrix/)
