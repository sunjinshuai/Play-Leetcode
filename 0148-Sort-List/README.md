# 148. 排序链表

给定链表的头节点 `head`，将链表按节点值升序排列，返回排序后的链表。

[力扣题目](https://leetcode.cn/problems/sort-list/) · [Java 源码](Java/Solution.java)

## 使用 Java List 排序

可以先取出所有节点的值进行排序，再写回原链表。题目的基本要求允许这种做法；它需要 `O(n)` 额外空间，不满足进阶的常数空间要求。

1. 使用 `ArrayList<Integer>` 收集节点值，无需提前统计链表长度。
2. 使用 `Collections.sort(values)` 将值按升序排列。
3. 从头遍历原链表，把排序后的值依次写回节点。
4. 返回保留下来的头节点 `head`。

```text
原链表：4 → 2 → 1 → 3
收集值：[4, 2, 1, 3]
排序后：[1, 2, 3, 4]
写回后：1 → 2 → 3 → 4
```

这个过程不创建新的链表节点，也不修改 `next`，只修改原节点的 `val`。源码使用力扣提供的 `ListNode` 定义。

## Java 实现

```java
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
```

## 为什么不能直接移动 head？

如果用 `head` 收集节点值：

```java
while (head != null) {
    values.add(head.val);
    head = head.next;
}
```

循环结束时，`head` 已经是 `null`。对于非空链表，接着执行 `head.val = value` 就会抛出 `NullPointerException`。即使在写回之前恢复了头节点，写回时再次移动 `head`，最后仍会返回 `null`。

因此需要保留 `head`，使用 `current` 遍历；开始写回之前，再执行一次 `current = head`。

`ListNode current = head` 不会复制链表，只是让两个变量指向同一个节点：

- `current = current.next` 改变的是 `current` 的指向，`head` 仍指向头节点。
- `current.val = value` 修改的是节点本身的值，从 `head` 出发也能看到修改。

## 边界情况

- 空链表：集合为空，两次遍历均跳过，返回 `null`。
- 单节点：排序后值不变，返回原节点。
- 重复值或负数：按整数的自然顺序排序，重复值保留。

## 复杂度与进阶

设链表有 `n` 个节点。

- 时间复杂度：`O(n log n)`，收集和写回分别为 `O(n)`，排序为 `O(n log n)`。
- 额外空间复杂度：`O(n)`，用于保存节点值及排序所需的辅助空间。

若要满足 `O(n log n)` 时间和 `O(1)` 额外空间的进阶要求，可以使用自底向上的迭代归并排序。递归归并排序通常需要 `O(log n)` 的调用栈空间，不能算作严格的常数额外空间。
