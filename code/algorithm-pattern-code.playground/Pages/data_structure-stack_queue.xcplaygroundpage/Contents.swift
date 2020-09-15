//: [Previous](@previous)

import Foundation

//[min-stack](https://leetcode-cn.com/problems/min-stack/)（[答案](https://leetcode-cn.com/problems/min-stack/solution/chu-liao-zheng-chang-zhan-ling-wai-wei-hu-yi-ge-da/)）
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


class Solution {
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
    
    //https://leetcode-cn.com/problems/decode-string/solution/yi-ci-bian-li-by-hu-cheng-he-da-bai-sha/
    func decodeString(_ s: String) -> String {
        var numbers = [Int]()
        var values = [String]()
        var retureValue = ""
        var tempInt = 0
        var tempStr = ""
        for item in s {
            if item.isNumber {
                tempInt = tempInt * 10 + Int(String(item))!
                if(tempStr.count > 0){
                    let valuesCount = values.count
                    let numbersCount = numbers.count
                    if(valuesCount > 0 || numbers.count > 0){
                        if valuesCount   >= numbersCount  {
                            values[valuesCount - 1] = values[valuesCount - 1] + tempStr
                        }else{
                            values.append(tempStr)
                        }
                    }else{
                        retureValue += tempStr
                    }
                    tempStr = ""
                }
            }else if item == "[" {
                numbers.append(tempInt)
                tempInt = 0
            }else if item == "]" {
                let multiple = numbers.popLast()!
                if tempStr.count == 0 || (values.count > 0 && values.count > numbers.count) {
                    tempStr = values.popLast()! + tempStr
                }
                var multipleStr = ""
                for _ in 1...multiple {
                    multipleStr += tempStr
                }
                let valuesCount = values.count
                let numbersCount = numbers.count
                
                if valuesCount > 0 ||  numbersCount > 0 {
                    if valuesCount == numbersCount {
                        values[valuesCount - 1] = values[valuesCount - 1] + multipleStr
                    }else{
                        values.append(multipleStr)
                    }
                } else{
                    retureValue += multipleStr
                }
                tempStr = ""
            }else{
                tempStr += String(item)
            }
        }
        retureValue += tempStr
        return retureValue
    }
    
