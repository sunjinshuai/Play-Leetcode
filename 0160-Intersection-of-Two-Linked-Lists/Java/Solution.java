import java.util.HashSet;
import java.util.Set;

public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if (headA == null || headB == null) {
            return null;
        }

        Set<ListNode> visited = new HashSet<>();
        ListNode current = headA;
        while (current != null) {
            visited.add(current);
            current = current.next;
        }

        current = headB;
        while (current != null) {
            if (visited.contains(current)) {
                return current;
            }
            current = current.next;
        }

        return null;
    }
}
