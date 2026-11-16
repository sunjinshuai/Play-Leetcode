public class Solution {
    public int maxSubArray(int[] nums) {
        int result = nums[0];
        int count = 0;

        for (int i = 0; i < nums.length; i++) {
            count += nums[i];

            if (count > result) {
                result = count;
            }

            // 负数前缀只会降低后续子数组的和，因此从下一项重新开始。
            if (count < 0) {
                count = 0;
            }
        }
        return result;
    }
}
