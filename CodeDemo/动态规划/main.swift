/*
 输入一个整型数组，数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。
 要求时间复杂度为O(n)。
 
 示例1:
 输入: nums = [-2,1,-3,4,-1,2,1,-5,4]
 输出: 6
 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 */
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        var dp:[Int] = []
        dp.append(nums[0])
        for i in 1..<nums.count {
            let pre = dp[i-1];
            if (pre > 0) {
                dp.append(pre + nums[i])
            } else {
                dp.append(nums[i])
            }
        }
        return dp.max()!
    }
    
    //找出最大和的连续子数组
    func maxSub(_ nums:[Int]) -> [Int] {
        var dp:[Int] = [nums[0]]
        var start = 0, end = 0
        for i in 1..<nums.count {
            let pre = dp[i-1]
            let r = nums[i]
            if pre < 0 {
                dp.append(r)
                start = i
                //end = i
            } else {
                dp.append(r+pre)
            }
        }
        end = dp.lastIndex(of: dp.max()!)!
        let res:[Int] = Array(nums.prefix(end+1).suffix(from: start))
        return res
    }
}


let nums = [-2,1,-3,4,-1,2,1,-5,4]

let sol = Solution()
let dp = sol.maxSubArray(nums)
print(dp)
let res = sol.maxSub(nums)
print(res)

