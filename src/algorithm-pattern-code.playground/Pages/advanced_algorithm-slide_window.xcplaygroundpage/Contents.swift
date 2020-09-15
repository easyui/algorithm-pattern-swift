//: [Previous](@previous)

import Foundation

//https://leetcode-cn.com/problems/minimum-window-substring/solution/swift-hua-dong-chuang-kou-you-hua-by-hu-cheng-he-d/
//执行用时：168 ms, 在所有 Swift 提交中击败了70.27%的用户
//内存消耗：15.5 MB, 在所有 Swift 提交中击败了96.67%的用户
func minWindow(_ s: String, _ t: String) -> String {
    let sArray = [Character](s)
    
    var win =  Dictionary<Character, Int>()    // 保存滑动窗口字符集
    var need = Dictionary<Character, Int>()    // 保存需要的字符集
    
    for c in t {
        need[c, default: 0] += 1
    }
    
    var left = 0 ,right = 0    // 窗口
    var match = 0    // match匹配次数
    var start = 0 , end = 0
    var minLength = Int.max
    
    while right < sArray.count {
        let rightItem = sArray[right]
        right += 1
        // 在需要的字符集里面，添加到窗口字符集里面
        if need[rightItem] != nil{
            win[rightItem,  default: 0] += 1
            // 如果当前字符的数量匹配需要的字符的数量，则match值+1
            if win[rightItem] == need[rightItem]{
                match += 1
            }
        }else{
            continue
        }
        
        // 当所有字符数量都匹配之后，开始缩紧窗口
        while match == need.count {
            if right - left < minLength {
                start = left
                end = right
                minLength = end - start
            }
            
            let leftItem = sArray[left]
            left += 1
            // 左指针指向不在需要字符集则直接跳过
            if need[leftItem] != nil{
                // 左指针指向字符数量和需要的字符相等时，右移之后match值就不匹配则减一
                // 因为win里面的字符数可能比较多，如有10个A，但需要的字符数量可能为3
                // 所以在压死骆驼的最后一根稻草时，match才减一，这时候才跳出循环
                if win[leftItem] == need[leftItem]{
                    match -= 1
                }
                win[leftItem]! -= 1
            }
        }
    }
    
    return minLength == Int.max ? "" : String(sArray[start..<end])
}
//print(minWindow("ADOBECODEBANC","ABC"))


//https://leetcode-cn.com/problems/permutation-in-string/solution/swift-hua-dong-chuang-kou-by-hu-cheng-he-da-bai-sh/
//执行用时：456 ms, 在所有 Swift 提交中击败了47.06%的用户
//内存消耗：13.9 MB, 在所有 Swift 提交中击败了100.00%的用户
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    let s2Array = [Character](s2)
    
    var win =  Dictionary<Character, Int>()    // 保存滑动窗口字符集
    var need = Dictionary<Character, Int>()    // 保存需要的字符集
    
    for c in s1 {
        need[c, default: 0] += 1
    }
    
    var left = 0 ,right = 0    // 窗口
    var match = 0    // match匹配次数
    
    while right < s2Array.count {
        let rightItem = s2Array[right]
        right += 1
        // 在需要的字符集里面，添加到窗口字符集里面
        if need[rightItem] != nil{
            win[rightItem,  default: 0] += 1
            // 如果当前字符的数量匹配需要的字符的数量，则match值+1
            if win[rightItem] == need[rightItem]{
                match += 1
            }
        }else{
            continue
        }
        
        // 当所有字符数量都匹配之后，开始缩紧窗口
        while match == need.count {
            if right - left == s1.count {
                return true
            }
            
            let leftItem = s2Array[left]
            left += 1
            // 左指针指向不在需要字符集则直接跳过
            if need[leftItem] != nil{
                // 左指针指向字符数量和需要的字符相等时，右移之后match值就不匹配则减一
                // 因为win里面的字符数可能比较多，如有10个A，但需要的字符数量可能为3
                // 所以在压死骆驼的最后一根稻草时，match才减一，这时候才跳出循环
                if win[leftItem] == need[leftItem]{
                    match -= 1
                }
                win[leftItem]! -= 1
            }
        }
    }
    return false
}

//https://leetcode-cn.com/problems/find-all-anagrams-in-a-string/solution/swift-hua-dong-chuang-kou-by-hu-cheng-he-da-bai--2/
//执行用时：2008 ms, 在所有 Swift 提交中击败了16.67%的用户
//内存消耗：14.7 MB, 在所有 Swift 提交中击败了100.00%的用户
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    let sArray = [Character](s)
    
    var win =  [Character: Int]()    // 保存滑动窗口字符集
    var need = [Character: Int]()    // 保存需要的字符集
    
    for c in p {
        need[c, default: 0] += 1
    }
    
    var left = 0 ,right = 0    // 窗口
    var match = 0    // match匹配次数
    var startIndexs = [Int]()
    
    while right < sArray.count {
        let rightItem = sArray[right]
        right += 1
        // 在需要的字符集里面，添加到窗口字符集里面
        if let needItem = need[rightItem] {
            win[rightItem,  default: 0] += 1
            // 如果当前字符的数量匹配需要的字符的数量，则match值+1
            if win[rightItem] == needItem{
                match += 1
            }
        }else{
            continue
        }
        
        while match == need.count {
            if right - left == p.count {
                startIndexs.append(left)
            }
            
            let leftItem = sArray[left]
            left += 1
            if let needItem = need[leftItem] {
                if win[leftItem] == needItem{
                    match -= 1
                }
                win[leftItem]! -= 1
            }
        }
    }
    
    return startIndexs
}

//https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/solution/swift-hua-dong-chuang-kou-by-hu-cheng-he-da-bai--2/
//执行用时：76 ms, 在所有 Swift 提交中击败了59.25%的用户
//内存消耗：14.4 MB, 在所有 Swift 提交中击败了89.78%的用户
func lengthOfLongestSubstring(_ s: String) -> Int {
    let sArray = [Character](s)
    
    var win =  Dictionary<Character, Int>()
    
    var left = 0 ,right = 0    // 窗口
    var maxLength = 0
    
    while right < sArray.count {
        let rightItem = sArray[right]
        right += 1
        win[rightItem,  default: 0] += 1
        while win[rightItem]! > 1 {
            let leftItem = sArray[left]
            left += 1
            win[leftItem]! -= 1
        }
        maxLength = max(maxLength,right - left)
    }
    
    return maxLength
}
//: [Next](@next)
