# 704. 二分查找

在元素互不重复的升序整数数组 `nums` 中查找 `target`。存在时返回下标，不存在时返回 `-1`，要求时间复杂度为 `O(log n)`。

[力扣题目](https://leetcode.cn/problems/binary-search/) · [Java 源码](Java/Solution.java)

## 示例

| nums | target | 返回值 |
| --- | --- | --- |
| `[-1,0,3,5,9,12]` | `9` | `4` |
| `[-1,0,3,5,9,12]` | `2` | `-1` |
| `[5]` | `5` | `0` |
| `[5]` | `2` | `-1` |

## 左闭右闭区间

这份实现维护的待查找范围是 **`[left, right]`，左右两端都包含在内**。如果目标存在且尚未找到，它一定在这个区间里。

| 位置 | 写法 | 含义 |
| --- | --- | --- |
| 初始化 | `left = 0`，`right = nums.length - 1` | 包含数组首尾元素 |
| 循环条件 | `left <= right` | 两端重合时还有一个元素需要检查 |
| 目标大于中点值 | `left = mid + 1` | 升序数组中，`mid` 及其左侧都不可能是目标 |
| 目标小于中点值 | `right = mid - 1` | 升序数组中，`mid` 及其右侧都不可能是目标 |
| 目标等于中点值 | `return mid` | 找到目标，返回下标 |

每次未命中都排除已经检查过的 `mid`，使待查找区间严格缩小。循环结束时 `left > right`，区间为空，因此返回 `-1`。

## Java 实现

```java
public class Solution {
    public int search(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (target > nums[mid]) {
                left = mid + 1;
            } else if (target < nums[mid]) {
                right = mid - 1;
            } else {
                return mid;
            }
        }

        return -1;
    }
}
```

`mid` 只在当前循环内使用，因此在循环内声明。`left + (right - left) / 2` 避免 `left + right` 可能产生的整数溢出；原写法 `(left + right) / 2` 在本题数组长度最多为 `10000` 的约束下也正确。

## 查找过程

以 `nums = [-1,0,3,5,9,12]`、`target = 9` 为例：

| 轮次 | left | right | mid | nums[mid] | 操作 |
| --- | --- | --- | --- | --- | --- |
| 1 | 0 | 5 | 2 | 3 | `9 > 3`，令 `left = 3` |
| 2 | 3 | 5 | 4 | 9 | 命中，返回 `4` |

## 边界为什么这样写？

### 为什么循环条件不能直接改成 left < right？

闭区间中，`left == right` 表示还剩一个候选元素。例如 `nums = [5]`、`target = 5`，初始两端都为 `0`，仍需检查 `nums[0]`。如果直接改成 `<` 而不补充检查，就会漏掉这个元素。

### 为什么更新边界时要加一或减一？

进入更新分支时，已经确定 `nums[mid] != target`，所以应排除 `mid`。如果只写 `left = mid`，在区间只剩两个元素时，中点可能仍等于 `left`，导致区间不再缩小，陷入死循环。

### 左闭右闭和左闭右开可以混用吗？

不能直接混用。区间定义决定初始化、循环条件和边界更新：本实现的 `right` 是待查找范围内的有效下标，所以初始化为 `nums.length - 1`，并通过 `left <= right` 检查最后一个候选元素。改为 `[left, right)` 时，需要一起调整这些规则。

## 复杂度

- 时间复杂度：`O(log n)`，每次比较后待查找范围缩小约一半。
- 空间复杂度：`O(1)`，只使用固定数量的局部变量。
