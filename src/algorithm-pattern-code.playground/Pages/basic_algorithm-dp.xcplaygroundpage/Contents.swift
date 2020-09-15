//: [Previous](@previous)

import Foundation

//https://leetcode-cn.com/problems/triangle/solution/swift-shen-du-you-xian-di-gui-huan-cun-yi-jing-bei/
//自顶向下的递归，深度优先搜索，缓存已经被计算的值
//执行用时：60 ms, 在所有 Swift 提交中击败了8.37%的用户
//内存消耗：21.4 MB, 在所有 Swift 提交中击败了5.00%的用户
func minimumTotal(_ triangle: [[Int]]) -> Int {
    var cache =  Dictionary<String, Int>()
    func dfs(_ i: Int, _ j: Int) -> Int {
        if i == triangle.count {
            return 0
        }
        if let item = cache["\(i)-\(j)"] {
            return item
        }
        let res = min(dfs(i+1,j),dfs(i+1,j+1))+triangle[i][j]
        cache["\(i)-\(j)"] = res
        return res
    }
    return dfs(0,0)
}

//https://leetcode-cn.com/problems/triangle/solution/swift-dong-tai-gui-hua-zi-di-xiang-shang-kong-jian/
//动态规划（自底向上），空间优化O(N)
//执行用时：44 ms, 在所有 Swift 提交中击败了91.16%的用户
//内存消耗：20.4 MB, 在所有 Swift 提交中击败了100.00%的用户
func minimumTotal_a(_ triangle: [[Int]]) -> Int {
    let count = triangle.count
    /*
     var dp = [[Int]](repeating: [Int](repeating: 0, count: count + 1), count: count + 1)
     for i in (0...(count-1)).reversed()  {
     for j in 0...i {
     dp[i][j] = min(dp[i+1][j],dp[i+1][j+1]) + triangle[i][j]
     }
     }
     return dp[0][0]
     */
    //空间优化O(N)
    var dp = [Int](repeating: 0, count: count + 1)
    for i in (0...(count-1)).reversed()  {
        for j in 0...i {
            dp[j] = min(dp[j],dp[j+1]) + triangle[i][j]
        }
    }
    return dp[0]
}

//https://leetcode-cn.com/problems/triangle/solution/swift-dong-tai-gui-hua-zi-ding-xiang-xia-kong-jian/
//动态规划（自顶向下），空间优化O(N)
//执行用时：48 ms, 在所有 Swift 提交中击败了71.16%的用户
//内存消耗：20.9 MB, 在所有 Swift 提交中击败了85.00%的用户
func minimumTotal_b(_ triangle: [[Int]]) -> Int {
    let count = triangle.count
    /*
     var dp = [[Int]](repeating: [Int](repeating: 0, count: count), count: count)
     dp[0][0] = triangle[0][0]
     for i in 1..<count {
     dp[i][0] = dp[i-1][0] + triangle[i][0]
     for j in 1..<i {
     dp[i][j] = min(dp[i-1][j],dp[i-1][j-1]) + triangle[i][j]
     }
     dp[i][i] = dp[i-1][i-1] + triangle[i][i]
     }
     var minTotal = dp[count-1][0]
     for i in 1..<count {
     minTotal = min(minTotal,dp[count-1][i])
     }
     return minTotal
     */
    //空间优化O(N)
    var dp = [Int](repeating: 0, count: count)
    dp[0] = triangle[0][0]
    for i in 1..<count {
        dp[i] = dp[i-1] + triangle[i][i]
        for j in (1..<i).reversed() {
            dp[j] = min(dp[j],dp[j-1]) + triangle[i][j]
        }
        dp[0] = dp[0] + triangle[i][0]
    }
    var minTotal = dp[0]
    for i in 1..<count {
        minTotal = min(minTotal,dp[i])
    }
    return minTotal
}

//print(minimumTotal_b([[46],[43,61],[10,-16,3],[-26,41,36,-72],[-28,-76,-22,26,51]]))

