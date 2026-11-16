/** 使用力扣提供的 ListNode，迭代交换相邻节点。 */
public class Solution {
    public ListNode swapPairs(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode cur = dummy;

        while (cur.next != null && cur.next.next != null) {
            ListNode first = cur.next;
            ListNode second = first.next;

            first.next = second.next;
            second.next = first;
            cur.next = second;

            // 原来的第一个节点成为组尾，也是下一组的前驱。
            cur = first;
        }

        return dummy.next;
    }
}
