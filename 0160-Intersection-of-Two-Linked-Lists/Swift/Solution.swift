class Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var visited = Set<ObjectIdentifier>()
        var current = headA

        while let node = current {
            visited.insert(ObjectIdentifier(node))
            current = node.next
        }

        current = headB

        while let node = current {
            if visited.contains(ObjectIdentifier(node)) {
                return node
            }
            current = node.next
        }

        return nil
    }
}
