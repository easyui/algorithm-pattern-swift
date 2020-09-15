//: [Previous](@previous)

import Foundation


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

func permute(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    let count = nums.count
    
    func backtrack(track: inout [Int]){
        if track.count == count{
            res.append(track)
        }
        for num in nums {
            if track.contains(num){
                continue
            }
            track.append(num)
            backtrack(track: &track)
            track.popLast()
        }
    }
    
    var items = [Int]()
    backtrack( track: &items)
    
    return res
}

//优化后的
//https://leetcode-cn.com/problems/permutations/solution/swift-46-quan-pai-lie-hui-su-tong-shi-ji-lu-shi-yo/
//执行用时：28 ms, 在所有 Swift 提交中击败了74.77%的用户
//内存消耗：13.4 MB, 在所有 Swift 提交中击败了98.28%的用户
func permute_a(_ nums: [Int]) -> [[Int]] {
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

//: [Next](@next)
