//: [Previous](@previous)

import Foundation

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

//前序递归
func preorderTraversal(_ root: TreeNode?)  {
    guard let element = root else { return  }
    // 先访问根再访问左右
    print(element.val)
    preorderTraversal(element.left)
    preorderTraversal(element.right)
}

//前序非递归a
func preorderTraversal_a(_ root: TreeNode?) ->[Int] {
    guard  root != nil  else { return []  }
    
    var result = [Int]()
    var stack = [TreeNode]()
    
    
    var cur = root
    while cur != nil || stack.count != 0 {
        while cur != nil {
            // 前序遍历，所以先保存结果
            result.append(cur!.val)
            stack.append(cur!)
            cur = cur!.left
        }
        // pop
        let node = stack.removeLast()
        cur = node.right
    }
    return result
}

//前序非递归b
func preorderTraversal_b(_ root: TreeNode?) ->[Int] {
    guard let element = root  else { return []  }
    
    var result = [Int]()
    var stack = [element]
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        result.append(node.val)
        if let right = node.right{
            stack.append(right)
        }
        if let left = node.left{
            stack.append(left)
        }
    }
    
    return result
}

//中序非递归
//思路：通过stack 保存已经访问的元素，用于原路返回
func inorderTraversal(_ root: TreeNode?) ->[Int] {
    guard root != nil  else { return []  }
    
    var result = [Int]()
    var stack = [TreeNode]()
    
    var cur = root
    while cur != nil || stack.count != 0 {
        while cur != nil {
            stack.append(cur!)
            cur = cur!.left
        }
        
        //        if let node = stack.popLast() {
        let node = stack.removeLast()
        result.append(node.val)
        cur = node.right
        //        }
    }
    
    return result
}

//后序非递归a
func postorderTraversal_a(_ root: TreeNode?) ->[Int] {
    guard  root != nil  else { return []  }
    
    var result = [Int]()
    var stack = [TreeNode]()
    var lastVisit : TreeNode?    // 通过lastVisit标识右子节点是否已经弹出
    
    var cur = root
    while cur != nil || stack.count != 0 {
        while cur != nil {
            stack.append(cur!)
            cur = cur!.left
        }
        
        let top = stack.last!//这里先看看，先不弹出
        if top.right == nil || top.right === lastVisit {//根节点必须在右节点弹出之后，再弹出
            let node = stack.removeLast()
            result.append(node.val)
            lastVisit = node// 标记当前这个节点已经弹出过
        }else{
            cur = top.right
        }
    }
    return result
}

//后序非递归b
func postorderTraversal_b(_ root: TreeNode?) ->[Int] {
    guard let element = root  else { return []  }
    
    var result = [Int]()
    var stack = [element]
    var resultStack = [TreeNode]()
    
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        resultStack.append(node)
        if let left = node.left{
            stack.append(left)
        }
        if let right = node.right{
            stack.append(right)
        }
    }
    
    while !resultStack.isEmpty {
        result.append(resultStack.removeLast().val)
    }
    
    return result
}

//DFS 深度搜索-从上到下

func preorderTraversal_dfs(root: TreeNode?) -> [Int] {
    var result = [Int]()
    dfs(root, &result)
    return result
}

// V1：深度遍历，结果指针作为参数传入到函数内部
func dfs(_ root: TreeNode?,_ result: inout [Int]) {
    guard let node = root else { return  }
    result.append(node.val)
    dfs(node.left, &result)
    dfs(node.right, &result)
}

//DFS 深度搜索-从下向上（分治法）
func preorderTraversal_dfs_a(root: TreeNode?) -> [Int] {
    let result = divideAndConquer(root)
    return result
}
func divideAndConquer(_ root: TreeNode?) -> [Int] {
    guard let node = root else { return [] }
    var result = [Int]()
    
    // 分治(Divide)
    let left = divideAndConquer(node.left)
    let right = divideAndConquer(node.right)
    // 合并结果(Conquer)
    result.append(node.val)
    result.append(contentsOf: left)
    result.append(contentsOf: right)
    return result
}

