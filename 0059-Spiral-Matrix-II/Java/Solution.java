class Solution {
    public int[][] generateMatrix(int n) {
        int[][] nums = new int[n][n];
        int startX = 0;
        int startY = 0; // 每一圈左上角的起始位置
        int offset = 1;
        int count = 1;
        int loop = 1;
        int i = 0; // 行下标
        int j = 0; // 列下标

        while (loop <= n / 2) {
            // 顶边：左到右，不包含右上角
            for (j = startY; j < n - offset; j++) {
                nums[startX][j] = count++;
            }

            // 右边：上到下，不包含右下角
            for (i = startX; i < n - offset; i++) {
                nums[i][j] = count++;
            }

            // 底边：右到左，不包含左下角
            for (; j > startY; j--) {
                nums[i][j] = count++;
            }

            // 左边：下到上，不包含左上角
            for (; i > startX; i--) {
                nums[i][j] = count++;
            }

            startX++;
            startY++;
            offset++;
            loop++;
        }

        // 奇数阶矩阵剩下一个中心格
        if (n % 2 == 1) {
            nums[startX][startY] = count;
        }

        return nums;
    }
}
