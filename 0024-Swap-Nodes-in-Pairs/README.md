# 24. 两两交换链表中的节点

给定单链表的头节点 `head`，将相邻节点两两交换，返回新头节点。只能改变节点的连接关系，不能修改节点值。奇数长度链表的最后一个节点保持不变。

[力扣题目](https://leetcode.cn/problems/swap-nodes-in-pairs/) · [Java 迭代源码](Java/Solution.java) · [Java 递归源码](Java/Recursive/Solution.java)

```text
输入：1 → 2 → 3 → 4 → 5 → null
输出：2 → 1 → 4 → 3 → 5 → null
```

## 迭代：每轮交换两个节点

用 `cur` 保存当前这一组的前驱，`first` 和 `second` 保存待交换的两个节点。`cur` 对应常见写法中的 `prev`。

```text
交换前：cur → first → second → rest
交换后：cur → second → first → rest
```

### dummy、cur 和 head 分别指向哪里？

```java
ListNode dummy = new ListNode(0);
dummy.next = head;
ListNode cur = dummy;
```

对于 `1 → 2 → 3 → 4 → 5`，执行后是：

```text
dummy ─┐
       ▼
      [0] → [1] → [2] → [3] → [4] → [5] → null
       ▲     ▲
cur ───┘    head
```

- `dummy` 和 `cur` 指向同一个虚拟头节点 `[0]`，不是节点 `[1]`。
- `dummy.next`、`cur.next` 和 `head` 都指向节点 `[1]`。
- 赋值复制的是引用，不会复制节点，也不会自动沿着 `next` 前进。
- 虚拟头节点的值没有业务含义；它让第一组也有前驱，统一第一组与后续组的处理。

下面两种初始化不同：

```java
ListNode cur = dummy;      // 指向虚拟头节点
// 或者：
ListNode cur = dummy.next; // 指向节点 1
```

如果执行 `cur = cur.next`，只会让 `cur` 移到下一个节点，`dummy` 仍留在原处。

```java
cur = first;       // 改变变量 cur 保存的引用，不改变链表连接
cur.next = second; // 修改 cur 所指节点的 next，改变链表连接
```

### Java 实现

使用力扣提供的 `ListNode`：

```java
class Solution {
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

            cur = first;
        }

        return dummy.next;
    }
}
```

### 第一轮：逐句交换 1 和 2

初始状态：

```text
dummy → 1 → 2 → 3 → 4 → 5 → null
  ↑     ↑   ↑
 cur  first second
```

**第一步：让 first 接住后面的链表。**

```java
first.next = second.next; // 1.next = 3
```

```text
dummy → 1 → 3 → 4 → 5 → null
            ↑
        2 ──┘
        ↑
      second
```

从 `dummy` 暂时访问不到节点 `2`，但 `second` 仍保存着它，所以节点没有丢失。

**第二步：让 second 指向 first。**

```java
second.next = first; // 2.next = 1
```

```text
dummy → 1 → 3 → 4 → 5 → null
        ↑
        2
        ↑
      second
```

此时 `2 → 1` 已连接好，但前面的入口仍指向 `1`。

**第三步：把前面的链表接到新的组头。**

```java
cur.next = second; // dummy.next = 2
```

```text
dummy → 2 → 1 → 3 → 4 → 5 → null
```

**第四步：移动到下一组的前驱。**

```java
cur = first; // cur 指向节点 1
```

交换之后，`first` 仍指向节点 `1`。它现在是本组末尾，也是下一组 `3、4` 的前驱。

```text
dummy → 2 → 1 → 3 → 4 → 5 → null
            ↑
           cur
```

不能改成 `cur = second`，否则下一轮会错误地选择 `1、3` 进行交换。

### 第二轮与循环结束

此时 `cur = 1`、`first = 3`、`second = 4`：

```java
first.next = second.next; // 3.next = 5
second.next = first;      // 4.next = 3
cur.next = second;        // 1.next = 4
cur = first;             // cur 移到 3
```

```text
dummy → 2 → 1 → 4 → 3 → 5 → null
                    ↑
                   cur
```

循环条件要求至少剩下两个节点：

```java
cur.next != null && cur.next.next != null
```

现在只剩节点 `5`，第二个条件为假，循环结束。若没有剩余节点，第一个条件为假。Java 的 `&&` 短路求值保证第一个条件为假时不会继续访问 `cur.next.next`。

### 为什么连接顺序不能随意修改？

如果先执行 `second.next = first`，原来的 `first.next` 仍指向 `second`，两个节点会暂时形成环。此时再执行 `first.next = second.next`，读到的已不是后续链表，而是 `first` 自己，最终导致自环。

当前写法先用 `first.next = second.next` 保存与后续链表的连接，再修改 `second.next`，避免覆盖仍需使用的信息。

### 为什么返回 dummy.next？

```text
dummy → 2 → 1 → 4 → 3 → 5 → null
        ↑   ↑
      新头  head
```

修改节点连接不会自动改变 `head` 保存的引用。它仍指向节点 `1`，返回它会漏掉节点 `2`。`dummy.next` 始终指向结果链表的头节点；空链表时它就是 `null`。

## 递归：先处理后面，再连接当前两个节点

### 明确函数的约定

`swapPairs(head)` 将以 `head` 为起点的链表两两交换，并返回处理后的新头节点。

```text
输入：first → second → rest
递归处理 rest，返回 swappedRest
连接：second → first → swappedRest
返回：second
```

返回的是节点引用，不是节点的数值。拿到新头节点，就可以沿 `next` 访问处理后的整段链表。

### Java 实现

```java
class Solution {
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
```

空链表或单节点不需要交换，直接原样返回。每次递归跳过两个节点，问题规模持续缩小，因此最终会到达终止条件。

### 向下调用：当前层暂停等待

以 `1 → 2 → 3 → 4 → 5` 为例：

```text
swapPairs(1)：保存 head = 1、second = 2，等待 swapPairs(3)
    swapPairs(3)：保存 head = 3、second = 4，等待 swapPairs(5)
        swapPairs(5)：只剩一个节点，直接返回节点 5
```

每层都有独立的局部变量。第二层的 `head = 3` 不会覆盖第一层的 `head = 1`，但这些引用指向的都是原链表中的节点，没有复制链表。

### 逐层返回：恢复执行并修改连接

第二层收到节点 `5` 后，继续执行：

```java
head.next = swappedRest; // 3.next = 5
second.next = head;      // 4.next = 3
return second;          // 返回节点 4
```

得到 `4 → 3 → 5 → null`，返回这一段的新头节点 `4`。

第一层收到节点 `4` 后，继续执行：

```java
head.next = swappedRest; // 1.next = 4
second.next = head;      // 2.next = 1
return second;          // 返回节点 2
```

最终得到 `2 → 1 → 4 → 3 → 5 → null`。

### 合并写法的执行顺序

这两句：

```java
ListNode swappedRest = swapPairs(second.next);
head.next = swappedRest;
```

可以写成：

```java
head.next = swapPairs(second.next);
```

含义是先以 `second.next` 调用递归，等待它返回，然后把返回的新头节点赋给当前层的 `head.next`。不是先修改 `head.next` 再递归。

## 边界情况

| 输入 | 输出 | 检查点 |
| --- | --- | --- |
| `[]` | `[]` | 空链表直接结束 |
| `[1]` | `[1]` | 单节点保持不变 |
| `[1, 2]` | `[2, 1]` | 新头节点改变 |
| `[1, 2, 3]` | `[2, 1, 3]` | 奇数长度的尾节点保留 |
| `[1, 2, 3, 4]` | `[2, 1, 4, 3]` | 多组之间正确连接 |
| `[1, 1, 2]` | `[1, 1, 2]` | 即使值相同，也要交换节点本身 |

## 复杂度与选择

设链表长度为 `n`。

| 解法 | 时间复杂度 | 额外空间复杂度 | 特点 |
| --- | --- | --- | --- |
| 迭代 | O(n) | O(1) | 用前驱连接每组结果，无递归栈 |
| 递归 | O(n) | O(n) | 约 n / 2 层调用，代码简洁 |

链表较长或要求常量额外空间时，优先使用迭代，避免递归栈深度限制。
