/**
 * 使用力扣提供的 ListNode，原地修改输入链表。
 */
public class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode head1 = l1;
        ListNode head2 = l2;

        while (head1 != null) {
            if (head2 != null) {
                head1.val += head2.val;
                head2 = head2.next;
            }
            if (head1.next == null && head2 != null) {
                // l1 已到末尾，直接复用 l2 尚未处理的节点。
                head1.next = head2;
                break;
            }
            head1 = head1.next;
        }
        merge(l1);
        return l1;
    }

    public void merge(ListNode node) {
        while (node != null) {
            if (node.val >= 10) {
                node.val = node.val % 10;
                if (node.next == null) {
                    node.next = new ListNode(0);
                }
                node.next.val += 1;
            }
            node = node.next;
        }
    }
}