//https://leetcode-cn.com/problems/minimum-path-sum/solution/swift-dong-tai-gui-hua-zi-di-xiang-shang-kong-ji-2/
//动态规划（自底向上），空间优化O(N)
//执行用时：76 ms, 在所有 Swift 提交中击败了83.78%的用户
//内存消耗：20.9 MB, 在所有 Swift 提交中击败了76.92%的用户
func minPathSum(_ grid: [[Int]]) -> Int {
    /*
     let m = grid.count
     guard m != 0 else{
     return 0
     }
     let n = grid[0].count
     var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n + 1), count: m + 1)
     dp[m][n-1] =  0
     for i in (0..<m).reversed()  {
     for j in (0..<n).reversed()  {
     dp[i][j] = min(dp[i+1][j],dp[i][j+1]) + grid[i][j]
     }
     }
     return dp[0][0]
     */
    //空间优化O(N)
    let m = grid.count
    guard m != 0 else{
        return 0
    }
    let n = grid[0].count
    
    var dp =  grid[m-1]
    for i in (0..<(n-1)).reversed() {
        dp[i] += dp[i+1]
    }
    dp.append(Int.max)//dp长度是n+1
    
    for i in (0..<(m-1)).reversed()  {
        for j in (0..<n).reversed()  {
            dp[j] = min(dp[j],dp[j+1]) + grid[i][j]
        }
    }
    return dp[0]
}

//https://leetcode-cn.com/problems/minimum-path-sum/solution/swift-zi-ding-xiang-xia-de-di-gui-shen-du-you-xian/
//自顶向下的递归，深度优先搜索，缓存已经被计算的值
//执行用时：120 ms, 在所有 Swift 提交中击败了5.41%的用户
//内存消耗：22.5 MB, 在所有 Swift 提交中击败了5.77%的用户
func minPathSum_a(_ grid: [[Int]]) -> Int {
    let m = grid.count
    guard m != 0 else{
        return 0
    }
    let n = grid[0].count
    
    var cache =  Dictionary<String, Int>()
    func dfs(_ i: Int, _ j: Int) -> Int {
        if i == m || j == n {
            //m*n的最后一个特殊处理：它的右边或下边为0
            if (i == m - 1) {//(i == m - 1) || (j == n - 1)
                return 0
            }
            return Int.max
        }
        if let item = cache["\(i)-\(j)"] {
            return item
        }
        let res = min(dfs(i+1,j),dfs(i,j+1))+grid[i][j]
        cache["\(i)-\(j)"] = res
        return res
    }
    return dfs(0,0)
}
//print(minPathSum_a([[1,3,1],[1,5,1],[4,2,1]]))
//print(minPathSum_a([[0,1]]))

//https://leetcode-cn.com/problems/unique-paths/solution/swift-dong-tai-gui-hua-zi-di-xiang-shang-kong-ji-3/
//动态规划（自底向上），空间优化O(N)，注意下开始行列
//执行用时：8 ms, 在所有 Swift 提交中击败了63.64%的用户
//内存消耗：20.7 MB, 在所有 Swift 提交中击败了62.79%的用户
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    /*
     var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
     dp[m][n-1] =  1 //主要是处理最底部一行和最右边的一列
     for i in (0..<m).reversed()  {
     for j in (0..<n).reversed()  {
     dp[i][j] = dp[i+1][j] + dp[i][j+1]
     }
     }
     return dp[0][0]
     */
    //空间优化O(N)
    //方法1
    //    var dp = [Int](repeating: 1, count: n + 1)
    //    for _ in (0..<m-1).reversed()  {//从倒数第二行开始
    //        for j in (0..<n-1).reversed()  {//从倒数第二列开始
    //            dp[j] = dp[j] + dp[j+1]
    //        }
    //    }
    //    return dp[0]
    //    方法2
    var dp = [Int](repeating: 0, count: n + 1)
    dp[n-1] = 1
    for _ in (0..<m).reversed()  {
        for j in (0..<n).reversed()  {
            dp[j] = dp[j] + dp[j+1]
        }
    }
    return dp[0]
}
//print(uniquePaths(7,3))
//print(uniquePaths(1,1))


