
// Definition for a binary tree node.
 public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init() { self.val = 0; self.left = nil; self.right = nil; }
      public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
      public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
          self.val = val
          self.left = left
          self.right = right
      }
 }

/*
 执行用时：8 ms, 在所有 Swift 提交中击败了 99.63% 的用户
 内存消耗：13.8 MB, 在所有 Swift 提交中击败了 76.47% 的用户
 */
class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {return []}
        var res :[[Int]] = []
        var queue : [TreeNode] = []
        queue.append(root!)
        while !queue.isEmpty {
            let levelSize = queue.count
            var levelVal :[Int] = []
            for i in 0..<levelSize {
                let t = queue[i]
                levelVal.append(t.val)
                if t.left != nil {
                    queue.append(t.left!)                
                }
                if t.right != nil {
                    queue.append(t.right!)
                }
            }
            queue.removeSubrange(0..<levelSize)
            res.append(levelVal)
        }
        return res
    }
}
