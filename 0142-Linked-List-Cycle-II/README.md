# 142. 环形链表 II

给定单链表的头节点 `head`，返回环的入口节点；如果没有环，返回 `null`。不能修改链表。

[力扣题目](https://leetcode.cn/problems/linked-list-cycle-ii/) · [Java 源码](Java/Solution.java)

题目中的 `pos` 表示链表尾部连接到的节点索引，仅用于描述测试数据，不会传给 `detectCycle`。方法返回节点对象，而不是节点值或索引。

## 哈希集合

沿着 `next` 向后走，用集合记录已经访问过的节点：

1. 当前节点不在集合里：加入集合，继续向后走。
2. 当前节点已经在集合里：返回这个节点，它就是环的入口。
3. 走到 `null`：说明没有环，返回 `null`。

### 为什么第一次重复的节点就是入口？

进入环之前，路径上的节点不会重复。进入环后，沿着 `next` 绕一圈，最先再次遇到的就是入口节点。

```text
3 → 2 → 0 → -4
    ↑         │
    └─────────┘
```

访问顺序是 `3 → 2 → 0 → -4 → 2 → …`：

| 当前节点 | 是否已经访问 | 操作 |
| --- | --- | --- |
| 3 | 否 | 加入集合 |
| 2 | 否 | 加入集合 |
| 0 | 否 | 加入集合 |
| -4 | 否 | 加入集合 |
| 2（同一个节点） | 是 | 返回该节点 |

## Java 实现

源码使用力扣提供的 `ListNode`，其成员为 `int val` 和 `ListNode next`。

```java
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
```

### 比较节点身份，不比较值

题目提供的 `ListNode` 没有重写 `equals` 和 `hashCode`，因此 `HashSet<ListNode>` 按对象身份判断是否为同一个节点。两个不同节点即使 `val` 相同，也不能判定有环，不能改用 `Set<Integer>` 保存节点值。

### 移动 head 不会修改链表

`head = head.next` 只改变方法内局部变量指向的节点，没有修改任何节点的 `next`，也不会改变调用方变量指向的节点。

## 边界情况

- 空链表：不进入循环，返回 `null`。
- 单节点且无环：访问一次后到达 `null`，返回 `null`。
- 单节点指向自身：第二次访问时返回该节点。
- 环入口就是头节点：绕环一圈后返回头节点。
- 多个节点值相同但无环：仍返回 `null`。

## 复杂度

设从头节点能够到达的不同节点数为 `n`。

- 时间复杂度：`O(n)`，按哈希集合插入和查询平均 `O(1)` 计算。
- 额外空间复杂度：`O(n)`，集合保存已访问节点的引用，不复制节点。

本解法使用额外集合；题目的 `O(1)` 额外空间进阶要求可以通过快慢指针解决，本文先记录集合解法。
