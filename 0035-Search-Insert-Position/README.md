# 搜索插入位置

给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

你可以假设数组中无重复元素。

示例 1:
```
输入: [1,3,5,6], 5
输出: 2
```

示例 2:
```
输入: [1,3,5,6], 2
输出: 1
```

示例 3:
```
输入: [1,3,5,6], 7
输出: 4
```

示例 4:
```
输入: [1,3,5,6], 0
输出: 0
```

解题技巧一、暴力法

判断边界问题，遍历目标元素，比较相邻两个元素与 target 大小；

```
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
复杂度分析：

时间复杂度：O(n)
空间复杂度：O(1)

解题技巧一、二分法
