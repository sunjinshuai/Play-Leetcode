# 155. 最小栈

[力扣题目](https://leetcode.cn/problems/min-stack/) · [参考：官方题解](https://leetcode.cn/problems/min-stack/solutions/242190/zui-xiao-zhan-by-leetcode-solution/) · [Java 源码](Java/MinStack.java)

实现一个栈，支持入栈 `push(val)`、删除栈顶 `pop()`、读取栈顶 `top()` 和读取最小值 `getMin()`，每个操作的时间复杂度都要求为 `O(1)`。

题目保证 `pop`、`top` 和 `getMin` 只在非空栈上调用；元素可以是任意 Java `int` 值。

## 思路：用辅助栈保存每一层的最小值

只用一个变量记录最小值还不够。例如依次压入 `5、2、1`，弹出 `1` 后，必须知道之前的最小值是 `2`。重新遍历栈会让弹栈操作变成 `O(n)`。

因此使用两个栈：

- `stack` 保存实际压入的元素。
- `minStack` 保存每一层对应的最小值，即从栈底到这一层所有元素的最小值。

入栈时，比较新元素与上一层最小值，把较小者压入辅助栈；出栈时，两边一起弹出。这样删除当前层后，辅助栈顶自然恢复为上一层的最小值。

## Java 实现

```java
import java.util.Deque;
import java.util.LinkedList;

class MinStack {
    private final Deque<Integer> stack = new LinkedList<>();
    private final Deque<Integer> minStack = new LinkedList<>();

    public MinStack() {
        minStack.push(Integer.MAX_VALUE);
    }

    public void push(int val) {
        stack.push(val);
        minStack.push(Math.min(val, minStack.peek()));
    }

    public void pop() {
        stack.pop();
        minStack.pop();
    }

    public int top() {
        return stack.peek();
    }

    public int getMin() {
        return minStack.peek();
    }
}
```

这里使用 `Deque` 表达栈操作，底层用 `LinkedList`，只操作链表头部，不需要遍历。

## push 和 pop 逐步拆解

### 压入 4 时，为什么辅助栈新增的是 2？

假设已经依次压入 `5、2`，下面从左到右表示栈底到栈顶：

```text
数据栈：[5, 2]
辅助栈：[MAX, 5, 2]
```

执行 `push(4)` 时，数据栈直接压入 `4`；辅助栈的操作可以拆开理解：

```java
int previousMin = minStack.peek();        // 上一层最小值为 2
int currentMin = Math.min(4, previousMin); // 新元素是 4，最小值仍为 2
minStack.push(currentMin);                // 新增一个 2
```

执行后：

```text
数据栈：[5, 2, 4]
辅助栈：[MAX, 5, 2, 2]
```

**这里没有替换任何元素。** 数据栈新增 `4`，辅助栈新增 `2`。新记录的含义是：当数据栈包含 `[5, 2, 4]` 时，最小值为 `2`。

接着压入 `1`，因为 `Math.min(1, 2) = 1`，两个栈各新增一个 `1`：

```text
数据栈：[5, 2, 4, 1]
辅助栈：[MAX, 5, 2, 2, 1]
```

### 弹栈如何恢复之前的最小值？

两个栈同步弹出一层：

```text
第一次 pop：
数据栈弹出 1 → [5, 2, 4]
辅助栈弹出 1 → [MAX, 5, 2, 2]
当前最小值恢复为 2。

第二次 pop：
数据栈弹出 4 → [5, 2]
辅助栈弹出 2 → [MAX, 5, 2]
当前最小值仍然为 2。
```

两个栈弹出的值不一定相等，它们对应的是同一层：一个保存实际元素，另一个保存压入该元素后的最小值。删除这一层后，上一层的记录自然成为栈顶，无需重新遍历。

## 操作过程

下面均从左到右表示栈底到栈顶，`MAX` 表示初始化时压入的 `Integer.MAX_VALUE` 哨兵。

| 操作 | 数据栈 | 辅助栈 | 返回值 |
| --- | --- | --- | --- |
| 初始化 | `[]` | `[MAX]` | — |
| `push(-2)` | `[-2]` | `[MAX,-2]` | — |
| `push(0)` | `[-2,0]` | `[MAX,-2,-2]` | — |
| `push(-3)` | `[-2,0,-3]` | `[MAX,-2,-2,-3]` | — |
| `getMin()` | `[-2,0,-3]` | `[MAX,-2,-2,-3]` | `-3` |
| `pop()` | `[-2,0]` | `[MAX,-2,-2]` | — |
| `top()` | `[-2,0]` | `[MAX,-2,-2]` | `0` |
| `getMin()` | `[-2,0]` | `[MAX,-2,-2]` | `-2` |

注意：压入 `0` 时，辅助栈压入的是 `-2`。它记录的是当前这一层的最小值，不是当前元素本身。

## 关键细节

### 为什么初始化时放入 Integer.MAX_VALUE？

`Integer.MAX_VALUE` 是 Java `int` 的最大值 `2147483647`。因为后续使用 `Math.min` 取较小值，初始值放最大值才能保证第一次压入任意合法整数，得到的都是该整数本身。

```java
Math.min(5, Integer.MAX_VALUE);  // 5
Math.min(-3, Integer.MAX_VALUE); // -3
```

如果初始值放 `0`，第一次压入 `5` 时，`Math.min(5, 0)` 会得到 `0`，但数据栈里根本没有 `0`，结果就错了。放最小整数同样不行，它会一直被选为最小值。

这个初始元素称为哨兵。它使第一次入栈也能直接计算 `Math.min(val, minStack.peek())`，无需额外判断辅助栈是否为空。任意合法 `int` 都不会大于它。

辅助栈始终比数据栈多一个元素。所有真实元素弹出后，哨兵仍然保留，下一次入栈可以继续使用同一套逻辑。若真实元素恰好也是 `Integer.MAX_VALUE`，它会再占一层，弹出时不会误删底部哨兵。

哨兵只是简化实现，不代表空栈的最小值有定义；调用者仍须遵守非空调用约定。

也可以不放哨兵，但需要同时修改构造方法与入栈逻辑。下面是替代写法，其他方法不变：

```java
public MinStack() {
    // 不放哨兵，两个栈都从空栈开始。
}

public void push(int val) {
    stack.push(val);
    if (minStack.isEmpty()) {
        minStack.push(val);
    } else {
        minStack.push(Math.min(val, minStack.peek()));
    }
}
```

两种写法都正确；正文源码选择哨兵方式，省去每次入栈时的空栈判断。

### 为什么每次 push 都要更新两个栈？

两个栈的真实层必须一一对应，即使最小值没有变化，也要保存这一层的记录。例如：

```text
数据栈：[5, 2, 2]
辅助栈：[MAX, 5, 2, 2]

弹出一个 2 后：
数据栈：[5, 2]
辅助栈：[MAX, 5, 2]
```

剩余的 `2` 仍然是最小值。重复最小值不需要特殊判断，因为每一层都有自己的记录。

### pop、peek 有什么区别？

`peek()` 表示查看栈顶元素，但不删除它；`pop()` 则删除并返回栈顶元素。

例如从同一个初始状态 `[5, 2, 4]` 出发，最右侧的 `4` 为栈顶：

| 调用 | 返回值 | 调用后的栈 |
| --- | --- | --- |
| `stack.peek()` | `4` | `[5, 2, 4]` |
| `stack.pop()` | `4` | `[5, 2]` |

因此 `stack.peek()` 读取实际栈顶，`minStack.peek()` 读取当前最小值。`top()` 和 `getMin()` 都不能改变栈，所以使用 `peek()`。

当前实现使用 `Deque<Integer>`，空栈调用 `peek()` 返回 `null`；如果将它作为 `int` 返回，自动拆箱会触发空指针异常。题目保证查询时数据栈非空。辅助栈的哨兵也不代表可以在空数据栈上调用 `getMin()`。

### 能否只在最小值变化时压入辅助栈？

可以，但必须同时改变出栈规则：入栈值 **小于等于** 当前最小值时才压入辅助栈；弹出的数据等于辅助栈顶时才弹出辅助栈。不能与本实现的“每次同步弹出”混用。

等于也要保存，否则连续压入两个最小值后，弹出一个就会丢失另一个的最小值记录。比较两个 `Integer` 对象时应比较数值，避免用 `==` 判断对象引用。

## 复杂度

- `push`、`pop`、`top`、`getMin`：时间复杂度均为 `O(1)`，只执行固定次数的链表头部操作与数值比较。
- 空间复杂度：`O(n)`，两个栈各保存与当前元素数量成正比的记录。
