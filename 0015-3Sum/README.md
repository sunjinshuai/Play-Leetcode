# 15. 三数之和

从整数数组中选三个不同下标，使这三个位置的值相加等于零。结果按值去重，每组数字只返回一次。[力扣原题](https://leetcode.cn/problems/3sum/)

## 哈希表解法

1. 外层循环固定下标 `i`，内层循环让 `j` 从 `i + 1` 往右扫描。
2. 把 `nums[i]` 和 `nums[j]` 加起来，再用目标值 `0` 减去这个和，得到还缺的数 `third`。
3. 用 `seen.contains(third)` 查找补数。每轮先查，再把 `nums[j]` 加入 `seen`，因此查到的数一定来自 `i` 和 `j` 之间的某个下标。换一个 `i` 时，从空的 `seen` 重新开始。
4. 找到一组后，把三个数从小到大排序，再存进 `result`。例如 `[-1, 1, 0]` 和 `[-1, 0, 1]` 排序后相同，结果集合只保留一份。

用 `[-1, 0, 1, 1]` 手动跑一遍。先固定 `i = 0`，所以 `nums[i] = -1`。表中的 `seen` 是本次查找前的内容。

| 下标 `j` | 当前位置的数 `nums[j]` | 两数的和 | 补数 `third` | `seen` | 查找结果 |
| --- | --- | --- | --- | --- | --- |
| 1 | 0 | -1 | 1 | 空集合 | 找不到 `1` |
| 2 | 1 | 0 | 0 | `{0}` | 找到 `0`，加入 `[-1, 0, 1]` |
| 3 | 1 | 0 | 0 | `{0, 1}` | 再次找到 `0`，相同的答案只保留一份 |

下一轮固定 `i = 1`，右边只有两个 `1`，凑不出零。最后返回 `[[-1, 0, 1]]`。

设数组长度为 `n`，不同答案有 `k` 组。哈希集合的查找和插入平均为常数时间，每次只排序三个数，因此总时间平均为 `O(n²)`。`seen` 最多占用 `O(n)` 空间，`result` 占用 `O(k)` 空间。

## Swift

```swift
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }

        var result = Set<[Int]>()

        for i in 0..<(nums.count - 2) {
            var seen = Set<Int>()

            for j in (i + 1)..<nums.count {
                let sum = nums[i] + nums[j]
                let third = 0 - sum

                if seen.contains(third) {
                    let triplet = [nums[i], nums[j], third].sorted()
                    result.insert(triplet)
                }

                seen.insert(nums[j])
            }
        }

        return Array(result)
    }
}
```

## Java

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        Set<List<Integer>> result = new HashSet<>();

        for (int i = 0; i < nums.length - 2; i++) {
            Set<Integer> seen = new HashSet<>();

            for (int j = i + 1; j < nums.length; j++) {
                int sum = nums[i] + nums[j];
                int third = 0 - sum;

                if (seen.contains(third)) {
                    List<Integer> triplet = Arrays.asList(nums[i], nums[j], third);
                    Collections.sort(triplet);
                    result.add(triplet);
                }

                seen.add(nums[j]);
            }
        }

        return new ArrayList<>(result);
    }
}
```