//https://leetcode-cn.com/problems/unique-paths/solution/swift-zi-ding-xiang-xia-de-di-gui-shen-du-you-xi-2/
//自顶向下的递归，深度优先搜索，缓存已经被计算的值,终止条件最低边和最右边返回1
//执行用时：8 ms, 在所有 Swift 提交中击败了63.64%的用户
//内存消耗：20.8 MB, 在所有 Swift 提交中击败了41.86%的用户
func uniquePaths_a(_ m: Int, _ n: Int) -> Int {
    var cache =  Dictionary<String, Int>()
    func dfs(_ i: Int, _ j: Int) -> Int {
        if i == m - 1 || j == n - 1 {
            return 1
        }
        if let item = cache["\(i)-\(j)"] {
            return item
        }
        let res = dfs(i+1,j) + dfs(i,j+1)
        cache["\(i)-\(j)"] = res
        return res
    }
    return dfs(0,0)
}
//print(uniquePaths_a(7,3))

//https://leetcode-cn.com/problems/unique-paths-ii/solution/swift-dong-tai-gui-hua-zi-di-xiang-shang-kong-ji-4/
//动态规划（自底向上），空间优化O(N)
//执行用时：24 ms, 在所有 Swift 提交中击败了40.23%的用户
//内存消耗：20.8 MB, 在所有 Swift 提交中击败了76.92%的用户
func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    let m = obstacleGrid.count
    guard m != 0 else{
        return 0
    }
    let n = obstacleGrid[0].count
    /*
     var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
     dp[m][n-1] =  1 //主要是处理最底部一行和最右边的一列
     for i in (0..<m).reversed()  {
     for j in (0..<n).reversed()  {
     if(obstacleGrid[i][j] == 1){
     dp[i][j] = 0
     }else{
     dp[i][j] = dp[i+1][j] + dp[i][j+1]
     }
     }
     }
     return dp[0][0]
     */
    //    空间优化O(N)
    var dp = [Int](repeating: 0, count: n + 1)
    dp[n-1] = 1
    for i in (0..<m).reversed()  {
        for j in (0..<n).reversed()  {
            if(obstacleGrid[i][j] == 1){
                dp[j] = 0
            }else{
                dp[j] = dp[j] + dp[j+1]
            }
        }
    }
    return dp[0]
}
//print(uniquePathsWithObstacles([[0,1]]))
//print(uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]]))
//print(uniquePathsWithObstacles([[0,0],[1,1],[0,0]]))
//print(uniquePathsWithObstacles([[1]]))
//print(uniquePathsWithObstacles([[0]]))



//https://leetcode-cn.com/problems/unique-paths-ii/solution/swift-di-gui-shi-xian-you-hua-huan-cun-liang-chong/
//版本：swift5
//递归实现，优化缓存，两种结束条件
//执行用时：20 ms, 在所有 Swift 提交中击败了82.76%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了15.38%的用户
func uniquePathsWithObstacles_a(_ obstacleGrid: [[Int]]) -> Int {
    let m = obstacleGrid.count
    guard m != 0 else{
        return 0
    }
    let n = obstacleGrid[0].count
    
    var cache =  Dictionary<String, Int>()
    func dfs(_ i: Int, _ j: Int) -> Int {
        if i > m - 1 || j > n - 1 || obstacleGrid[i][j] == 1{
            return 0
        }
        if i == m - 1 && j == n - 1 {
            return 1
        }
        if let item = cache["\(i)-\(j)"] {
            return item
        }
        let res = dfs(i+1,j) + dfs(i,j+1)
        cache["\(i)-\(j)"] = res
        return res
    }
    return dfs(0,0)
}
//print(uniquePathsWithObstacles_a([[0,1]]))
//print(uniquePathsWithObstacles_a([[0,0,0],[0,1,0],[0,0,0]]))
//print(uniquePathsWithObstacles_a([[0,0],[1,1],[0,0]]))


