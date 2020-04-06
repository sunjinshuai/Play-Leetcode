# 两数之和

给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。

你可以假设每个输入只对应一种答案，且同样的元素不能被重复利用。

```
给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
```

解题技巧一、暴力法
两次 for 循环，遍历相邻两个数字之和是否与 target 相等；

```
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
复杂度分析：

时间复杂度：O(n^2)
空间复杂度：O(1)

解题技巧一、一遍哈希表
一次 for 循环，将数组里面的数字插入到 hashMap 中，然后 target - num[i] 的差值，检查 hashMap 中是否存在对应的数值，如果存在，将其返回。

```
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
复杂度分析：

时间复杂度：O(n)
空间复杂度：O(1)
