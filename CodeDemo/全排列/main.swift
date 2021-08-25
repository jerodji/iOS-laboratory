
Solution().permute([1,2,3])

class Solution {
    // 回溯， 树
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {return []}
        if nums.count == 1 {return [nums]}
        let count = nums.count
        var res:[[Int]] = []
        var used:[Bool] = Array.init(repeating: false, count: count)
        var r:[Int] = []

        func backtrack(_ i:Int) {
            // 中止条件,收取结果
            if i == count {
                print(r)
                res.append(r)
                return 
            }
            // 回溯
            for j in 0..<count {
                if used[j] == false {
                    r.append(nums[j])
                    used[j] = true
                    backtrack(i+1)
                    used[j] = false
                    r.popLast()
                }
            }
        }
        
        backtrack(0)
        
        return res
    }
}
