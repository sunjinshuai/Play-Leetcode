# 1. 两数之和

## 题目描述

给定整数数组 `nums` 和目标值 `target`，返回两个数之和等于目标值的元素下标。

你可以假设每个输入只对应一种答案，且同样的元素不能被重复利用。

## 示例

```text
给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
```

## 解题思路

### 方法一：枚举

用两层循环枚举下标不同的元素对，找到和为 `target` 的一对。

```java
public int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return new int[]{i, j};
            }
        }
    }
    return new int[]{};
}
```

- 时间复杂度 `O(n²)`
- 额外空间复杂度 `O(1)`

### 方法二：哈希表

遍历数组时，先查找 `target - nums[i]` 是否已在哈希表中。找到时返回两个下标，否则记录当前值和下标。

```java
public static int[] twoSum(int[] nums, int target) {
    HashMap<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        int j = target - nums[i];
        if (map.containsKey(j)) {
            return new int[]{map.get(j), i};
        }
        map.put(nums[i], i);
    }
    return new int[]{};
}
```

- 平均时间复杂度 `O(n)`
- 额外空间复杂度 `O(n)`

## 源码

[Java](Java/Main.java)

`Main.java` 使用与上文相同的哈希表解法，查找范围包含数组末项。对于 `nums = [2, 7]`、`target = 9`，扫描到 `7` 时会找到已记录的 `2`，返回下标 `[0, 1]`。
