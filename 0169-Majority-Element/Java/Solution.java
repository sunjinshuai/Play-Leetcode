class Solution {
    public int majorityElement(int[] nums) {
        int candidate = 0;
        int count = 0;
        for (int num : nums) {
            if (count == 0) {
                candidate = num;
            }
            count += num == candidate ? 1 : -1;
        }
        return candidate;
    }

    public int majorityElementByBits(int[] nums) {
        int result = 0;
        for (int bit = 0; bit < 32; bit++) {
            int ones = 0;
            for (int num : nums) {
                ones += (num >>> bit) & 1;
            }
            if (ones > nums.length / 2) {
                result |= 1 << bit;
            }
        }
        return result;
    }
}
