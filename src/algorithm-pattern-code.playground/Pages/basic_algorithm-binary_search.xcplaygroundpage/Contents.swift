//: [Previous](@previous)

import Foundation

//https://leetcode-cn.com/problems/binary-search/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha/
//二分查找
//执行用时：396 ms, 在所有 Swift 提交中击败了39.04%的用户
//内存消耗：20.8 MB, 在所有 Swift 提交中击败了25.00%的用户
func search(_ nums: [Int], _ target: Int) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start <= end {
        let mid = (end + start)/2
        if nums[mid] == target {
            return mid
        }else if nums[mid] > target {
            end = mid - 1
        }else {
            start = mid + 1
        }
    }
    
    return  -1
}

func search_a(_ nums: [Int], _ target: Int) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (end + start)/2
        if nums[mid] == target {
            end = mid
        }else if nums[mid] > target {
            end = mid
        }else if nums[mid] < target {
            start = mid
        }
    }
    
    if nums[start] == target {
        return start
    }
    
    if nums[end] == target {
        return end
    }
    
    return  -1
}


func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var result = [-1,-1]
    guard nums.count != 0 else {
        return result
    }
    
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (end + start)/2
        if nums[mid] == target {
            end = mid// 如果相等，应该继续向左找，就能找到第一个目标值的位置
        }else if nums[mid] > target {
            end = mid
        }else if nums[mid] < target {
            start = mid
        }
    }
    
    // 搜索左边的索引
    if nums[start] == target {
        result[0] = start
    } else if nums[end] == target {
        result[0] = end
    } else {
        return [-1,-1]
    }
    
    start = 0
    end = nums.count - 1
    
    while start + 1 < end {
        let mid = (end + start)/2
        if nums[mid] == target {
            start = mid// 如果相等，应该继续向右找，就能找到最后一个目标值的位置
        }else if nums[mid] > target {
            end = mid
        }else if nums[mid] < target {
            start = mid
        }
    }
    
    // 搜索右边的索引
    if result[end] == target {
        result[1] = end
    } else if result[start] == target {
        result[1] = start
    } else {
        return [-1,-1]
    }
    
    return result
}

//https://leetcode-cn.com/problems/search-insert-position/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-2/
//二分查找
//执行用时：40 ms, 在所有 Swift 提交中击败了77.60%的用户
//内存消耗：20.9 MB, 在所有 Swift 提交中击败了80.65%的用户
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (end + start)/2
        if nums[mid] == target {
            end = mid
        }else if nums[mid] > target {
            end = mid
        }else if nums[mid] < target {
            start = mid
        }
    }
    
    if nums[start] >= target {
        return start
    }else if nums[end] >= target {
        return end
    }else{//nums[end] > target
        return end + 1
    }
}


//https://leetcode-cn.com/problems/search-a-2d-matrix/solution/swift-liang-ci-er-fen-cha-zhao-xian-xing-er-fen-za/
//两次二分查找：先行二分再目标行二分
//执行用时：80 ms, 在所有 Swift 提交中击败了98.41%的用户
//内存消耗：20.8 MB, 在所有 Swift 提交中击败了66.67%的用户
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    if matrix.count == 0 {
        return false
    }
    if matrix[0].count == 0 {
        return false
    }
    
    var start = 0
    var end = matrix.count - 1
    var row = 0
    while start + 1 < end {
        let mid = (end + start)/2
        let midValue =  matrix[mid][0]
        if midValue == target {
            return true
        }else if midValue > target {
            end = mid
        }else if midValue < target {
            start = mid
        }
    }
    
    if matrix[start][0] == target || matrix[end][0] == target {
        return true
    }else if target < matrix[start][0] {
        return false
    }else if target < matrix[end][0]  {
        row = start
    }else{
        row = end
    }
    
    start = 0
    end = matrix[row].count - 1
    while start <= end {
        let mid = (end + start)/2
        let midValue =  matrix[row][mid]
        if midValue == target {
            return true
        }else if midValue > target {
            end = mid - 1
        }else if midValue < target {
            start = mid + 1
        }
    }
    return false
}

//https://leetcode-cn.com/problems/search-a-2d-matrix/solution/swift-m-x-nju-zhen-ke-yi-shi-wei-chang-du-wei-m-x-/
//m x n矩阵可以视为长度为m x n的有序数组来进行二分查找
//执行用时：80 ms, 在所有 Swift 提交中击败了98.61%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了84.62%的用户
func searchMatrix_a(_ matrix: [[Int]], _ target: Int) -> Bool {
    let m = matrix.count
    if m == 0 {
        return false
    }
    let n = matrix[0].count
    if n == 0 {
        return false
    }
    
    var start = 0
    var end = m * n - 1
    
    while start <= end {
        let mid = (end + start)/2
        let midValue = matrix[mid/n][mid%n]
        if target == midValue {
            return true
        }else if target > midValue{
            start = mid + 1
        }else{
            end = mid - 1
        }
    }
    
    return false
}


/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

func firstBadVersion(_ n: Int) -> Int {
    var start = 1
    var end = n
    while start + 1 < end {
        let mid = (end + start)/2
        if isBadVersion(mid){
            end = mid
        }else if !isBadVersion(mid){
            start = mid
        }
    }
    if isBadVersion(start){
        return start
    }
    return end
}

func isBadVersion(_ n: Int) -> Bool{
    return n >= 0
}

