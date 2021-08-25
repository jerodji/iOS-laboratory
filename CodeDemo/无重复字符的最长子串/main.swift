/*
 abcabcbb
 pwwkew
 dvdf
 */
Solution().lengthOfLongestSubstring("dvdf")

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        if s.count == 1 { return 1 }
        var map :[Int:String] = [:]
        var start = 0, end = 0
        var substr = ""
        let count = s.count
        for i in 0..<count {
            substr = String(s.prefix(i+1).last!)
            for j in (i+1)..<count {
                let c = s.prefix(j+1).last!
                if substr.contains(c) {
                    map[substr.count] = substr
                    break
                } else {
                    substr.append(c)
                }
            }
            map[substr.count] = substr
        }

        return map.keys.max()!
    }
}


