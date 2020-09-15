//: [Previous](@previous)

import Foundation
//快速排序
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

//归并排序
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

//堆排序：大堆堆
func heapSort(a: inout [Int]) -> [Int] {
    // 1、无序数组a
    // 2、将无序数组a构建为一个大根堆
    for i in (a.count/2 - 1)...0 {
        sink(&a, i, a.count)
    }
    // 3、交换a[0]和a[len(a)-1]
    // 4、然后把前面这段数组继续下沉保持堆结构，如此循环即可
    for i in (a.count - 1)...1 {
        // 从后往前填充值
        exchange(&a, 0, i)
        // 前面的长度也减一
        sink(&a, 0, i)
    }
    return a
}
func sink(_ a:inout [Int], _ i: Int, _ length: Int) {
    var index = i
    while true {
        // 左节点索引(从0开始，所以左节点为i*2+1)
        let l = index*2 + 1
        // 有节点索引
        let r = index*2 + 2
        // idx保存根、左、右三者之间较大值的索引
        var idx = index
        // 存在左节点，左节点值较大，则取左节点
        if l < length && a[l] > a[idx] {
            idx = l
        }
        // 存在有节点，且值较大，取右节点
        if r < length && a[r] > a[idx] {
            idx = r
        }
        // 如果根节点较大，则不用下沉
        if idx == index {
            break
        }
        // 如果根节点较小，则交换值，并继续下沉
        exchange(&a, index, idx)
        // 继续下沉idx节点
        index = idx
    }
}
func exchange(_ a: inout [Int], _ i: Int, _ j: Int) {
    let temp = a[i]
    a[i] = a[j]
    a[j] = temp
}
//: [Next](@next)