//https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-4/
//执行用时：20 ms, 在所有 Swift 提交中击败了93.02%的用户
//内存消耗：21.2 MB, 在所有 Swift 提交中击败了33.33%的用户
func findMin(_ nums: [Int]) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (start + end)/2
        //        if nums[mid] > nums[start] && nums[mid] > nums[end] {
        //            start = mid + 1
        //        } else if  nums[mid] < nums[start] && nums[mid] < nums[end]{
        //            end = mid - 1
        //        } else if  nums[mid] > nums[start] && nums[mid] < nums[end]{
        //            end = mid - 1
        //        }
        if nums[mid] > nums[end] {
            start = mid
        } else {
            end = mid
        }
    }
    return (nums[start] > nums[end]) ? nums[end]  : nums[start]
}

//https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/solution/swift-er-fen-cha-zhao-gen-ju-153ti-bi-jiao-qian-qu/
//二分查找：根据《153. 寻找旋转排序数组中的最小值（https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-4/）》 ，比较前去除和start、end相等的元素
//执行用时：36 ms, 在所有 Swift 提交中击败了98.04%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了100.00%的用户

func findMin_2(_ nums: [Int]) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        
        while start + 1 < end {
            if nums[start] == nums[start + 1] {
                start += 1
            } else {
                break
            }
        }
        while end - 1 > start {
            if nums[end] == nums[end - 1] {
                end -= 1
            } else {
                break
            }
        }
        
        let mid = (start + end)/2
        if nums[mid] > nums[end] {
            start = mid
        } else {
            end = mid
        }
    }
    return (nums[start] > nums[end]) ? nums[end]  : nums[start]
}

func search_2(_ nums: [Int], _ target: Int) -> Int {
    if nums.count == 0 {
        return -1
    } else  if nums.count == 1 {
        return nums[0] == target ? 0 : -1
    }
    
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (start + end)/2
        if target == nums[mid] {
            return mid
        }else if target < nums[mid] {
            if target >= nums[start] {
                end = mid
            } else {
                if nums[mid] > nums[end]{
                    start = mid
                }else{
                    end = mid
                }
            }
        } else {
            if target <= nums[end] {
                start = mid
            } else {
                if nums[mid] > nums[end]{
                    start = mid
                }else{
                    end = mid
                }
                
            }
        }
    }
    if nums[start] == target {
        return start
    } else if nums[end] == target {
        return end
    }
    return -1
}

func search_2_a(_ nums: [Int], _ target: Int) -> Int {
    if nums.count == 0 {
        return -1
    } else  if nums.count == 1 {
        return nums[0] == target ? 0 : -1
    }
    
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (start + end)/2
        if target == nums[mid] {
            return mid
        }else if target < nums[mid] {
            if nums[mid] > nums[end] && target < nums[start]{
                start = mid
            }else{
                end = mid
            }
        } else {
            if nums[mid] < nums[end] && target > nums[end]{
                end = mid
            }else{
                start = mid
            }
        }
    }
    if nums[start] == target {
        return start
    } else if nums[end] == target {
        return end
    }
    return -1
}

//https://leetcode-cn.com/problems/search-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-que-ren-midhe-targetde-wei-z/
//执行用时：20 ms, 在所有 Swift 提交中击败了95.50%的用户
//内存消耗：20.5 MB, 在所有 Swift 提交中击败了90.91%的用户
func search_2_b(_ nums: [Int], _ target: Int) -> Int {
    if nums.count == 0 {
        return -1
    } else  if nums.count == 1 {
        return nums[0] == target ? 0 : -1
    }
    
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (start + end)/2
        if target == nums[mid] {
            return mid
        }
        if nums[start] <= nums[mid] { //这里可以小于
            if target <= nums[mid] && target >= nums[start]{
                end = mid
            }else{
                start = mid
            }
        } else {
            if target >= nums[mid] && target <= nums[end]{
                start = mid
            }else{
                end = mid
            }
        }
    }
    if nums[start] == target {
        return start
    } else if nums[end] == target {
        return end
    }
    return -1
}


//https://leetcode-cn.com/problems/search-in-rotated-sorted-array-ii/solution/swift-zai-33ti-ji-chu-shang-bi-jiao-qian-xian-qu-c/
//在33题基础上：比较前先去除头尾重复（33题：https://leetcode-cn.com/problems/search-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-que-ren-midhe-targetde-wei-z/）
//执行用时：40 ms, 在所有 Swift 提交中击败了94.29%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了100.00%的用户
func search_3(_ nums: [Int], _ target: Int) -> Bool {
    if nums.count == 0 {
        return false
    } else  if nums.count == 1 {
        return nums[0] == target
    }
    
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        while start + 1 < end {
            if nums[start] == nums[start + 1] {
                start += 1
            } else {
                break
            }
        }
        while end - 1 > start {
            if nums[end] == nums[end - 1] {
                end -= 1
            } else {
                break
            }
        }
        
        
        let mid = (start + end)/2
        if target == nums[mid] {
            return true
        }
        if nums[start] <= nums[mid] { //必须要小于等于，因为前面去重的时候可能导致start+1==end
            if target <= nums[mid] && target >= nums[start]{
                end = mid
            }else{
                start = mid
            }
        } else {
            if target >= nums[mid] && target <= nums[end]{
                start = mid
            }else{
                end = mid
            }
        }
    }
    return (nums[start] == target) || (nums[end] == target)
}

//: [Next](@next)
