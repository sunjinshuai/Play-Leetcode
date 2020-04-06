import java.util.HashMap;

public class Main {

    public static int[] twoSum(int[] nums, int target) {
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length - 1; i++) {
            int j = target - nums[i];
            if (map.containsKey(j)) {
                return new int[]{map.get(j), i};
            }
            map.put(nums[i], i);
        }
        return new int[]{};
    }
}

