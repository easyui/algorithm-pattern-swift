//: [Previous](@previous)

import Foundation

func reverseString(_ s: inout [Character]) {
    s.reverse()
}

//https://leetcode-cn.com/problems/reverse-string/solution/swift-di-gui-by-hu-cheng-he-da-bai-sha-3/
//执行用时：240 ms, 在所有 Swift 提交中击败了98.99%的用户
//内存消耗：24.9 MB, 在所有 Swift 提交中击败了15.87%的用户
func reverseString_a(_ s: inout [Character]) {
    func helper(_ s: inout [Character],_ left: Int,_ right: Int){
        if left >= right {
            return
        }
        (s[left],s[right]) = (s[right],s[left])
        helper(&s, left + 1, right - 1)
    }
    
    helper(&s, 0, s.count-1)
}

//var c: [Character] = ["h","e","l","l","o"]
//reverseString_a(&c)
//print(c)

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


//https://leetcode-cn.com/problems/swap-nodes-in-pairs/solution/swift-di-gui-by-hu-cheng-he-da-bai-sha-4/
//执行用时：4 ms, 在所有 Swift 提交中击败了98.03%的用户
//内存消耗：13.3 MB, 在所有 Swift 提交中击败了100.00%的用户
func swapPairs(_ head: ListNode?) -> ListNode? {
    guard let item = head, let next = item.next  else {
        return head
    }
    
    let nextNext = next.next
    next.next = item
    let new = swapPairs(nextNext)
    item.next = new
    return next
}


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

//https://leetcode-cn.com/problems/unique-binary-search-trees-ii/solution/swift-di-gui-li-yong-yi-xia-cha-zhao-er-cha-shu-de/
//执行用时：36 ms, 在所有 Swift 提交中击败了94.51%的用户
//内存消耗：15.3 MB, 在所有 Swift 提交中击败了91.67%的用户
//swift 递归：利用一下查找二叉树的性质。左子树的所有值小于根节点，右子树的所有值大于根节点
func generateTrees(_ n: Int) -> [TreeNode?] {
    guard n <= 0 else {
        return []
    }
    
    func helper(_ start: Int, _ end: Int) -> [TreeNode?]{
        if start > end {
            return [nil]
        }
        var trees = [TreeNode?]()
        for rootVal in start...end {
            let leftTrees = helper(start,rootVal - 1)
            let rightTrees = helper(rootVal + 1,end)
            
            for leftItem in leftTrees {
                for rightItem  in rightTrees {
                    let root = TreeNode(rootVal)
                    root.left = leftItem
                    root.right = rightItem
                    trees.append(root)
                }
            }
        }
        return trees
    }
    
    return helper(1, n)
}

//print(generateTrees(0))


//https://leetcode-cn.com/problems/fibonacci-number/solution/swift-di-gui-huan-cun-by-hu-cheng-he-da-bai-sha/
//执行用时：0 ms, 在所有 Swift 提交中击败了100.00%的用户
//内存消耗：13.6 MB, 在所有 Swift 提交中击败了96.30%的用户
func fib(_ N: Int) -> Int {
    var cache =  Dictionary<Int, Int>()
    func helper(_ n: Int) -> Int {
        if(n < 2){
             return n
         }
        if let item = cache[n] {
            print(n)
            return item
        }
         let res = helper(n-1)+helper(n-2)
         cache[n] = res
         return res
    }
 
    return helper(N)
}
fib(100)

//: [Next](@next)
