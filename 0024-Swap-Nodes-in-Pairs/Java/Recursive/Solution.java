/** 使用力扣提供的 ListNode，递归交换相邻节点。 */
public class Solution {
    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode second = head.next;
        ListNode swappedRest = swapPairs(second.next);
        head.next = swappedRest;
        second.next = head;
        return second;
    }
}
