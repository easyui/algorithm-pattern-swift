# 二分搜索

## 二分搜索模板

给一个**有序数组**和目标值，找第一次/最后一次/任何一次出现的索引，如果没有出现返回-1

模板四点要素

- 1、初始化：start=0、end=len-1
- 2、循环退出条件：start + 1 < end
- 3、比较中点和目标值：A[mid] ==、 <、> target
- 4、判断最后两个元素是否符合：A[start]、A[end] ? target

时间复杂度 O(logn)，使用场景一般是有序数组的查找

典型示例

[binary-search](https://leetcode-cn.com/problems/binary-search/)

> 给定一个  n  个元素有序的（升序）整型数组  nums 和一个目标值  target  ，写一个函数搜索  nums  中的 target，如果目标值存在返回下标，否则返回 -1。

```swift
func search(_ nums: [Int], _ target: Int) -> Int {
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
    //最后剩下两个元素，手动判断
    if nums[start] == target {
        return start
    }
    
    if nums[end] == target {
        return end
    }
    
    return  -1
}
```

大部分二分查找类的题目都可以用这个模板，然后做一点特殊逻辑即可

另外二分查找还有一些其他模板如下图，大部分场景模板#3 都能解决问题，而且还能找第一次/最后一次出现的位置，应用更加广泛

![binary_search_template](https://img.fuiboom.com/img/binary_search_template.png)

所以用模板#3 就对了，详细的对比可以这边文章介绍：[二分搜索模板](https://leetcode-cn.com/explore/learn/card/binary-search/212/template-analysis/847/)

如果是最简单的二分搜索，不需要找第一个、最后一个位置、或者是没有重复元素，可以使用模板#1，代码更简洁

```swift
// 无重复元素搜索时，更方便
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
    // 如果找不到，start 是第一个大于target的索引
    // 如果在B+树结构里面二分搜索，可以return start
    // 这样可以继续向子节点搜索，如：node:=node.Children[start]
    return  -1
}
```

## 常见题目

### [search-for-range](https://www.lintcode.com/problem/search-for-a-range/description)

> 给定一个包含 n 个整数的排序数组，找出给定目标值 target 的起始和结束位置。
> 如果目标值不在数组中，则返回`[-1, -1]`

思路：核心点就是找第一个 target 的索引，和最后一个 target 的索引，所以用两次二分搜索分别找第一次和最后一次的位置

```swift
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
```

### [search-insert-position](https://leetcode-cn.com/problems/search-insert-position/)

> 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

```swift
//https://leetcode-cn.com/problems/search-insert-position/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-2/
//二分查找，思路：找到第一个 >= target 的元素位置
//执行用时：40 ms, 在所有 Swift 提交中击败了77.60%的用户
//内存消耗：20.9 MB, 在所有 Swift 提交中击败了80.65%的用户
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var start = 0
    var end = nums.count - 1
    
    while start + 1 < end {
        let mid = (end + start)/2
        if nums[mid] == target {
            end = mid//向右搜索
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
    }else{//nums[end] > target// 目标值比所有值都大
        return end + 1
    }
}
```

### [search-a-2d-matrix](https://leetcode-cn.com/problems/search-a-2d-matrix/)

> 编写一个高效的算法来判断  m x n  矩阵中，是否存在一个目标值。该矩阵具有如下特性：
>
> - 每行中的整数从左到右按升序排列。
> - 每行的第一个整数大于前一行的最后一个整数。

```swift
//https://leetcode-cn.com/problems/search-a-2d-matrix/solution/swift-m-x-nju-zhen-ke-yi-shi-wei-chang-du-wei-m-x-/
//m x n矩阵可以视为长度为m x n的有序数组来进行二分查找
//执行用时：80 ms, 在所有 Swift 提交中击败了98.61%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了84.62%的用户
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
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
```

### [first-bad-version](https://leetcode-cn.com/problems/first-bad-version/)

> 假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
> 你可以通过调用  bool isBadVersion(version)  接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。

```swift
//https://leetcode-cn.com/problems/first-bad-version/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-3/
//执行用时：44 ms, 在所有 Swift 提交中击败了10.94%的用户
//内存消耗：20.4 MB, 在所有 Swift 提交中击败了100.00%的用户
func firstBadVersion(n int) int {
    // 思路：二分搜索
    start := 0
    end := n
    for start+1 < end {
        mid := start + (end - start)/2
        if isBadVersion(mid) {
            end = mid
        } else if isBadVersion(mid) == false {
            start = mid
        }
    }
    if isBadVersion(start) {
        return start
    }
    return end
}
```

### [find-minimum-in-rotated-sorted-array](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/)

> 假设按照升序排序的数组在预先未知的某个点上进行了旋转( 例如，数组  [0,1,2,4,5,6,7] 可能变为  [4,5,6,7,0,1,2] )。
> 请找出其中最小的元素。

```swift
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
```

### [find-minimum-in-rotated-sorted-array-ii](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/)

> 假设按照升序排序的数组在预先未知的某个点上进行了旋转
> ( 例如，数组  [0,1,2,4,5,6,7] 可能变为  [4,5,6,7,0,1,2] )。
> 请找出其中最小的元素。(包含重复元素)

```swift
//https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/solution/swift-er-fen-cha-zhao-gen-ju-153ti-bi-jiao-qian-qu/
//二分查找：根据《153. 寻找旋转排序数组中的最小值（https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-by-hu-cheng-he-da-bai-sha-4/）》 ，比较前去除和start、end相等的元素
//执行用时：36 ms, 在所有 Swift 提交中击败了98.04%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了100.00%的用户
func findMin(_ nums: [Int]) -> Int {
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
```

### [search-in-rotated-sorted-array](https://leetcode-cn.com/problems/search-in-rotated-sorted-array/)

> 假设按照升序排序的数组在预先未知的某个点上进行了旋转。
> ( 例如，数组  [0,1,2,4,5,6,7]  可能变为  [4,5,6,7,0,1,2] )。
> 搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回  -1 。
> 你可以假设数组中不存在重复的元素。

```swift
//https://leetcode-cn.com/problems/search-in-rotated-sorted-array/solution/swift-er-fen-cha-zhao-que-ren-midhe-targetde-wei-z/
//执行用时：20 ms, 在所有 Swift 提交中击败了95.50%的用户
//内存消耗：20.5 MB, 在所有 Swift 提交中击败了90.91%的用户
func search(_ nums: [Int], _ target: Int) -> Int {
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
```

注意点

> 面试时，可以直接画图进行辅助说明，空讲很容易让大家都比较蒙圈

### [search-in-rotated-sorted-array-ii](https://leetcode-cn.com/problems/search-in-rotated-sorted-array-ii/)

> 假设按照升序排序的数组在预先未知的某个点上进行了旋转。
> ( 例如，数组  [0,0,1,2,2,5,6]  可能变为  [2,5,6,0,0,1,2] )。
> 编写一个函数来判断给定的目标值是否存在于数组中。若存在返回  true，否则返回  false。(包含重复元素)

```swift
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
```

## 总结

二分搜索核心四点要素（必背&理解）

- 1、初始化：start=0、end=len-1
- 2、循环退出条件：start + 1 < end
- 3、比较中点和目标值：A[mid] ==、 <、> target
- 4、判断最后两个元素是否符合：A[start]、A[end] ? target

## 练习题

- [ ] [search-for-range](https://www.lintcode.com/problem/search-for-a-range/description)
- [ ] [search-insert-position](https://leetcode-cn.com/problems/search-insert-position/)
- [ ] [search-a-2d-matrix](https://leetcode-cn.com/problems/search-a-2d-matrix/)
- [ ] [first-bad-version](https://leetcode-cn.com/problems/first-bad-version/)
- [ ] [find-minimum-in-rotated-sorted-array](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/)
- [ ] [find-minimum-in-rotated-sorted-array-ii](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/)
- [ ] [search-in-rotated-sorted-array](https://leetcode-cn.com/problems/search-in-rotated-sorted-array/)
- [ ] [search-in-rotated-sorted-array-ii](https://leetcode-cn.com/problems/search-in-rotated-sorted-array-ii/)
