# 回溯法

## 背景

回溯法（backtrack）常用于遍历列表所有子集，是 DFS 深度搜索一种，一般用于全排列，穷尽所有可能，遍历的过程实际上是一个决策树的遍历过程。时间复杂度一般 O(N!)，它不像动态规划存在重叠子问题可以优化，回溯算法就是纯暴力穷举，复杂度一般都很高。

## 模板

```swift
result = []
func backtrack(选择列表,路径):
    if 满足结束条件:
        result.add(路径)
        return
    for 选择 in 选择列表:
        做选择
        backtrack(选择列表,路径)
        撤销选择
```

核心就是从选择列表里做一个选择，然后一直递归往下搜索答案，如果遇到路径不通，就返回来撤销这次选择。

## 示例

### [subsets](https://leetcode-cn.com/problems/subsets/)

> 给定一组不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。

遍历过程

![image.png](https://img.fuiboom.com/img/backtrack.png)

```swift
//回溯
//https://leetcode-cn.com/problems/subsets/solution/swift-zi-ji-hui-su-by-hu-cheng-he-da-bai-sha/
//执行用时：8 ms, 在所有 Swift 提交中击败了97.96%的用户
//内存消耗：13.5 MB, 在所有 Swift 提交中击败了93.90%的用户
func subsets(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    
    func backtrack(start :Int, track: inout [Int]){
        res.append(track)
        for index in start..<nums.count {
            track.append(nums[index])
            backtrack(start: index+1, track: &track)
            track.popLast()
        }
    }
    
    var items = [Int]()
    backtrack(start: 0, track: &items)
    
    return res
}

//迭代
//https://leetcode-cn.com/problems/subsets/solution/swift-zi-ji-die-dai-by-hu-cheng-he-da-bai-sha/
//执行用时：12 ms, 在所有 Swift 提交中击败了76.35%的用户
//内存消耗：13.5 MB, 在所有 Swift 提交中击败了93.90%的用户
func subsets_a(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    res.append([Int]())
    
    for num in nums {
        var list = [[Int]]()
        for item in res {
            list.append(item + [num])
        }
        res.append(contentsOf: list)
    }
    
    return res
}
```

### [subsets-ii](https://leetcode-cn.com/problems/subsets-ii/)

> 给定一个可能包含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。说明：解集不能包含重复的子集。

```swift
//https://leetcode-cn.com/problems/subsets-ii/solution/swift-90-zi-ji-iihui-su-by-hu-cheng-he-da-bai-sha/
//执行用时：12 ms, 在所有 Swift 提交中击败了100.00%的用户
//内存消耗：14 MB, 在所有 Swift 提交中击败了87.50%的用户
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    let sortedNums = nums.sorted()
    
    func backtrack(start :Int, track: inout [Int]){
        res.append(track)
        for index in start..<sortedNums.count {
            if index > start && sortedNums[index] == sortedNums[index - 1]{
                continue
            }
            track.append(sortedNums[index])
            backtrack(start: index+1, track: &track)
            track.popLast()
        }
    }
    
    var items = [Int]()
    backtrack(start: 0, track: &items)
    
    return res
}
```

### [permutations](https://leetcode-cn.com/problems/permutations/)

> 给定一个   没有重复   数字的序列，返回其所有可能的全排列。

思路：需要记录已经选择过的元素，满足条件的结果才进行返回

```swift
//https://leetcode-cn.com/problems/permutations/solution/swift-46-quan-pai-lie-hui-su-tong-shi-ji-lu-shi-yo/
//执行用时：28 ms, 在所有 Swift 提交中击败了74.77%的用户
//内存消耗：13.4 MB, 在所有 Swift 提交中击败了98.28%的用户
func permute(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    let count = nums.count
    var used = [Int :Bool]()
    
    func backtrack(track: inout [Int]){
        if track.count == count{
            res.append(track)
        }
        for num in nums {
            if used[num] ?? false {
                continue
            }
            used[num] = true
            track.append(num)
            backtrack(track: &track)
            used[num] = false
            track.popLast()
        }
    }
    
    var items = [Int]()
    backtrack( track: &items)
    
    return res
}
```

### [permutations-ii](https://leetcode-cn.com/problems/permutations-ii/)

> 给定一个可包含重复数字的序列，返回所有不重复的全排列。

```swift
//https://leetcode-cn.com/problems/permutations-ii/solution/swift-47-quan-pai-lie-iipai-xu-hou-hui-su-you-hua-/
//执行用时：64 ms, 在所有 Swift 提交中击败了43.59%的用户
//内存消耗：14.5 MB, 在所有 Swift 提交中击败了89.47%的用户
func permuteUnique(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    let count = nums.count
    var used = [Int :Bool]()
    let sortedNums = nums.sorted()

    
    func backtrack(track: inout [Int]){
        if track.count == count{
            res.append(track)
        }
        for (index,num) in sortedNums.enumerated() {
            if used[index] ?? false {
                continue
            }
            
            // if index > 0 && sortedNums[index] == sortedNums[index - 1] && (used[index - 1] ?? false)  {
            //     continue
            // }
            //优化：提前剪枝
            if index > 0 && sortedNums[index] == sortedNums[index - 1] && !(used[index - 1]!)  {
                continue
            }
            
            used[index] = true
            track.append(num)
            backtrack(track: &track)
            used[index] = false
            track.popLast()
        }
    }
    
    var items = [Int]()
    backtrack( track: &items)
    
    return res
}
```

## 练习

- [ ] [subsets](https://leetcode-cn.com/problems/subsets/)
- [ ] [subsets-ii](https://leetcode-cn.com/problems/subsets-ii/)
- [ ] [permutations](https://leetcode-cn.com/problems/permutations/)
- [ ] [permutations-ii](https://leetcode-cn.com/problems/permutations-ii/)

挑战题目

- [ ] [combination-sum](https://leetcode-cn.com/problems/combination-sum/)
- [ ] [letter-combinations-of-a-phone-number](https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number/)
- [ ] [palindrome-partitioning](https://leetcode-cn.com/problems/palindrome-partitioning/)
- [ ] [restore-ip-addresses](https://leetcode-cn.com/problems/restore-ip-addresses/)
- [ ] [permutations](https://leetcode-cn.com/problems/permutations/)
