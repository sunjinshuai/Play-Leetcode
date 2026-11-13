# 234. 回文链表

给定单链表的头节点 `head`，判断节点的值从前往后读与从后往前读是否相同。相同返回 `true`，否则返回 `false`。

[力扣题目](https://leetcode.cn/problems/palindrome-linked-list/) · [Swift 源码](Swift/Solution.swift)

## 示例

```text
输入：1 → 2 → 2 → 1 → nil
输出：true

输入：1 → 2 → nil
输出：false
```

## 转换成数组，再用双指针比较

单链表只能沿着 `next` 向后遍历，不能直接向前走，也不能通过下标访问节点。将节点的值依次放入数组后，就可以方便地比较首尾对应的值。

### 1. 将链表的值存入数组

从 `head` 开始遍历，每访问一个节点，就将它的 `val` 追加到数组中，再移动到 `next`。

```text
链表：1 → 2 → 2 → 1 → nil
数组：[1, 2, 2, 1]
```

Swift 中，`while let node = current` 在当前节点存在时解包并进入循环；当 `current` 为 `nil` 时，遍历结束。这里只读取节点，不改变原链表的连接。

### 2. 从两端向中间比较

设置 `left = 0`，`right = values.count - 1`。当 `left < right` 时：

- 如果 `values[left] != values[right]`，说明存在一对不对称的值，直接返回 `false`。
- 如果相同，让 `left += 1`、`right -= 1`，继续比较里面的一对。

```text
[1, 2, 2, 1]
 L        R    1 == 1，向中间移动

[1, 2, 2, 1]
    L  R       2 == 2，继续移动

[1, 2, 2, 1]
    R  L       指针交错，返回 true
```

循环开始时，两指针外侧的对应值都已经比较且相同。如果循环正常结束，所有需要比较的位置都已匹配，因此返回 `true`。

### 3. 为什么循环条件是 `left < right`

偶数长度的数组在比较完成后，两指针会交错。奇数长度的数组中，两指针最终会相遇，中间元素一定与自己相同，不需要再比较。

单节点链表直接返回 `true`。实现也兼容空链表：此时 `left` 为 `0`，`right` 为 `-1`，不会进入比较循环，也不会访问数组下标。

## Swift 实现

`ListNode` 使用力扣提供的定义，无需在提交代码中重复声明。

```swift
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var values: [Int] = []
        var current = head

        while let node = current {
            values.append(node.val)
            current = node.next
        }

        var left = 0
        var right = values.count - 1

        while left < right {
            if values[left] != values[right] {
                return false
            }

            left += 1
            right -= 1
        }

        return true
    }
}
```

## 复杂度

- 时间复杂度：`O(n)`。遍历链表需要 `O(n)`，比较数组最多进行 `n / 2` 次，总体仍是 `O(n)`。
- 额外空间复杂度：`O(n)`。数组保存了全部 `n` 个节点的值。

本篇记录数组解法。题目的 `O(1)` 额外空间进阶要求需要使用其他方法，例如找到中点后原地反转后半段，再比较两段。
