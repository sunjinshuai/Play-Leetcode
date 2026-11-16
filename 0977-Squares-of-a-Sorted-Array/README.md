# 977. 有序数组的平方

给定按非递减顺序排列的整数数组 `nums`，返回每个数字平方组成的数组，结果也必须按非递减顺序排列。

[力扣题目](https://leetcode.cn/problems/squares-of-a-sorted-array/) · [Java 源码](Java/Solution.java)

## 示例

| nums | 返回值 |
| --- | --- |
| `[-4,-1,0,3,10]` | `[0,1,9,16,100]` |
| `[-7,-3,2,3,11]` | `[4,9,9,49,121]` |
| `[-3,-2,-1]` | `[1,4,9]` |
| `[0]` | `[0]` |

## 方法一：先平方，再排序

原数组已经有序，但平方会改变负数之间以及负数与正数之间的大小关系。例如 `[-4,-1,0,3,10]` 平方后是 `[16,1,0,9,100]`，并不有序。因此，按数值先排序再平方不能保证结果有序，应该先平方再排序。

```java
import java.util.Arrays;

class Solution {
    public int[] sortedSquares(int[] nums) {
        for (int i = 0; i < nums.length; i++) {
            nums[i] = nums[i] * nums[i];
        }

        Arrays.sort(nums);
        return nums;
    }
}
```

平方遍历需要 `O(n)` 时间，排序通常按 `O(n log n)` 分析，总时间复杂度为 `O(n log n)`。这份实现直接修改并返回原数组，没有创建结果数组；排序的辅助空间取决于所用 JDK 的 `Arrays.sort(int[])` 实现，不应仅凭原地修改就认定总辅助空间一定为 `O(1)`。

## 方法二：双指针，从后往前填充

有序数组中，当前区间内绝对值最大的元素一定在两端，因此最大平方也一定来自两端之一。

1. `left` 指向最左侧，`right` 指向最右侧。
2. 比较两端的平方，把较大值放入结果数组当前最后一个空位 `result[index]`。
3. 移动取出元素那一侧的指针，并让 `index` 减一。
4. 重复直到所有元素都被处理。

每轮开始时，`[left, right]` 是尚未处理的区间，`result[index + 1 ... n - 1]` 已经按升序放好了最大的若干个平方。将剩余最大平方填到 `index`，就能继续保持这一性质。

### Java 实现

```java
public class Solution {
    public int[] sortedSquares(int[] nums) {
        int left = 0;
        int right = nums.length - 1;
        int[] result = new int[nums.length];
        int index = nums.length - 1;

        while (left <= right) {
            if (nums[left] * nums[left] > nums[right] * nums[right]) {
                result[index--] = nums[left] * nums[left];
                left++;
            } else {
                result[index--] = nums[right] * nums[right];
                right--;
            }
        }
        return result;
    }
}
```

### 填充过程

以 `nums = [-4,-1,0,3,10]` 为例，`_` 表示尚未填充的位置：

| 轮次 | 左端平方 | 右端平方 | 填入位置 | result |
| --- | --- | --- | --- | --- |
| 1 | 16 | 100 | 4 | `[_,_,_,_,100]` |
| 2 | 16 | 9 | 3 | `[_,_,_,16,100]` |
| 3 | 1 | 9 | 2 | `[_,_,9,16,100]` |
| 4 | 1 | 0 | 1 | `[_,1,9,16,100]` |
| 5 | 0 | 0 | 0 | `[0,1,9,16,100]` |

### 关键细节

- **为什么从后往前填？** 每次能直接确定的是剩余元素中的最大平方，它应该放在最后一个空位。
- **为什么是 `left <= right`？** 两个指针重合时还有最后一个元素要处理，使用 `<` 会漏掉它。
- **两端平方相等怎么办？** 取任意一端都可以。代码先取右端，另一端会在后续循环中处理，不会丢失重复值。
- **`result[index--]` 是什么意思？** 先使用当前 `index` 写入结果，再将 `index` 减一。
- **平方会溢出吗？** 本题 `-10000 <= nums[i] <= 10000`，最大平方为 `100000000`，在 Java `int` 范围内。
- **是否修改原数组？** 双指针实现只读取 `nums`，将平方写入新数组，不修改输入。

### 复杂度

- 时间复杂度：`O(n)`，每轮处理一个元素，总共处理 `n` 个元素。
- 空间复杂度：`O(n)`，用于结果数组；若不计返回结果，额外辅助空间为 `O(1)`。
