
let s = "aabaaa"
let res = Solution().longestPalindrome(s)

class Solution {
    func longestPalindrome(_ s: String) -> String {
        //中心扩散
        if s.isEmpty { return "" }
        if s.count == 1 { return s }
        let arr = s.map(String.init)
        let count = arr.count
        var left = 0, right = 0
        for i in 0..<count-1 {
            var l = i, r = i
            for x in i...count-2 {
                if arr[x] == arr[x+1] {
                    r = x+1
                } else {
                    break
                }
            }
            if (r - l) >= (right - left) {
                left = l
                right = r
            }
            while true {
                l = max(l-1, 0)
                r = min(r+1, count-1)
                if arr[l] == arr[r] {
                    if (r - l) >= (right - left) {
                        left = l
                        right = r
                    }
                    if (i>0 && l==0) {break}
                    if r == count-1 {break}
                } else {
                    break
                }
            }
        }

        var res :String = ""
        for i in left...right {
            res.append(contentsOf: arr[i])
        }
        print(res)
        return res
    }
}