//https://leetcode-cn.com/problems/climbing-stairs/solution/swift-dong-tai-gui-hua-fxfx-1fx-2-by-hu-cheng-he-d/
//动态规划：f(x)=f(x−1)+f(x−2)
//执行用时：4 ms, 在所有 Swift 提交中击败了84.08%的用户
//内存消耗：20.7 MB, 在所有 Swift 提交中击败了64.71%的用户
func climbStairs(_ n: Int) -> Int {//n是正整数
    var x1 = 0,x2 = 1 ,x3 = 0
    for _ in 1...n {
        x3 = x1 + x2
        x1 = x2
        x2 = x3
    }
    return x3
}

//https://leetcode-cn.com/problems/climbing-stairs/solution/swift-di-gui-fxfx-1fx-2-by-hu-cheng-he-da-bai-sha/
//递归：f(x)=f(x−1)+f(x−2)
//执行用时：4 ms, 在所有 Swift 提交中击败了84.17%的用户
//内存消耗：20.7 MB, 在所有 Swift 提交中击败了64.91%的用户
func climbStairs_a(_ n: Int) -> Int {//n是正整数
    var cache = [Int](repeating: 0, count: n+1)
    func dfs(_ n: Int) -> Int{
        if cache[n] != 0 {
            return cache[n]
        }
        if n <= 2 {
            return n
        }
        //        cache[n - 1] = dfs(n - 1)
        //        cache[n - 2] = dfs(n - 2)
        //        return cache[n - 1] +  cache[n - 2]
        cache[n] = dfs(n - 1) +  dfs(n - 2)
        return cache[n]
    }
    return dfs(n)
}
//print(climbStairs_a(44))

//https://leetcode-cn.com/problems/jump-game/solution/swift-dong-tai-gui-hua-cong-qian-wang-hou-by-hu-ch/
//从前往后
//执行用时：80 ms, 在所有 Swift 提交中击败了88.08%的用户
//内存消耗：20.8 MB, 在所有 Swift 提交中击败了84.00%的用户
func canJump(_ nums: [Int]) -> Bool {
    let count = nums.count
    var distance = 0
    for i in 0..<count {
        guard i <= distance else{
            return false
        }
        distance = max(distance,nums[i]+i)
        if distance >= count - 1 {
            return true
        }
    }
    return true
}

//https://leetcode-cn.com/problems/jump-game/solution/swift-dong-tai-gui-hua-cong-hou-wang-qian-pan-duan/
//动态规划：从后往前判断
//执行用时：76 ms, 在所有 Swift 提交中击败了95.92%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了23.81%的用户
func canJump_a(_ nums: [Int]) -> Bool {
    let count = nums.count
    var endIndex = count - 1
    for i in (0..<count-1).reversed() {
        if i + nums[i] >= endIndex{
            endIndex = min(endIndex,i)
        }
    }
    return endIndex == 0
}

//https://leetcode-cn.com/problems/jump-game-ii/solution/swift-zheng-xiang-dong-tai-cha-zhao-by-hu-cheng-he/
//正向动态查找
//执行用时：84 ms, 在所有 Swift 提交中击败了74.23%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了46.15%的用户
func jump(_ nums: [Int]) -> Int {
    let count = nums.count
    var maxPosition = 0
    var step = 0
    var end = 0
    for i in 0..<(count - 1) {
        maxPosition = max(maxPosition,nums[i]+i)
        if i == end{
            end = maxPosition
            step += 1
        }
        //优化：提前结束
        if maxPosition >= count - 1{
            if end < count - 1{
                step += 1
            }
            break
        }
    }
    return step
}
//print(jump([1,2,3]))

//https://leetcode-cn.com/problems/palindrome-partitioning-ii/solution/swift-dong-tai-gui-hua-ti-qian-huan-cun-hui-wen-ch/
//动态规划，提前缓存回文串
//执行用时：116 ms, 在所有 Swift 提交中击败了100.00%的用户
//内存消耗：21.6 MB, 在所有 Swift 提交中击败了50.00%的用户
func minCut(_ s: String) -> Int {
    let count = s.count
    
    if count <= 1{
        return 0
    }
    
    var dp = Array(0..<count)
    
    let sArray = Array(s)
    
    var checkPalindrome = Array(repeating: Array(repeating: false, count: count), count: count)
    for right in 0..<count {
        for left in 0...right {
            if sArray[left] == sArray[right] && ( right - left <= 2 || checkPalindrome[left + 1][right - 1] == true) {//0,1,2距离的都可以直接判断
                checkPalindrome[left][right] = true
            }
        }
    }
    
    for right in 0..<count {
        if checkPalindrome[0][right] {
            dp[right] = 0
            continue
        }
        for left in 0..<right {
            if checkPalindrome[left + 1][right] {
                dp[right] = min(dp[right], dp[left] + 1);
            }
        }
    }
    return dp[count - 1]
}
//print(minCut("aab"))

