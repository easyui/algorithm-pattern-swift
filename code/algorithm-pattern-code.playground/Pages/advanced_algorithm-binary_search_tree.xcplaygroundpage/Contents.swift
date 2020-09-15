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

//https://leetcode-cn.com/problems/delete-node-in-a-bst/solution/swift-di-gui-shan-chu-er-cha-sou-suo-shu-mou-jie-d/
//执行用时：88 ms, 在所有 Swift 提交中击败了100.00%的用户
//内存消耗：15.5 MB, 在所有 Swift 提交中击败了86.96%的用户
func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    // 删除节点分为三种情况：
    // 1、只有左节点 替换为右
    // 2、只有右节点 替换为左
    // 3、有左右子节点 左子节点连接到右边最左节点即可
    guard let element = root  else {
        return root
    }
    
    if key < element.val {
        element.left = deleteNode(element.left, key)
    }else if key > element.val{
        element.right = deleteNode(element.right, key)
    }else{
        if element.left == nil {
            return element.right
        }else if element.right == nil {
            return element.left
        }else{
            var cur = element.right!
            // 一直向左找到最后一个左节点即可
            while cur.left != nil {
                cur = cur.left!
            }
            cur.left = element.left
            return element.right
        }
    }
    return element
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

//: [Next](@next)
