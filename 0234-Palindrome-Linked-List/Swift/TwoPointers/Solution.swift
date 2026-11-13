class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard let head = head, head.next != nil else {
            return true
        }

        // 奇数长度停在中点，偶数长度停在前一个中间节点。
        var slow: ListNode? = head
        var fast: ListNode? = head

        while fast?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }

        let reversedHead = reverseList(slow?.next)
        var left: ListNode? = head
        var right = reversedHead
        var result = true

        while let node = right {
            if left?.val != node.val {
                // 不能提前返回，非回文链表也需要恢复。
                result = false
                break
            }

            left = left?.next
            right = node.next
        }

        slow?.next = reverseList(reversedHead)
        return result
    }

    private func reverseList(_ head: ListNode?) -> ListNode? {
        var previous: ListNode? = nil
        var current = head

        while let node = current {
            let next = node.next
            node.next = previous
            previous = node
            current = next
        }

        return previous
    }
}