//https://leetcode-cn.com/problems/longest-increasing-subsequence/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha-3/
//执行用时：140 ms, 在所有 Swift 提交中击败了37.38%的用户
//内存消耗：20.6 MB, 在所有 Swift 提交中击败了78.79%的用户
func lengthOfLIS(_ nums: [Int]) -> Int {
    let count = nums.count
    if count <= 1 {
        return count
    }
    var dp = Array(repeating: 1, count: count)
    var res = 1;
    for i in 1..<count {
        for j in 0..<i {
            if nums[i] > nums[j] {//dp[i]=max(dp[j])+1,其中0≤j<i且num[j]<num[i]
                dp[i] = max(dp[i],dp[j] + 1)
            }
        }
        res = max(res,dp[i])//LISlength=max(dp[i]),其中0≤i<n
    }
    return res
}

//https://leetcode-cn.com/problems/word-break/solution/swift-dong-tai-gui-hua-you-hua-bian-li-chang-du-by/
//执行用时：16 ms, 在所有 Swift 提交中击败了94.96%的用户
//内存消耗：14.3 MB, 在所有 Swift 提交中击败了100.00%的用户
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    var wordSet = Set<String>()
    var maxCount = 0
    var minCount = Int.max
    for item in wordDict {
        wordSet.insert(item)
        maxCount = max(item.count ,maxCount)
        minCount = min(item.count ,minCount)
    }
    
    
    let dpCount = s.count + 1
    var dp = Array(repeating: false, count: dpCount)
    dp[0] = true
    
    for i in 1..<dpCount {
        let left = max( i - maxCount ,0)
        let right = (i - minCount)
        if left > right{
            continue
        }
        for j in left...right {
            //        for j in 0..<i {
            //            if i - j < minCount {
            //                break;
            //            }
            //            if i - j > maxCount {
            //                continue;
            //            }
            let start = s.index(s.startIndex, offsetBy: j)
            let end = s.index(s.startIndex, offsetBy: i)
            let subStr = s[start..<end]
            if wordSet.contains(String(subStr)) && dp[j]{
                dp[i] = true
                break
            }
        }
    }
    
    return dp[dpCount-1]
}
//print(wordBreak("applepenapple",["apple","pen"]))

//https://leetcode-cn.com/problems/word-break/solution/swift-ji-yi-hua-hui-su-by-hu-cheng-he-da-bai-sha/
//执行用时：16 ms, 在所有 Swift 提交中击败了94.96%的用户
//内存消耗：14.1 MB, 在所有 Swift 提交中击败了100.00%的用户
func wordBreak_a(_ s: String, _ wordDict: [String]) -> Bool {
    var cache = [String:Bool]()
    func check(_ str: String) -> Bool{
        guard str.count > 0 else{
            return true
        }
        if let temp = cache[str]{
            return temp
        }
        var flag = false
        for word in wordDict {
            if(str.hasPrefix(word)){
                if check(String(str.suffix(str.count - word.count))) {
                    flag = true
                    break
                }
            }
        }
        cache[str] = flag
        return flag
        
    }
    return check(s)
}

//print(wordBreak_a("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab",["a","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"]))

//https://leetcode-cn.com/problems/longest-common-subsequence/solution/swift-dong-tai-gui-hua-biao-by-hu-cheng-he-da-bai-/
//执行用时：84 ms, 在所有 Swift 提交中击败了60.58%的用户
//内存消耗：21.5 MB, 在所有 Swift 提交中击败了69.77%的用户
func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    let array1 = Array(text1)
    let array2 = Array(text2)
    
    var dp = Array(repeating: Array(repeating: 0, count: array2.count + 1), count: array1.count + 1)
    
    for i in 1...array1.count {
        for j in 1...array2.count {
            if array1[i - 1] == array2[j - 1]{
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j] ,dp[i][j-1])
            }
        }
    }
    
    return dp[array1.count][array2.count]
}

