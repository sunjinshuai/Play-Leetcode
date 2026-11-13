# 234. 回文链表

给定单链表的头节点 `head`，判断节点的值从前往后读与从后往前读是否相同。相同返回 `true`，否则返回 `false`。

[力扣题目](https://leetcode.cn/problems/palindrome-linked-list/) · [Swift 数组解法](Swift/Solution.swift) · [Swift 快慢指针解法](Swift/TwoPointers/Solution.swift)

## 示例

```text
输入：1 → 2 → 2 → 1 → nil
输出：true

输入：1 → 2 → nil
输出：false
```

## 解法一：转换成数组，再用双指针比较

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

### Swift 实现

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

### 复杂度

- 时间复杂度：`O(n)`。遍历链表需要 `O(n)`，比较数组最多进行 `n / 2` 次，总体仍是 `O(n)`。
- 额外空间复杂度：`O(n)`。数组保存了全部 `n` 个节点的值。

## 解法二：快慢指针与原地反转

不创建数组，而是找到后半段，将它原地反转后与前半段比较，最后恢复原链表。只使用固定数量的指针，额外空间为 `O(1)`。

### 1. 用快慢指针找中点

`slow` 和 `fast` 都从头节点出发，每轮分别走 1 步和 2 步。我们选择让 `slow` 在偶数长度时停在前一个中间节点，这样奇偶两种情况下都能用 `slow.next` 找到后半段起点。

```swift
var slow = head
var fast = head

while fast?.next != nil && fast?.next?.next != nil {
    slow = slow?.next
    fast = fast?.next?.next
}
```

循环条件表示：`fast` 后面至少还有两个节点，才能再移动两步。`?.` 是可选链，遇到 `nil` 时访问结果也是 `nil`。第二个条件成立就意味着第一个成立，因此也可以简写为 `fast?.next?.next != nil`。

下面的数字表示节点位置，不是节点值：

| 轮次 | 5 个节点时 slow / fast | 6 个节点时 slow / fast |
| --- | --- | --- |
| 初始 | 1 / 1 | 1 / 1 |
| 第一轮后 | 2 / 3 | 2 / 3 |
| 第二轮后 | 3 / 5 | 3 / 5 |

5 个节点时，`fast` 已到末尾，停止；6 个节点时，`fast.next` 是节点 6，但 `fast.next.next` 是 `nil`，同样停止。

```text
奇数长度：1 → 2 → 3 → 4 → 5
                  ↑   ↑
                 slow 后半段起点

偶数长度：1 → 2 → 3 → 4 → 5 → 6
                  ↑   ↑
                 slow 后半段起点
```

奇数长度跳过中间节点，偶数长度则将节点分成相等的两半。空链表和单节点链表在完整实现中直接返回 `true`。

### 2. 原地反转后半段

以节点值为 `1 → 2 → 3 → 2 → 1` 的链表为例，后半段是 `2 → 1 → nil`。

```swift
var previous: ListNode? = nil
var current = slow?.next

while let node = current {
    let next = node.next
    node.next = previous
    previous = node
    current = next
}
```

每轮有四步：保存后继、改变当前节点的指向、更新已反转部分的头节点、移动到原来的后继。必须先保存后继，否则修改 `next` 后会失去继续访问剩余节点的入口。

第一轮处理节点 `2`：

1. `next` 保存节点 `1`。
2. `2.next` 指向 `previous`，也就是 `nil`。
3. `previous` 移到节点 `2`。
4. `current` 移到保存的节点 `1`。

```text
previous → 2 → nil
current  → 1 → nil
```

第二轮处理节点 `1`：

1. `next` 保存 `nil`。
2. `1.next` 指向 `previous`，也就是节点 `2`。
3. `previous` 移到节点 `1`。
4. `current` 变成 `nil`，循环结束。

```text
previous → 1 → 2 → nil
```

只有 `node.next = previous` 修改节点连接，其余语句只是保存或移动引用。完整实现将反转操作提取为 `reverseList`，返回反转后的头节点，并用 `reversedHead` 保存它。

### 3. 比较前半段和反转后的后半段

`left` 从 `head` 出发，`right` 从 `reversedHead` 出发。两边每次比较一个值，再各走一步。

```text
第一轮：left 指向 1，right 指向 1，相同
第二轮：left 指向 2，right 指向 2，相同
随后：  left 指向 3，right 为 nil，比较结束
```

循环只检查 `right`，因为后半段的长度恰好是需要比较的对数。奇数长度的中间节点不用比较。

反转后，`slow.next` 仍指向原后半段的第一个节点，它现在是反转部分的尾节点。并没有创建两条独立链表，但比较只进行后半段的长度，因此不会影响判断。

```swift
var left = head
var right = reversedHead
var result = true

while let node = right {
    if left?.val != node.val {
        result = false
        break
    }

    left = left?.next
    right = node.next
}
```

发现不相等时，记录 `false` 并退出循环，不能直接返回，否则会跳过恢复操作。

### 4. 恢复原链表

将反转后的后半段再反转一次，就恢复了它原来的顺序，再将恢复后的头节点接回 `slow.next`。

```text
比较时：1 → 2 → nil
恢复后：2 → 1 → nil
接回后：1 → 2 → 3 → 2 → 1 → nil
```

```swift
slow?.next = reverseList(reversedHead)
return result
```

必须从保留的 `reversedHead` 开始恢复。`right` 在比较中不断移动，可能已经是 `nil`，也可能停在不匹配的位置，不能用它作为恢复入口。

无论结果是 `true` 还是 `false`，都先恢复，再返回；原有节点的值和连接关系都会保留。

### Swift 完整实现

两个解法文件都使用力扣要求的 `Solution` 类名，应分别提交或编译。`ListNode` 由力扣提供。

```swift
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard let head = head, head.next != nil else {
            return true
        }

        // 奇数长度停在中点，偶数长度停在前一个中间节点。
        var slow: ListNode? = head
        var fast: ListNode? = head

        while fast?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }

        let reversedHead = reverseList(slow?.next)
        var left: ListNode? = head
        var right = reversedHead
        var result = true

        while let node = right {
            if left?.val != node.val {
                // 不能提前返回，非回文链表也需要恢复。
                result = false
                break
            }

            left = left?.next
            right = node.next
        }

        slow?.next = reverseList(reversedHead)
        return result
    }

    private func reverseList(_ head: ListNode?) -> ListNode? {
        var previous: ListNode? = nil
        var current = head

        while let node = current {
            let next = node.next
            node.next = previous
            previous = node
            current = next
        }

        return previous
    }
}
```

### 复杂度

- 时间复杂度：`O(n)`。找中点、反转后半段、比较、恢复分别是线性操作，多次遍历相加仍为 `O(n)`。
- 额外空间复杂度：`O(1)`。仅使用固定数量的指针和结果变量；反转采用迭代，不使用递归调用栈。
