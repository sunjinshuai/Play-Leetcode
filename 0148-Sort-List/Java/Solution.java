import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Solution {
    public ListNode sortList(ListNode head) {
        List<Integer> values = new ArrayList<>();

        ListNode current = head;
        while (current != null) {
            values.add(current.val);
            current = current.next;
        }

        Collections.sort(values);

        current = head;
        for (int value : values) {
            current.val = value;
            current = current.next;
        }

        return head;
    }
}