    //https://leetcode-cn.com/problems/decode-string/solution/zhan-cao-zuo-by-hu-cheng-he-da-bai-sha/
    func decodeString_a(_ s: String) -> String {
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
    
    //https://leetcode-cn.com/problems/decode-string/solution/di-gui-by-hu-cheng-he-da-bai-sha/
    func decodeString_b(_ s: String) -> String {
        var index = 0
        
        func dfs() -> String{
            if index >= s.count {
                return ""
            }
            
            let item = s[s.index(s.startIndex, offsetBy: index)]
            
            if item == "]" {
                return ""
            }
            
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
                index += 2 //过滤[
                let repeatedStr = dfs()
                index += 1 //过滤]
                
                var multipleStr = repeatedStr
                for _ in 1..<num {
                    multipleStr += repeatedStr
                }
                return multipleStr + dfs()
                
            }
            
            index += 1
            return String(item) + dfs()
            
        }
        return dfs()
    }
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    //https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/di-gui-by-hu-cheng-he-da-bai-sha-2/
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let item = root else{
            return []
        }
        var res = [Int]()
        res.append(contentsOf: inorderTraversal(item.left))
        res.append(item.val)
        res.append(contentsOf: inorderTraversal(item.right))
        return res
    }
    
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
    
    //固定高度的暴力求解
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let count = heights.count
        var largest = 0
        for i in 0..<count {
            let currntHeight = heights[i]
            var left = i ,right = i
            while left - 1 >= 0 && heights[left - 1] >= currntHeight {
                left -= 1
            }
            while right + 1 < count  && heights[right + 1] >= currntHeight  {
                right += 1
            }
            largest = max(largest,(right-left+1)*currntHeight)
        }
        return largest
    }
    
    //遍历宽度的暴力求解
    func largestRectangleArea_a(_ heights: [Int]) -> Int {
        let nums = heights.count
        if nums == 0 {
            return 0
        }
        var maxArea = 0
        for i in 0..<nums {
            var minHeight = heights[i]
            for j in i..<nums {
                minHeight = min(minHeight, heights[j])
                maxArea = max(maxArea, (j - i + 1) * minHeight)
            }
        }
        return maxArea
    }
    
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
    
    //单调栈+哨兵
    //https://leetcode-cn.com/problems/largest-rectangle-in-histogram/solution/swift-dan-diao-zhan-shao-bing-bian-li-by-hu-cheng-/
    func largestRectangleArea_c(_ heights: [Int]) -> Int {
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
    
    //https://leetcode-cn.com/problems/01-matrix/solution/swift-yan-du-bian-li-by-hu-cheng-he-da-bai-sha/
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        var queue = [(Int,Int)]()
        var res = matrix
        for (x, row) in matrix.enumerated() {
            for (y, item) in row.enumerated() {
                if item == 0{
                    queue.append((x,y))
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
                    queue.append((x,y))
                }
            }
        }
        return res
    }
    
    //https://leetcode-cn.com/problems/01-matrix/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha/
    func updateMatrix_a(_ matrix: [[Int]]) -> [[Int]] {
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        var res = matrix
        for (x, row) in matrix.enumerated() {
            for (y, item) in row.enumerated() {
                res[x][y] = (item == 0) ? 0 : 10000
            }
        }
        
        for x in 0..<rowCount {
            for y in 0..<columnCount {
                if x - 1 >= 0 {
                    res[x][y] = min(res[x][y],res[x-1][y]+1)
                }
                if y - 1 >= 0 {
                    res[x][y] = min(res[x][y],res[x][y-1]+1)
                }
            }
        }
        
        for x in (0..<rowCount).reversed() {
            for y in (0..<columnCount).reversed() {
                if x + 1 < rowCount {
                    res[x][y] = min(res[x][y],res[x+1][y]+1)
                }
                if y + 1 < columnCount {
                    res[x][y] = min(res[x][y],res[x][y+1]+1)
                }
            }
        }
        
        return res
    }
    
    //https://leetcode-cn.com/problems/as-far-from-land-as-possible/solution/swift-yan-du-you-xian-bian-li-by-hu-cheng-he-da-ba/
    func maxDistance(_ grid: [[Int]]) -> Int {
        var res = grid
        var queue = [(Int,Int)]()
        var maxDistance = 0
        for (x, row) in res.enumerated() {
            for (y, item) in row.enumerated() {
                if item == 1{
                    res[x][y] = 0
                    queue.append((x,y))
                }else{
                    res[x][y] = -1
                }
            }
        }
        
        let rowCount = res.count
        let columnCount = res[0].count
        while !queue.isEmpty {
            let point: (x: Int,y: Int) = queue.removeFirst()
            for item: (x: Int,y: Int)  in [(0,-1),(0,1),(-1,0),(1,0)] {
                let x = point.x + item.x
                let y = point.y + item.y
                if x >= 0 && x < rowCount && y >= 0 && y < columnCount && res[x][y] == -1 {
                    let distance = res[point.x][point.y] + 1
                    res[x][y] = distance
                    maxDistance = max(distance,maxDistance)
                    queue.append((x,y))
                }
            }
        }
        
        return (maxDistance == 0) ? -1 : maxDistance
    }
    
    //https://leetcode-cn.com/problems/as-far-from-land-as-possible/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha-2/
    func maxDistance_a(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var maxDistance = 0
        var res = grid
        for (x, row) in res.enumerated() {
            for (y, item) in row.enumerated() {
                res[x][y] = (item == 1) ? 0 : 10000
            }
        }
        
        for x in 0..<rowCount {
            for y in 0..<columnCount {
                if x - 1 >= 0 {
                    res[x][y] = min(res[x][y],res[x-1][y]+1)
                }
                if y - 1 >= 0 {
                    res[x][y] = min(res[x][y],res[x][y-1]+1)
                }
            }
        }
        
        for x in (0..<rowCount).reversed() {
            for y in (0..<columnCount).reversed() {
                if x + 1 < rowCount {
                    res[x][y] = min(res[x][y],res[x+1][y]+1)
                }
                if y + 1 < columnCount {
                    res[x][y] = min(res[x][y],res[x][y+1]+1)
                }
            }
        }
        
        for (_, row) in res.enumerated() {
            for (_, item) in row.enumerated() {
                maxDistance = max(item,maxDistance)
            }
        }
        return (maxDistance == 10000 || maxDistance == 0) ? -1 : maxDistance //只有岛屿或海洋特殊判断
    }
    
    //https://leetcode-cn.com/problems/minimum-height-trees/solution/swift-yan-du-you-xian-bian-li-by-hu-cheng-he-da--2/
    func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        var degree = Dictionary<Int, Int>()
        var map = Dictionary<Int, [Int]>()
        for edge in edges {
            degree[edge[0], default: 0] += 1
            degree[edge[1], default: 0] += 1
            map[edge[0], default: [Int]()].append(edge[1])
            map[edge[1], default: [Int]()].append(edge[0])
        }
        
        var queue = [Int]()
        for i in 0..<n {
            if degree[i] == 1 {
                queue.append(i)
            }
        }
        
        var  res = [Int]()
        while !queue.isEmpty {
            res = [Int]()
            let count = queue.count
            for _ in 0..<count {
                let out = queue.removeFirst()
                res.append(out)
                for item in (map[out])! {
                    degree[item]! -= 1
                    if degree[item] == 1 {
                        queue.append(item)
                    }
                }
            }
        }
        return (res == [] ) ? [0] : res
    }
}

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

