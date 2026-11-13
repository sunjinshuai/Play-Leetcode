import java.util.HashMap;

public class LRUCache {

    private class ListNode {
        int key;
        int value;
        ListNode pre;
        ListNode next;

        ListNode(int key, int value, ListNode pre, ListNode next) {
            this.key = key;
            this.value = value;
            this.pre = pre;
            this.next = next;
        }
    }

    private final ListNode head = new ListNode(-1, -1, null, null);
    private final ListNode tail = new ListNode(-1, -1, null, null);
    private final HashMap<Integer, ListNode> map = new HashMap<>();
    private final int capacity;

    public LRUCache(int capacity) {
        this.capacity = capacity;
        head.next = tail;
        tail.pre = head;
    }

    private void addToHead(ListNode node) {
        // 先保存原来的第一个节点，避免修改 head.next 后丢失插入位置。
        ListNode first = head.next;
        node.pre = head;
        node.next = first;
        first.pre = node;
        head.next = node;
    }

    private void removeNode(ListNode node) {
        ListNode prev = node.pre;
        ListNode next = node.next;
        prev.next = next;
        next.pre = prev;
    }

    public int get(int key) {
        ListNode node = map.get(key);
        if (node == null) {
            return -1;
        }

        removeNode(node);
        addToHead(node);
        return node.value;
    }

    public void put(int key, int value) {
        ListNode node = map.get(key);
        if (node != null) {
            node.value = value;
            removeNode(node);
            addToHead(node);
            return;
        }

        node = new ListNode(key, value, null, null);
        addToHead(node);
        map.put(key, node);

        if (map.size() > capacity) {
            ListNode oldest = tail.pre;
            removeNode(oldest);
            map.remove(oldest.key);
        }
    }
}
