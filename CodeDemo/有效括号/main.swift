
class Solution {
    func isValid(_ s: String) -> Bool {
        if s.isEmpty {return false}
        if s.count == 1 {return false}
        let arr:[String] = s.map(String.init)
        var stack:[String] = [arr[0]] //栈
        
        for i in 1...arr.count-1 {
            let cur = arr[i]            
            let item = String(stack.last ?? "") + cur
            if item == "()" || item == "[]" || item == "{}" {
                stack.popLast()
                continue
            }

            stack.append(cur)
        }
        
        return stack.count == 0
    }
}


Solution().isValid("{[]}")
