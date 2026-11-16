import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Solution {
    public int[][] merge(int[][] intervals) {
        List<int[]> merged = new ArrayList<>();
        Arrays.sort(intervals, (x, y) -> Integer.compare(x[0], y[0]));

        int left = intervals[0][0];
        int right = intervals[0][1];

        for (int i = 0; i < intervals.length; i++) {
            if (intervals[i][0] > right) {
                merged.add(new int[]{left, right});
                left = intervals[i][0];
                right = intervals[i][1];
            } else {
                right = Math.max(right, intervals[i][1]);
            }
        }

        // 最后一段没有后续区间触发保存，需要在遍历结束后补入。
        merged.add(new int[]{left, right});
        return merged.toArray(new int[merged.size()][]);
    }
}
