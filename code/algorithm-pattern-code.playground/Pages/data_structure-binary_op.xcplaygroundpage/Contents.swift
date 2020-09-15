//: [Previous](@previous)

import Foundation

//https://leetcode-cn.com/problems/single-number/solution/swift-wei-yun-suan-by-hu-cheng-he-da-bai-sha/
//执行用时：88 ms, 在所有 Swift 提交中击败了99.50%的用户
//内存消耗：20.7 MB, 在所有 Swift 提交中击败了100.00%的用户
/*
 异或运算有以下三个性质:
 任何数和 0 做异或运算，结果仍然是原来的数，即 a^0=a。
 任何数和其自身做异或运算，结果是 0，即 a^a=0。
 异或运算满足交换律和结合律，即 a^b^a=b^a^a=b^(a^a)=b^0=b。
 */
func singleNumber(_ nums: [Int]) -> Int {
    var res = 0
    for i in nums {
        res ^= i
    }
    return res
}

//https://leetcode-cn.com/problems/single-number-ii/solution/swift-wei-yun-suan-by-hu-cheng-he-da-bai-sha-2/
//思路：https://leetcode-cn.com/problems/single-number-ii/solution/single-number-ii-mo-ni-san-jin-zhi-fa-by-jin407891/
//执行用时：60 ms, 在所有 Swift 提交中击败了94.29%的用户
//内存消耗：21.1 MB, 在所有 Swift 提交中击败了100.00%的用户
func singleNumber_1(_ nums: [Int]) -> Int {
    var once = 0 ,twice = 0
    for i in nums {
         once  = (i ^ once) & ~twice
         twice = (i ^ twice) & ~once
    }
    return once
}


//https://leetcode-cn.com/problems/single-number-iii/solution/swift-fen-liang-zu-lai-jiang-wei-dao-qiu-chu-xian-/
//分两组来降维到求出现一次的数字
//执行用时：84 ms, 在所有 Swift 提交中击败了83.87%的用户
//执行用时：84 ms, 在所有 Swift 提交中击败了83.87%的用户
func singleNumber_2(_ nums: [Int]) -> [Int] {
    //全部异或，最后结果就是这两个数字的异或
    let allORX = nums.reduce(0,^)
    //保留最低位的1（可以其他位的1，这里这样处理简单）其他位清零。因为这1是两个数的不同点，这样可以把nums所有数字按这个数是1或0分成2组（这两个数字也分别在2个组，所以这个问题就可以降维到所有数字中找一个是特别的）
    let diff = allORX & (-allORX)//-allORX是补码
    //分两组
    var x = 0
    nums.forEach { num in
        if (diff & num) == 0 {//把所有这个位的0取异或就可以找到其中一个数字
            x ^= num
        }
    }
    /*
     根据：
      a=a^b
      b=a^b
      a=a^b
     求得另一个数字是allORX^x
     */
    return [x,allORX^x]
}

//https://leetcode-cn.com/problems/number-of-1-bits/solution/swift-zai-er-jin-zhi-biao-shi-zhong-shu-zi-n-zhong/
//在二进制表示中，数字 n 中最低位的 1总是对应 n - 1中的 0 。因此，将 n 和 n - 1与运算总是能把 n中最低位的 1 变成 0 ，并保持其他位不变。
//执行用时：8 ms, 在所有 Swift 提交中击败了75.00%的用户
//内存消耗：20 MB, 在所有 Swift 提交中击败了100.00%的用户
func hammingWeight(_ n: Int) -> Int {
    var res = 0
    var i = n
    while i != 0 {
        i &= (i - 1)
        res += 1
    }
    return res
}

//https://leetcode-cn.com/problems/counting-bits/solution/swift-bian-li-mei-ge-shu-an-191-wei-1de-ge-shu-qiu/
//遍历每个数，按《191. 位1的个数》求出每个数的1的个数（在二进制表示中，数字 n 中最低位的 1总是对应 n - 1中的 0 。因此，将 n 和 n - 1与运算总是能把 n中最低位的 1 变成 0 ，并保持其他位不变。）
//执行用时：80 ms, 在所有 Swift 提交中击败了92.31%的用户
//内存消耗：24.6 MB, 在所有 Swift 提交中击败了100.00%的用户
func countBits(_ num: Int) -> [Int] {
    func hammingWeight(_ n: Int) -> Int {
        var res = 0
        var i = n
        while i != 0 {
            i &= (i - 1)
            res += 1
        }
        return res
    }
    var res = [Int]()
    for i in 0...num {
        res.append(hammingWeight(i))
    }
    return res
}

