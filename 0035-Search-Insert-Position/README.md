# 35. 搜索插入位置

## 题目描述

给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

数组中的元素互不相同。题目要求时间复杂度为 `O(log n)`。

## 示例

### 示例 1

```text
输入: [1,3,5,6], 5
输出: 2
```

### 示例 2

```text
输入: [1,3,5,6], 2
输出: 1
```

### 示例 3

```text
输入: [1,3,5,6], 7
输出: 4
```

### 示例 4

```text
输入: [1,3,5,6], 0
输出: 0
```

## 解题思路

### 方法一：顺序扫描

仓库里的 Java 示例先处理首尾边界，再比较相邻元素以确定 `target` 所在的位置。

```java
public static int searchInsert(int[] nums, int target) {
    if (target < nums[0]) { // 小于数组第一个元素
        return 0;
    }

    if (target > nums[nums.length - 1]) { // 大于数组最后一个元素
        return nums.length;
    }

    if (target == nums[nums.length - 1]) { // 等于数组最后一个元素
        return nums.length - 1;
    }

    for (int i = 0; i < nums.length - 1; i++) {
        if (target == nums[i] && target < nums[i + 1]) {
            return i;
        } 
        if (target > nums[i] && target < nums[i + 1]) {
            return i + 1;
        }
    }
    return 0;
}
```

- 时间复杂度 `O(n)`
- 额外空间复杂度 `O(1)`

### 方法二：二分查找

在半开区间 `[left, right)` 内查找第一个大于等于 `target` 的下标。若中点值小于 `target`，将左边界移到中点后一位，否则将右边界移到中点。两端相遇时，左边界就是目标下标或插入位置。

- 时间复杂度 `O(log n)`
- 额外空间复杂度 `O(1)`

## 源码

[Java](Java/Main.java)
