class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var values: [Int] = []
        var current = head

        while let node = current {
            values.append(node.val)
            current = node.next
        }

        var left = 0
        var right = values.count - 1

        while left < right {
            if values[left] != values[right] {
                return false
            }

            left += 1
            right -= 1
        }

        return true
    }
}
