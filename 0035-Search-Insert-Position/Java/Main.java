public class Main {
    public static void main(String[] args) {
        int[] nums = {1, 3};
        System.out.print(searchInsert(nums, 3));
    }

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
}
