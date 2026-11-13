# 19. 删除链表的倒数第 N 个结点

给定一个单链表的头节点 `head`，删除倒数第 `n` 个节点，返回删除后的头节点。题目保证链表非空，且 `1 <= n <= 链表长度`。

[力扣题目](https://leetcode.cn/problems/remove-nth-node-from-end-of-list/) · [Java 源码](Java/Solution.java)

## 双指针：保持固定间距

删除单链表中的节点，需要找到它的前一个节点，再让前一个节点的 `next` 跳过它。

1. 创建虚拟头节点 `dummy`，令 `dummy.next = head`。这样头节点也有前驱，删除头节点无需特殊分支。
2. `slow` 和 `fast` 都从 `dummy` 出发，让 `fast` 先走 `n` 步。
3. 两个指针每次各走一步，保持 `n` 步间距，直到 `fast` 到达最后一个节点。
4. 此时 `slow` 就在待删除节点之前，执行 `slow.next = slow.next.next`。
5. 返回 `dummy.next`。

这里的两个指针在共同移动阶段速度相同，依靠的是固定间距。

## 为什么先走 n 步，slow 就停在目标前面？

倒数第 `n` 个节点，距离最后一个节点只有 `n - 1` 步，因为倒数计数包含尾节点自己。

而 `fast` 先走 `n` 步后，两者再一起移动，`slow` 始终落后 `fast` 恰好 `n` 步。因此当 `fast` 到达尾节点时，`slow` 比目标多往前退一步，正好位于目标的前一个节点。

例如 `head = [1, 2, 3, 4, 5]`、`n = 2`，目标是节点 `4`：

```text
dummy → 1 → 2 → 3 → 4 → 5 → null
```

| 阶段 | slow | fast | 两者间距 |
| --- | --- | --- | --- |
| 都从 dummy 出发 | dummy | dummy | 0 步 |
| fast 先走 2 步 | dummy | 2 | 2 步 |
| 一起走一步 | 1 | 3 | 2 步 |
| 一起走一步 | 2 | 4 | 2 步 |
| 一起走一步 | 3 | 5 | 2 步 |

从尾节点 `5` 往前走 1 步是目标 `4`，往前走 2 步是目标的前驱 `3`。

执行删除操作后：

```text
slow.next = slow.next.next;

原来：3 → 4 → 5
之后：3 ───→ 5
```

也可以用位置验证：把 `dummy` 记为位置 `0`，长度为 `L` 的链表尾节点在位置 `L`。停止时 `slow` 在位置 `L - n`，其后继在位置 `L - n + 1`，恰好是倒数第 `n` 个节点。

### 停止条件不能混淆

本实现让 `fast` 先走 `n` 步，然后使用 `while (fast.next != null)`，让它停在最后一个节点。

如果保持先走 `n` 步，却改成 `while (fast != null)`，两个指针会多走一步，`slow` 就会落在目标节点上，而不是目标的前面。

## 为什么返回 dummy.next，而不是 head？

因为删除的可能是头节点。改变节点的 `next` 字段，不会自动改变 `head` 变量保存的引用。

例如 `head = [1, 2, 3]`、`n = 3`，需要删除节点 `1`：

```text
删除前：
dummy → 1 → 2 → 3 → null
        ↑
       head
```

`fast` 先走 3 步到达尾节点 `3`，`slow` 仍在 `dummy`，无需进入循环。此时：

```java
slow.next = slow.next.next;
// slow 就是 dummy，因此相当于 dummy.next = head.next;
```

删除后，两个引用分别指向：

```text
dummy.next → 2 → 3 → null
head       → 1 → 2 → 3 → null
```

`head` 仍指向原来的节点 `1`，返回它会把已删除节点重新作为链表起点。`dummy.next` 则指向正确的新头节点 `2`。

如果删除的不是头节点，`dummy.next` 仍指向原来的头节点。因此统一返回 `dummy.next`，两种情况都正确。

## Java 实现

使用力扣提供的 `ListNode`，直接修改原链表的连接关系。

```java
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;

        ListNode slow = dummy;
        ListNode fast = dummy;

        for (int i = 0; i < n; i++) {
            fast = fast.next;
        }

        while (fast.next != null) {
            slow = slow.next;
            fast = fast.next;
        }

        slow.next = slow.next.next;
        return dummy.next;
    }
}
```

## 边界情况

| 输入链表 | n | 输出 | 说明 |
| --- | --- | --- | --- |
| `[1, 2, 3, 4, 5]` | 2 | `[1, 2, 3, 5]` | 删除中间节点 |
| `[1, 2, 3]` | 3 | `[2, 3]` | 删除头节点，slow 停在 dummy |
| `[1, 2]` | 1 | `[1]` | 删除尾节点，前驱的 next 变成 null |
| `[1]` | 1 | `[]` | 唯一节点被删除，dummy.next 变成 null |

## 复杂度

设链表长度为 `L`。

- 时间复杂度：`O(L)`。fast 一趟向前扫描，无需预先计算链表长度。
- 额外空间复杂度：`O(1)`。只使用一个虚拟头节点和两个指针。