//https://leetcode-cn.com/problems/counting-bits/solution/swift-dong-tai-gui-hua-ibi-ii-1duo-yi-ge-1zai-zui-/
/*
依据：
在二进制表示中，数字 n 中最低位的 1总是对应 n - 1中的 0 。因此，将 n 和 n - 1与运算总是能把 n中最低位的 1 变成 0 ，并保持其他位不变。
所以：
用i比i&(i-1)多一个1（在最低有效位）来动态规划
 */
// ms, 在所有 Swift 提交中击败了96.15%的用户
//内存消耗：24.6 MB, 在所有 Swift 提交中击败了100.00%的用户
func countBits_a(_ num: Int) -> [Int] {
    if num == 0{
        return [0]
    }
    var res = Array(repeating: 0, count: num+1)
    for i in 1...num {
        res[i] = res[i&(i-1)] + 1
    }
    return res
}

//https://leetcode-cn.com/problems/counting-bits/solution/swift-dong-tai-gui-hua-qi-ou-shu-by-hu-cheng-he-da/
/*
对于所有的数字，只有两类：
奇数：二进制表示中，奇数一定比前面那个偶数多一个 1，因为多的就是最低位的 1。
偶数：二进制表示中，偶数中 1 的个数一定和除以 2 之后的那个数一样多。因为最低位是 0，除以 2 就是右移一位，也就是把那个 0 抹掉而已，所以 1 的个数是不变的。
 */
//执行用时：80 ms, 在所有 Swift 提交中击败了92.31%的用户
//内存消耗：24.6 MB, 在所有 Swift 提交中击败了100.00%的用s户
func countBits_b(_ num: Int) -> [Int] {
    if num == 0{
        return [0]
    }
    var res = Array(repeating: 0, count: num+1)
    for i in 1...num {
        if i&1 == 0 {// x / 2 is x >> 1 and x % 2 is x & 1
            //偶数
            res[i] = res[i>>1]
        }else{
            //奇数
            res[i] = res[i-1] + 1
        }
    }
    return res
}

//https://leetcode-cn.com/problems/counting-bits/solution/swift-dong-tai-gui-hua-zui-di-you-xiao-wei-by-hu-c/
//动态规划+最低有效位
//执行用时：84 ms, 在所有 Swift 提交中击败了80.77%的用户
//内存消耗：24.6 MB, 在所有 Swift 提交中击败了100.00%的用户
func countBits_c(_ num: Int) -> [Int] {
    if num == 0{
        return [0]
    }
    var res = Array(repeating: 0, count: num+1)
    for i in 1...num {
        /*
        if i&1 == 0 {// x / 2 is x >> 1 and x % 2 is x & 1
            //偶数
            res[i] = res[i>>1]
        }else{
            //奇数
            res[i] = res[i-1] + 1
        }
        */
        res[i] = res[i>>1] + i&1//P(x)=P(x/2)+(xmod2) //用奇偶数也可以推导出
    }
    return res
}

//https://leetcode-cn.com/problems/reverse-bits/solution/swift-yi-ci-dian-dao-er-jin-zhi-wei-by-hu-cheng-he/
//依次颠倒二进制位
//执行用时：16 ms, 在所有 Swift 提交中击败了64.29%的用户
//内存消耗：20.7 MB, 在所有 Swift 提交中击败了100.00%的用户
func reverseBits(_ n: Int) -> Int {
    var num = n
    var res = 0
    var pow = 31
    while num != 0 {
        let bit = num&1
        res += bit << pow
        
        num = num >> 1
        pow -= 1
    }
    return res
}

//https://leetcode-cn.com/problems/bitwise-and-of-numbers-range/solution/swift-zui-zhong-jie-guo-you-zuo-bian-gong-gong-zhi/
//最终结果由左边公共值决定
//执行用时：24 ms, 在所有 Swift 提交中击败了100.00%的用户
//内存消耗：21 MB, 在所有 Swift 提交中击败了100.00%的用户
func rangeBitwiseAnd(_ m: Int, _ n: Int) -> Int {
    var num = n
    while m < num {
        num = num&(num-1)
    }
    return m&num
}
