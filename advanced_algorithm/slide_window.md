# 滑动窗口

## 模板

```swift
/* 滑动窗口算法框架 */
func slidingWindow(_ s: String, _ t: String) {
    let sArray = [Character](s)
    
    var win =  Dictionary<Character, Int>()    // 保存滑动窗口字符集
    var need = Dictionary<Character, Int>()    // 保存需要的字符集
    
    for c in t {
        need[c, default: 0] += 1
    }
    
    var left = 0 ,right = 0    // 窗口
    var valid = 0    // 匹配次数
    
    while right < sArray.count {
		// rightItem 是将移入窗口的字符
        let rightItem = sArray[right]
		// 右移窗口
        right += 1
        // 进行窗口内数据的一系列更新
        ...

        /*** debug 输出的位置 ***/
        print("window: [\(left), \(right))\n", left, right);
        /********************/
        

		// 判断左侧窗口是否要收缩
        while (window needs shrink) {
            // d 是将移出窗口的字符
            let leftItem = sArray[left]
            // 左移窗口
            left += 1
            // 进行窗口内数据的一系列更新
            ...
        }
    }    
}
/* 滑动窗口算法框架 */
void slidingWindow(string s, string t) {
    unordered_map<char, int> need, window;
    for (char c : t) need[c]++;

    int left = 0, right = 0;
    int valid = 0;
    while (right < s.size()) {
        // c 是将移入窗口的字符
        char c = s[right];
        // 右移窗口
        right++;
        // 进行窗口内数据的一系列更新
        ...

        /*** debug 输出的位置 ***/
        printf("window: [%d, %d)\n", left, right);
        /********************/

        // 判断左侧窗口是否要收缩
        while (window needs shrink) {
            // d 是将移出窗口的字符
            char d = s[left];
            // 左移窗口
            left++;
            // 进行窗口内数据的一系列更新
            ...
        }
    }
}
```

需要变化的地方

- 1、右指针右移之后窗口数据更新
- 2、判断窗口是否要收缩
- 3、左指针右移之后窗口数据更新
- 4、根据题意计算结果

## 示例

[minimum-window-substring](https://leetcode-cn.com/problems/minimum-window-substring/)

> 给你一个字符串 S、一个字符串 T，请在字符串 S 里面找出：包含 T 所有字母的最小子串

```swift
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
```

[permutation-in-string](https://leetcode-cn.com/problems/permutation-in-string/)

> 给定两个字符串  **s1**  和  **s2**，写一个函数来判断  **s2**  是否包含  **s1** 的排列。

```swift
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
```

[find-all-anagrams-in-a-string](https://leetcode-cn.com/problems/find-all-anagrams-in-a-string/)

> 给定一个字符串  **s** 和一个非空字符串  **p**，找到  **s** 中所有是  **p** 的字母异位词的子串，返回这些子串的起始索引。

```swift
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
```

[longest-substring-without-repeating-characters](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/)

> 给定一个字符串，请你找出其中不含有重复字符的   最长子串   的长度。
> 示例  1:
>
> 输入: "abcabcbb"
> 输出: 3
> 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

```swift
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
```

## 总结

- 和双指针题目类似，更像双指针的升级版，滑动窗口核心点是维护一个窗口集，根据窗口集来进行处理
- 核心步骤
  - right 右移
  - 收缩
  - left 右移
  - 求结果

## 练习

- [ ] [minimum-window-substring](https://leetcode-cn.com/problems/minimum-window-substring/)
- [ ] [permutation-in-string](https://leetcode-cn.com/problems/permutation-in-string/)
- [ ] [find-all-anagrams-in-a-string](https://leetcode-cn.com/problems/find-all-anagrams-in-a-string/)
- [ ] [longest-substring-without-repeating-characters](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/)
