/*
 输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。

 示例1：
 输入：1->2->4, 1->3->4
 输出：1->1->2->3->4->4
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
      self.val = val
      self.next = nil
    }
}

class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {return l2}
        if l2 == nil {return l1}
        var a:ListNode? = l1, b:ListNode? = l2
        let dum = ListNode.init(0)
        var cur: ListNode = dum
        while true {
            if a!.val < b!.val {
                cur.next = a
                cur = a!
                a = a!.next
            } else {
                cur.next = b
                cur = b!
                b = b!.next
            }
            if (a == nil || b == nil) {
                break
            }
        }
        if (a == nil) {
            cur.next = b
        } else if (b == nil) {
            cur.next = a
        }
        return dum.next
    }
}


Solution().mergeTwoLists(nil, nil)