//swift数组高级api实现
//https://leetcode-cn.com/problems/implement-queue-using-stacks/solution/swiftshu-zu-gao-ji-apishi-xian-by-hu-cheng-he-da-b/
class MyQueue_a {
    var data: [Int]
    
    /** Initialize your data structure here. */
    init() {
        data = [Int]()
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        data.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return data.removeFirst()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        return data.first!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return data.isEmpty
    }
}

let solution = Solution()
print(solution.decodeString("3[a]2[bc]"))
print(solution.decodeString("3[a]2[b4[F]c]"))
print(solution.decodeString("3[z]2[2[y]pq4[2[jk]e1[f]]]ef"))
print(solution.decodeString("2[2[2[b]]]"))
print(solution.decodeString("2[l3[e4[c5[t]]]]"))

print(solution.decodeString_a("3[a]2[b4[F]c]"))
print(solution.decodeString_a("3[z]2[2[y]pq4[2[jk]e1[f]]]ef"))
print(solution.decodeString_a("2[2[2[b]]]"))
print(solution.decodeString_a("2[l3[e4[c5[t]]]]"))

print(solution.decodeString_b("3[a]2[b4[F]c]"))
print(solution.decodeString_b("3[z]2[2[y]pq4[2[jk]e1[f]]]ef"))
print(solution.decodeString_b("2[2[2[b]]]"))
print(solution.decodeString_b("2[l3[e4[c5[t]]]]"))

print(solution.largestRectangleArea([2,1,5,6,2,3]))
print(solution.largestRectangleArea_a([2,1,5,6,2,3]))
print(solution.largestRectangleArea_b([2,1,5,6,2,3]))
print(solution.largestRectangleArea_c([2,1,5,6,2,3]))

print(solution.largestRectangleArea([0,2,0]))
print(solution.largestRectangleArea_a([0,2,0]))
print(solution.largestRectangleArea_c([0,2,0]))

print(solution.largestRectangleArea([2,1,2]))
print(solution.largestRectangleArea_a([2,1,2]))
print(solution.largestRectangleArea_b([2,1,2]))
print(solution.largestRectangleArea_c([2,1,2]))

print(solution.largestRectangleArea([4,2,0,3,2,5]))
print(solution.largestRectangleArea_a([4,2,0,3,2,5]))
print(solution.largestRectangleArea_b([4,2,0,3,2,5]))
print(solution.largestRectangleArea_c([4,2,0,3,2,5]))

print(solution.updateMatrix([[0,0,0],[0,1,0],[0,0,0]]))
print(solution.updateMatrix([[0,0,0],[0,1,0],[1,1,1]]))

print(solution.updateMatrix_a([[0,0,0],[0,1,0],[0,0,0]]))
print(solution.updateMatrix_a([[0,0,0],[0,1,0],[1,1,1]]))

print(solution.maxDistance([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]))
print(solution.maxDistance([[1,0,1],[0,0,0],[1,0,1]]))

print(solution.maxDistance_a([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]))
print(solution.maxDistance_a([[1,0,1],[0,0,0],[1,0,1]]))

print(solution.findMinHeightTrees(4, [[1,0],[1,2],[1,3]]))
print(solution.findMinHeightTrees(1, []))



//: [Next](@next)
