class Solution {
//     //方法1. 直接排序, 48 ms    14.1 MB
//     func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
//         var arr = nums.sorted()
//         return arr[arr.count - k]
//     }

    // 方法2. 快速选择/快速排序/分治, 80 ms    13.9 MB
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var arr :[Int] = nums
        let count = arr.count
        
        func quickSelect(_ L:Int, _ R:Int, _ Target:Int, _ M:Int) -> Int {
            let t = partition(L, R, M)
            if t == Target {
                return arr[t]
            } else if t < Target {
                return quickSelect(t+1, R, Target, Int.random(in: t+1...R))
            } else {
                return quickSelect(L, t-1, Target, Int.random(in: L...t-1)) //分治优化
            }
        }
        
        func partition(_ L:Int, _ R:Int, _ M:Int) -> Int {
            let Q = arr[M] // 轴值
            swap(M, R) // 把轴值放在最右边,这一步是为了简化计算复杂度
            var i = L - 1 // 为了统一计算模式,这里去-1的下边,因为后面还会加回来
            for j in L...R {
                if arr[j] < Q { // 与轴值作比较
                    i += 1     // 放到左边下一个位置
                    swap(i, j) // 将小值换到左边, 大值换到右边
                }
            }
            swap(R, i+1) // 调整轴值位置, 左边的小,右边的大
            return i+1 // 返回轴值下标
        }
        
        // 交换位置
        func swap(_ l:Int, _ r:Int) {
            let tmp = arr[l]
            arr[l] = arr[r]
            arr[r] = tmp
        }
        
        let m = Int.random(in: 0...count-1) // 随机值
        let res = quickSelect(0, count-1, count-k, m)
        print(res)
        return res
        
    }
}


//let nums = [3,2,1,5,6,4] // [1,2,3,5,4,6]
//let nums = [3,2,3,1,2,4,5,5,6]
let nums = [2,1]
let k = 2
Solution().findKthLargest(nums, k)
