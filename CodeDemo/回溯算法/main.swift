/*
 输入一个字符串，打印出该字符串中字符的所有排列。
 你可以以任意顺序返回这个字符串数组，但里面不能有重复元素。
 
 输入：s = "abc"
 输出：["abc","acb","bac","bca","cab","cba"]
 */

func permutation(_ s: String) -> [String] {
    let sarr: [String] = s.map(String.init) // 字符串转换为数组
    let arr: [String] = sarr.sorted()
    let n = arr.count
    var rec = Array<String>() 
    var vis: Array<Bool> = Array.init(repeating: false, count: n) //var vis: [Bool] = [] 
    var perm = ""
    
    func backtrack(_ arr:[String], _ i:Int, _ n:Int, _ curPerm:String) {
        if i == n {
            rec.append(curPerm)//收录树枝结果
            return
        }
        for j in 0..<n {
            if vis[j] || (j>0 && !vis[j-1] && arr[j-1]==arr[j]) {
                continue
            }
            vis[j] = true
            perm.append(arr[j])
            backtrack(arr, i+1, n, perm)
            perm.popLast()
            vis[j] = false
        }
    }
    
    backtrack(arr, 0, n, perm)
    
//    print(rec)
    return rec
}



permutation("abc")
