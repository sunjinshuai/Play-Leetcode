# 160. 相交链表

给定两个无环单链表的头节点 `headA` 和 `headB`，返回它们相交的第一个节点；如果不相交，返回空。相交指两个链表共享同一个节点对象，而不是节点值相同。算法不能改变链表结构。

[力扣题目](https://leetcode.cn/problems/intersection-of-two-linked-lists/) · [Swift 源码](Swift/Solution.swift) · [Java 源码](Java/Solution.java)

## 哈希集合

1. 遍历链表 A，将每个节点的身份存入集合。
2. 从头遍历链表 B，返回第一个已在集合中的节点。
3. 遍历结束仍未找到，返回空。任一链表为空时也返回空。

两份源码均使用力扣提供的 `ListNode`，只读取节点及其后继，不修改链表。

### Swift 的对象身份与可选解包

力扣提供的 `ListNode` 没有遵循 `Hashable`，不能直接使用 `Set<ListNode>`。使用 `Set<ObjectIdentifier>` 保存节点的对象身份，可以区分值相同但实例不同的节点。

`current` 是 `ListNode?`，用 `while let node = current` 解包后，才能访问 `node.next` 并构造 `ObjectIdentifier(node)`。仅判断 `current != nil` 不会自动解包。

### Java 的节点比较

力扣提供的 `ListNode` 没有重写 `equals` 和 `hashCode`，因此 `HashSet<ListNode>` 按对象身份判断节点是否相同。不要改成保存节点的 `val`，否则不同节点可能因值相同而被误判为相交。

## 示例

```text
A: 4 → 1 ─────┐
              ├→ 8 → 4 → 5
B: 5 → 6 → 1 ─┘
```

两条链表共享从 `8` 开始的同一段节点，返回该 `8` 节点。交点前两个值为 `1` 的节点是不同对象，不构成交点。

如果 A 和 B 分别由独立的节点组成，即使都表示 `1 → 2 → 3`，也应返回空。

## 复杂度

设 A 长度为 `m`，B 长度为 `n`。

- 时间复杂度：`O(m + n)`，按哈希集合插入和查询平均 `O(1)` 计算。
- 额外空间复杂度：`O(m)`，集合保存 A 的全部节点引用或对象标识，不复制节点。

本解法使用额外集合；若要满足 `O(1)` 额外空间的进阶要求，可以使用双指针换头法。
