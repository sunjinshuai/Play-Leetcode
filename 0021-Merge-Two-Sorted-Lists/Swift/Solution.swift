class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard let first = list1 else { return list2 }
        guard let second = list2 else { return first }
        if first.val < second.val {
            first.next = mergeTwoLists(first.next, second)
            return first
        }

        second.next = mergeTwoLists(second.next, first)
        return second
    }
}