//print(longestCommonSubsequence("abc","def"))

//https://leetcode-cn.com/problems/edit-distance/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha-4/
//执行用时：52 ms, 在所有 Swift 提交中击败了86.67%的用户
//内存消耗：15.9 MB, 在所有 Swift 提交中击败了100.00%的用户
func minDistance(_ word1: String, _ word2: String) -> Int {
    let array1 = Array(word1)
    let array2 = Array(word2)
    
    if array1.count == 0 || array2.count == 0 {
        return array1.count + array2.count
    }
    
    var dp = Array(repeating: Array(repeating: 0, count: array2.count + 1), count: array1.count + 1)
    for row in 0...array1.count {
        dp[row][0] = row
    }
    for column in 0...array2.count {
        dp[0][column] = column
    }
    
    for i in 1...array1.count {
        for j in 1...array2.count {
            if array1[i - 1] == array2[j - 1]{
                dp[i][j] = dp[i-1][j-1]
            } else {
                dp[i][j] = min(dp[i-1][j] ,dp[i][j-1], dp[i-1][j-1])+1
            }
        }
    }
    
    return dp[array1.count][array2.count]
}

//https://leetcode-cn.com/problems/coin-change/solution/swift-dong-tai-gui-hua-by-hu-cheng-he-da-bai-sha-5/
//执行用时：824 ms, 在所有 Swift 提交中击败了65.87%的用户
//内存消耗：13.7 MB, 在所有 Swift 提交中击败了97.26%的用户
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    if(amount == 0){
        return 0
    }
    
    var dp = Array(repeating: amount + 1, count: amount + 1)
    dp[0] = 0
    
    for money in 1...amount {
        for coin in coins {
            if money - coin >= 0 {
                dp[money] = min(dp[money],dp[money - coin] + 1)
            }
        }
    }
    
    return  (dp[amount] == amount + 1) ? -1 : dp[amount]
}
//print(coinChange([2],3))



func backPack (_ A: [Int], _ m: Int)-> Int {
    // write your code here
    // f[i][j] 前i个物品，是否能装j
    // f[i][j] =f[i-1][j] f[i-1][j-a[i] j>a[i]
    // f[0][0]=true f[...][0]=true
    // f[n][X]
    var f = Array(repeating: Array(repeating: false, count: m + 1), count: A.count + 1)
    f[0][0]=true
    
    for i in 1...A.count {
        for j in 0...m {
            f[i][j]=f[i-1][j]
            if j - A[i-1] >= 0 && f[i-1][j - A[i-1]] {
                f[i][j]=true
            }
            
        }
    }
    
    for i in (0...m).reversed() {
        if f[A.count][i] {
            return i
        }
    }
    return 0
}
//print(backPack([2,3,5,7],12))
//print(backPack([3,4,8,5],10))

func backPackII (_ m: Int,_ A: [Int],_ V: [Int])-> Int {
    // write your code here
    // f[i][j] 前i个物品，装入j背包 最大价值
    // f[i][j] =max(f[i-1][j] ,f[i-1][j-A[i]]+V[i]) 是否加入A[i]物品
    // f[0][0]=0 f[0][...]=0 f[...][0]=0
    var f = Array(repeating: Array(repeating: 0, count: m + 1), count: A.count + 1)

    for i in 1...A.count {
        for j in 0...m {
            f[i][j]=f[i-1][j]
            if j - A[i-1] >= 0  {
                f[i][j] = max(f[i-1][j], f[i-1][j - A[i-1]]+V[i-1])
            }
            
        }
    }
    
    return f[A.count][m]
}

print(backPackII(10,[2, 3, 5, 7],[1, 5, 2, 4]))
print(backPackII(10,[2, 3, 8],[2, 5, 8]))

//: [Next](@next)


