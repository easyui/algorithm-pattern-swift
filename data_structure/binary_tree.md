# 二叉树

## 知识点

### 二叉树遍历

**前序遍历**：**先访问根节点**，再前序遍历左子树，再前序遍历右子树
**中序遍历**：先中序遍历左子树，**再访问根节点**，再中序遍历右子树
**后序遍历**：先后序遍历左子树，再后序遍历右子树，**再访问根节点**

注意点

- 以根访问顺序决定是什么遍历
- 左子树都是优先右子树

```swift
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
```
#### 前序递归

```swift
//前序递归
func preorderTraversal(_ root: TreeNode?)  {
    guard let element = root else { return  }
    // 先访问根再访问左右
    print(element.val)
    preorderTraversal(element.left)
    preorderTraversal(element.right)
}
```

#### 前序非递归

```swift
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
```

#### 中序非递归

```swift
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
```

#### 后序非递归

```swift
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
```

注意点

- 核心就是：根节点必须在右节点弹出之后，再弹出

#### DFS 深度搜索-从上到下

```swift
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
```

#### DFS 深度搜索-从下向上（分治法）

```swift
// V2：通过分治法遍历
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
```

注意点：

> DFS 深度搜索（从上到下） 和分治法区别：前者一般将最终结果通过指针参数传入，后者一般递归返回结果最后合并

#### BFS 层次遍历

```swift
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
```

### 分治法应用

先分别处理局部，再合并结果

适用场景

- 快速排序
- 归并排序
- 二叉树相关问题

分治法模板

- 递归返回条件
- 分段处理
- 合并结果

```swift
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
```

#### 典型示例

```swift
// V2：通过分治法遍历二叉树
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
```

#### 归并排序  

```swift
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
```

注意点

> 递归需要返回结果用于合并

#### 快速排序  

```swift
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
```

注意点：

> 快排方法一由于是原地交换所以没有合并过程
> 传入的索引是存在的索引（如：0、count-1 等），越界可能导致崩溃

常见题目示例

#### maximum-depth-of-binary-tree

[maximum-depth-of-binary-tree](https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/)

> 给定一个二叉树，找出其最大深度。

思路：分治法

```swift
//https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/solution/swift-fen-zhi-fa-by-hu-cheng-he-da-bai-sha/
//分治法
//执行用时：28 ms, 在所有 Swift 提交中击败了99.56%的用户
//内存消耗：21.5 MB, 在所有 Swift 提交中击败了100.00%的用户
func maxDepth(_ root: TreeNode?) -> Int {
    // 返回条件处理
    guard let node = root else { return 0 }
    
    // divide：分左右子树分别计算
    let leftNum = maxDepth(node.left)
    let rightNum = maxDepth(node.right)
    
    // conquer：合并左右子树结果
    if leftNum > rightNum{
        return leftNum + 1
    }else{
        return rightNum + 1
    }
}
```

#### balanced-binary-tree

[balanced-binary-tree](https://leetcode-cn.com/problems/balanced-binary-tree/)

> 给定一个二叉树，判断它是否是高度平衡的二叉树。

思路：分治法，左边平衡 && 右边平衡 && 左右两边高度 <= 1，

```swift
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
```

#### binary-tree-maximum-path-sum

[binary-tree-maximum-path-sum](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/)

> 给定一个**非空**二叉树，返回其最大路径和。

思路：分治法，dfs递归求某节点的最大贡献值，同时计算最大路径

```swift
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
```

#### lowest-common-ancestor-of-a-binary-tree

[lowest-common-ancestor-of-a-binary-tree](https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/)

> 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

思路：分治法，有左子树的公共祖先或者有右子树的公共祖先，就返回子树的祖先，否则返回根节点

```swift
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
```

### BFS 层次应用

#### binary-tree-level-order-traversal

[binary-tree-level-order-traversal](https://leetcode-cn.com/problems/binary-tree-level-order-traversal/)

> 给你一个二叉树，请你返回其按  **层序遍历**  得到的节点值。 （即逐层地，从左到右访问所有节点）

思路：用一个队列记录一层的元素，然后扫描这一层元素添加下一层元素到队列（一个数进去出来一次，所以复杂度 O(logN)）

```swift
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

```

#### binary-tree-level-order-traversal-ii

[binary-tree-level-order-traversal-ii](https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/)

> 给定一个二叉树，返回其节点值自底向上的层次遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）

思路：在层级遍历的基础上，翻转一下结果即可

```swift
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
```

#### binary-tree-zigzag-level-order-traversal

[binary-tree-zigzag-level-order-traversal](https://leetcode-cn.com/problems/binary-tree-zigzag-level-order-traversal/)

> 给定一个二叉树，返回其节点值的锯齿形层次遍历。Z 字形遍历

```swift
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

```

### 二叉搜索树应用

#### validate-binary-search-tree

[validate-binary-search-tree](https://leetcode-cn.com/problems/validate-binary-search-tree/)

> 给定一个二叉树，判断其是否是一个有效的二叉搜索树。

思路 1：中序遍历，检查结果列表是否已经有序

思路 2：分治法，判断左 MAX < 根 < 右 MIN

```swift
// v1
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
```

```swift
// v2分治法
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

```

#### insert-into-a-binary-search-tree

[insert-into-a-binary-search-tree](https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/)

> 给定二叉搜索树（BST）的根节点和要插入树中的值，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。

思路：找到最后一个叶子节点满足插入条件即可

```swift
// DFS查找插入位置
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
```

## 总结

- 掌握二叉树递归与非递归遍历
- 理解 DFS 前序遍历与分治法
- 理解 BFS 层次遍历

## 练习

- [ ] [maximum-depth-of-binary-tree](https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/)
- [ ] [balanced-binary-tree](https://leetcode-cn.com/problems/balanced-binary-tree/)
- [ ] [binary-tree-maximum-path-sum](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/)
- [ ] [lowest-common-ancestor-of-a-binary-tree](https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/)
- [ ] [binary-tree-level-order-traversal](https://leetcode-cn.com/problems/binary-tree-level-order-traversal/)
- [ ] [binary-tree-level-order-traversal-ii](https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/)
- [ ] [binary-tree-zigzag-level-order-traversal](https://leetcode-cn.com/problems/binary-tree-zigzag-level-order-traversal/)
- [ ] [validate-binary-search-tree](https://leetcode-cn.com/problems/validate-binary-search-tree/)
- [ ] [insert-into-a-binary-search-tree](https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/)
