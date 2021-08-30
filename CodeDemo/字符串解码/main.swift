// 栈
// 递归
class Solution {
    func decodeString(_ s: String) -> String {
        if s.isEmpty {return ""}
        let array = s.map(String.init)
        var i = 0
        
        func dfs(_ index:Int) -> String {
            i = index
            var res = ""
            var multi = 0
            while i < array.count {
                let item = array[i]
                if item >= "0" && item <= "9" {
                    multi = multi * 10 + Int(item)!
                } else if item == "[" {
                    let tmp = dfs(i+1)
                    let r = String.init(repeating: tmp, count: multi)
                    res += r
                    multi = 0
//                    print("r = \(res)")
                } else if item == "]" {
                    return res
                } else {
                    res += item
                }
                i += 1
            }
//            print(res)
            return res
        }
        
        return dfs(0)
    }
}

let r = Solution().decodeString("3[a]2[bc]")
print("res = \(r)")
