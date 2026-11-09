# 128. 最长连续序列

## 题意与示例

给定未排序的整数数组 `nums`，返回最长连续序列的长度。连续指相邻的数相差 `1`，这些数可以出现在原数组的任意位置。题目要求 `O(n)` 时间。[力扣原题](https://leetcode.cn/problems/longest-consecutive-sequence/)

| `nums` | 最长连续序列 | 长度 |
| --- | --- | --- |
| `[100, 4, 200, 1, 3, 2]` | `[1, 2, 3, 4]` | `4` |
| `[3, 8, 2, 1, 2]` | `[1, 2, 3]` | `3` |
| `[8]` | `[8]` | `1` |
| `[]` | `[]` | `0` |

## 哈希集合解法

排序后跳过重复值，就能逐段统计长度。比较排序需要 `O(n log n)` 时间。这里实际需要的是查询某个数是否存在，所以可以用哈希集合去重并查找。

1. 把 `nums` 的所有数字放进集合 `numbers`。
2. 遍历集合。对当前数字 `start`，如果 `start - 1` 在集合里，就执行 `continue`，跳到下一个候选数字。当前数字所在的连续段还能往左延伸，会在遍历到真正的起点时一起计算。
3. 如果 `start - 1` 不在集合里，就令 `end = start`。只要 `end + 1` 存在，就将 `end` 加 `1`。停下来时，`end` 指向这段最后一个存在的数。
4. 用 `end - start + 1` 算出这段的长度，并更新最大值 `longest`。起点和终点都算进去，即使找不到 `start + 1`，单个数字也算长度 `1`。

例如，`[3, 8, 2, 1, 2]` 去重后包含 `1、2、3、8`。表格按数值排列，实际遍历顺序由集合决定。

| 当前数字 | 检查前一个数 | 处理结果 |
| --- | --- | --- |
| `1` | `0` 不存在 | 从 `1` 向后查到 `2`、`3`，在 `4` 处停下，长度为 `3` |
| `2` | `1` 存在 | 跳过，所在的段从 `1` 开始 |
| `3` | `2` 存在 | 跳过，所在的段从 `1` 开始 |
| `8` | `7` 不存在 | 查不到 `9`，长度为 `1` |

## Java

```java
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int longestConsecutive(int[] nums) {
        Set<Integer> numbers = new HashSet<>();
        for (int num : nums) {
            numbers.add(num);
        }

        int longest = 0;
        for (int start : numbers) {
            if (numbers.contains(start - 1)) {
                continue;
            }

            int end = start;
            while (numbers.contains(end + 1)) {
                end++;
            }
            longest = Math.max(longest, end - start + 1);
        }
        return longest;
    }
}
```

## Swift

```swift
class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var numbers: Set<Int> = Set<Int>()
        for num in nums {
            numbers.insert(num)
        }

        var longest: Int = 0
        for start in numbers {
            if numbers.contains(start - 1) {
                continue
            }

            var end = start
            while numbers.contains(end + 1) {
                end += 1
            }
            longest = max(longest, end - start + 1)
        }
        return longest
    }
}
```

两种写法的控制流程相同。Java 用 `add` 添加元素、用 `Math.max` 更新最大长度，Swift 对应的是 `insert` 和 `max`。两者的 `contains` 都用来判断某个整数是否在集合里。

## 复杂度

设原数组长度为 `n`，去重后有 `m` 个不同的数字。建集合需要 `n` 次插入，遍历集合时需要 `m` 次前驱查询。对一段长度为 `k` 的序列，内层 `while` 会做 `k - 1` 次成功查询和 `1` 次失败查询。每段只从自己的起点进入 `while`，所以所有内层查询加起来恰好是 `m` 次。

按哈希操作平均 `O(1)` 计算，总时间复杂度为 `O(n)`，额外空间为 `O(m)`，最坏为 `O(n)`。