//https://leetcode-cn.com/problems/binary-tree-level-order-traversal/solution/swift-bfs-by-hu-cheng-he-da-bai-sha/
//执行用时：16 ms, 在所有 Swift 提交中击败了97.20%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了80.00%的用户
//BFS 层次遍历
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard root != nil else { return [] }
    var queue = [root!]
    var res = [[Int]]()
    
    while !queue.isEmpty {
        let count = queue.count // 记录当前层有多少元素（遍历当前层，再添加下一层）
        var level = [Int]() //存放该层所有数值
        for _ in 0..<count {
            let node = queue.removeFirst()// 出队列
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append(level)
    }
    return res
}

/*
 func traversal(_ root: TreeNode?) -> ResultType  {
 // nil or leaf
 if root == nil {
 // do something and return
 }
 
 // Divide
 let left = traversal(root.Left)
 let right = traversal(root.Right)
 
 // Conquer
 let result = Merge from left and right
 
 return result
 }
 */


func MergeSort(_ nums: [Int]) -> [Int] {
    return mergeSort(nums)
}
func mergeSort(_ nums: [Int]) -> [Int] {
    if nums.isEmpty {
        return nums
    }
    // 分治法：divide 分为两段
    let mid = nums.count / 2
    let left = mergeSort(Array(nums[0..<mid]))
    let right = mergeSort(Array(nums[mid..<nums.count]))
    // 合并两段数据
    let result = merge(left, right)
    return result
}
func merge(_ left: [Int],_ right: [Int]) -> [Int] {
    var result = [Int]()
    // 两边数组合并游标
    var l = 0,r = 0
    let lCount = left.count,rCount = right.count
    // 注意不能越界
    while l < lCount && r < rCount {
        // 谁小合并谁
        if left[l] > right[r] {
            result.append(right[r])
            r += 1
        } else {
            result.append(left[l])
            l += 1
        }
    }
    // 剩余部分合并
    if l < lCount {
        result.append(contentsOf: left[l..<lCount])
    }else{
        result.append(contentsOf: right[r..<rCount])
    }
    return result
}


//方法一
func QuickSort(_ nums:inout [Int]) -> [Int] {
    // 思路：把一个数组分为左右两段，左段小于右段，类似分治法没有合并过程
    quickSort(&nums, 0, nums.count - 1)
    return nums
    
}
// 原地交换，所以传入交换索引
func quickSort(_ nums:inout [Int],_ start: Int,_ end: Int) {
    if start < end {
        // 分治法：divide
        let pivot = partition(&nums, start, end)
        quickSort(&nums, 0, pivot-1)
        quickSort(&nums, pivot+1, end)
    }
}
// 分区
func partition(_ nums:inout [Int],_ start: Int,_ end: Int) -> Int {
    let p = nums[end]//参考点。排序：比p小的在左边，比p大的在右边
    var i = start
    
    for j in start..<end {
        if nums[j] < p {
            swap(&nums, i, j)
            i += 1
        }
    }
    
    // 把中间的值换为用于比较的基准值
    swap(&nums, i, end)
    return i
}
func swap(_ nums:inout [Int], _ i: Int,_ j: Int) {
    let t = nums[i]
    nums[i] = nums[j]
    nums[j] = t
}

//方法二
func quickSort_a(data:[Int])->[Int]{
    if data.count<=1 {
        return data
    }
    
    var left:[Int] = []
    var right:[Int] = []
    let pivot:Int = data[data.count-1]
    for index in 0..<data.count-1 {
        if data[index] < pivot {
            left.append(data[index])
        }else{
            right.append(data[index])
        }
    }
    
    var result = quickSort_a(data: left)
    result.append(pivot)
    let rightResult = quickSort_a(data: right)
    result.append(contentsOf: rightResult)
    return result
}


