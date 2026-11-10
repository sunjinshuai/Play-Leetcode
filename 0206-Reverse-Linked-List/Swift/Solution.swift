class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var cur = head
        var pre: ListNode? = nil

        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }

        return pre
    }
}
