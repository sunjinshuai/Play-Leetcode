import java.util.HashSet;
import java.util.Set;

public class Solution {
    public ListNode detectCycle(ListNode head) {
        Set<ListNode> seen = new HashSet<ListNode>();
        while (head != null) {
            if (seen.contains(head)) {
                return head;
            } else {
                seen.add(head);
            }
            head = head.next;
        }
        return null;
    }
}
