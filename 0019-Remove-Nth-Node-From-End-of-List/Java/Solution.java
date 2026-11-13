/**
 * 使用力扣提供的 ListNode，原地删除倒数第 n 个节点。
 */
public class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;

        ListNode slow = dummy;
        ListNode fast = dummy;

        // 建立 n 步的固定间距。
        for (int i = 0; i < n; i++) {
            fast = fast.next;
        }

        // fast 停在尾节点时，slow 位于待删除节点之前。
        while (fast.next != null) {
            slow = slow.next;
            fast = fast.next;
        }

        slow.next = slow.next.next;
        return dummy.next;
    }
}