//https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/solution/swift-fen-zhi-fa-by-hu-cheng-he-da-bai-sha/
//分治法
//执行用时：28 ms, 在所有 Swift 提交中击败了99.56%的用户
//内存消耗：21.5 MB, 在所有 Swift 提交中击败了100.00%的用户
func maxDepth(_ root: TreeNode?) -> Int {
    guard let node = root else { return 0 }
    
    let leftNum = maxDepth(node.left)
    let rightNum = maxDepth(node.right)
    
    if leftNum > rightNum{
        return leftNum + 1
    }else{
        return rightNum + 1
    }
}

//https://leetcode-cn.com/problems/balanced-binary-tree/solution/swift-you-hua-ban-zi-di-xiang-shang-de-di-gui-fen-/
//优化版（自底向上的递归）：分治法【递归：左边平衡 && 右边平衡 && 左右两边高度 <= 1】
//执行用时：56 ms, 在所有 Swift 提交中击败了80.74%的用户
//内存消耗：22.3 MB, 在所有 Swift 提交中击败了100.00%的用户
func isBalanced(_ root: TreeNode?) -> Bool {
    guard let node = root else { return true }
    
    if !isBalanced(node.left){
        return false
    }
    if !isBalanced(node.right){
        return false
    }
    
    let leftNum = maxDepth(node.left)
    let rightNum  = maxDepth(node.right)
    
    return (abs(leftNum - rightNum) <= 1)
}

//https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/swift-fen-zhi-fa-you-zuo-zi-shu-de-gong-gong-zu-xi/
//执行用时：92 ms, 在所有 Swift 提交中击败了98.08%的用户
//内存消耗：26.9 MB, 在所有 Swift 提交中击败了33.33%的用户
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    // check
    guard let rootItem = root else { return nil }
    guard let pItem = p else { return q }
    guard let qItem = q else { return p }
    // 相等 直接返回root节点即可
    if rootItem === pItem || rootItem === qItem {
        return rootItem
    }
    // Divide
    let left = lowestCommonAncestor(rootItem.left,p,q)
    let right = lowestCommonAncestor(rootItem.right,p,q)
    // Conquer
    // 左右两边都不为空，则根节点为祖先
    if left != nil && right != nil{
        return root
    }
    
    if left != nil {
        return left
    }
    
    if right != nil {
        return right
    }
    
    return nil
}

//https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/solution/swift-fen-zhi-fa-by-hu-cheng-he-da-bai-sha-2/
//执行用时：116 ms, 在所有 Swift 提交中击败了97.92%的用户
//内存消耗：23.1 MB, 在所有 Swift 提交中击败了100.00%的用户
func maxPathSum(_ root: TreeNode?) -> Int {
    var pathMax = Int.min
    
    // 递归计算左右子节点的最大贡献值
    func dfs(_ root: TreeNode?) -> Int{
        // check
        guard let element = root else { return 0 }
        
        // Divide
        let leftMax = dfs(element.left)
        let rightMax =  dfs(element.right)
        
        // Conquer
        // 节点的最大路径和取决于该节点的值与该节点的左右子节点的最大贡献值
        pathMax = max(pathMax,leftMax + rightMax + element.val)
        
        //只有在最大贡献值大于 0 时，才会选取对应子节点
        return max(max(leftMax , rightMax) + element.val,0)
    }
    
    dfs(root)
    return pathMax
}

//https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/solution/swift-bfshou-fan-zhuan-by-hu-cheng-he-da-bai-sha/
//BFS后翻转
//执行用时：16 ms, 在所有 Swift 提交中击败了96.95%的用户
//内存消耗：21.2 MB, 在所有 Swift 提交中击败了50.00%的用户
func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard root != nil else { return [] }
        var queue = [root!]
        var res = [[Int]]()
        
        while !queue.isEmpty {
            let count = queue.count // 记录当前层有多少元素（遍历当前层，再添加下一层）
            var level = [Int]() //存放该层所有数值
            for _ in 0..<count {
                let node = queue.removeFirst()// 出队列
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(level)
        }
        return res
    }
    var result = levelOrder(root)
    result.reverse()
    return result
}

