// 方法3, 大堆根、堆排序
// 108 ms    13.4 MB
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var arr = nums
    // 大堆根
    // 根节点下沉, 处理每个根节点和子节点中的最大值,把最大值移动为根节点
    func downAdJust(_ root:Int, _ len:Int) {
        var a = 2 * root + 1 // 左子节点
        if a+1 < len && arr[a+1] >= arr[a] { //判断有没有又子节点以及是否为大值
            a += 1 // 右子节点
        }
        if a < len && arr[root] < arr[a] {
            arr.swapAt(root, a) //交换, 使大值成为根节点
            downAdJust(a, len) //交换后子节点需要重新下沉,因为孙节点可能比子节点大
        }
         print(arr)
    }

    func heapSort() {
        let lastRoot = Int((arr.count - 1) / 2) // 最后一个根节点
        // 从后向前遍历,处理根节点下沉
        for root in (0...lastRoot).reversed() {
            downAdJust(root, arr.count)
        }
        // 交换堆顶元素, 最大的放到最后面, 然后重新堆化前面的
        // 一步步缩减堆的范围
        for j in (0...arr.count-1).reversed() {
            arr.swapAt(0, j)
            downAdJust(0, j)
        }
         print("res = \(arr)")
    }
    
    
    heapSort()
    return arr[arr.count - k]
}


//let nums = [3,2,1,5,6,4]
let nums = [3,2,3,1,2,4,5,5,6]
let k = 4
let r = findKthLargest(nums, k)
print("第\(k)个最大的数是\(r)")