//https://leetcode-cn.com/problems/binary-tree-zigzag-level-order-traversal/solution/swift-bfsqi-shu-ceng-fan-zhuan-by-hu-cheng-he-da-b/
//奇数层翻转
//执行用时：12 ms, 在所有 Swift 提交中击败了93.41%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了100.00%的用户
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
    guard root != nil else { return [] }
    var queue = [root!]
    var levelIndex = 0
    var res = [[Int]]()
    
    while !queue.isEmpty {
        let count = queue.count // 记录当前层有多少元素（遍历当前层，再添加下一层）
        var level = [Int]() //存放该层所有数值
        for _ in 0..<count {
            let node = queue.removeFirst()// 出队列
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append((levelIndex & 1 == 0) ? level : level.reversed())
        levelIndex += 1
    }
    return res
}

//https://leetcode-cn.com/problems/validate-binary-search-tree/solution/swift-zhong-xu-bian-li-fei-di-gui-bian-li-guo-chen/
//中序遍历非递归，遍历过程发现值小于等于前一个值就直接return false
//执行用时：60 ms, 在所有 Swift 提交中击败了62.50%的用户
//内存消耗：21.5 MB, 在所有 Swift 提交中击败了90.00%的用户
func isValidBST(_ root: TreeNode?) -> Bool {
    guard root != nil  else { return true  }
    
    var lastVisited : Int?
    var stack = [TreeNode]()
    
    var cur = root
    while cur != nil || stack.count != 0 {
        while cur != nil {
            stack.append(cur!)
            cur = cur!.left
        }
        
        let node = stack.removeLast()
        if let last = lastVisited, node.val <= last {
            return false
        }else{
            lastVisited = node.val
        }
        cur = node.right
    }
    
    return true
}

//https://leetcode-cn.com/problems/validate-binary-search-tree/solution/swift-zhong-xu-bian-li-di-gui-bian-li-guo-cheng-fa/
//中序遍历递归，遍历过程发现值小于等于前一个值就直接return false
//执行用时：52 ms, 在所有 Swift 提交中击败了97.75%的用户
//内存消耗：21.8 MB, 在所有 Swift 提交中击败了25.00%的用户
func isValidBST_a(_ root: TreeNode?) -> Bool {
    var lastVisited = Int.min
    
    func helper(_ root: TreeNode?)-> Bool{
        guard let element = root else { return true }
        
        if !helper(element.left) {
            return false
        }
        
        if element.val <= lastVisited {
            return false
        }
        
        lastVisited = element.val
        
        return helper(element.right)
    }
    
    return helper(root)
}

//https://leetcode-cn.com/problems/validate-binary-search-tree/solution/swift-di-gui-bi-jiao-tong-shi-geng-xin-zuo-you-zi-/
//递归比较，同时更新左右子树的最大最小界
//执行用时：48 ms, 在所有 Swift 提交中击败了99.75%的用户
//内存消耗：21.6 MB, 在所有 Swift 提交中击败了60.00%的用户
func isValidBST_b(_ root: TreeNode?) -> Bool {
    func helper(_ root: TreeNode?, _ min: Int? , _ max: Int?)-> Bool{
        guard let element = root else { return true }
        
        if let val = min , element.val <= val{
            return false
        }
        
        if let val = max , element.val >= val{
            return false
        }
        return helper(element.left,min,element.val) && helper(element.right,element.val,max)
    }
    
    return helper(root,nil,nil)
}

//https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/solution/swift-di-gui-by-hu-cheng-he-da-bai-sha-2/
//执行用时：248 ms, 在所有 Swift 提交中击败了80.49%的用户
//内存消耗：22 MB, 在所有 Swift 提交中击败了50.00%的用户
func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let element = root else {
        let node = TreeNode(val)
        return  node
    }
    
    if val > element.val {
        element.right = insertIntoBST(element.right,val)
    }else{
        element.left = insertIntoBST(element.left,val)
    }
    
    return element
}


