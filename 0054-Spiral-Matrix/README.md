# 54. 螺旋矩阵

给定一个 `m × n` 的矩阵，按照顺时针螺旋顺序返回所有元素。

[力扣题目](https://leetcode.cn/problems/spiral-matrix/description/) · [Java 源码](Java/Solution.java) · [在线交互演示](https://sunjinshuai.github.io/Play-Leetcode/0054-Spiral-Matrix/interactive.html)

本题是读取已有矩阵，允许长方形；[59. 螺旋矩阵 II](../0059-Spiral-Matrix-II/README.md) 是生成一个正方形矩阵，两题不要混淆。

## 交互演示

点击[在线打开交互演示](https://sunjinshuai.github.io/Play-Leetcode/0054-Spiral-Matrix/interactive.html)即可使用，无需下载。也可以下载仓库，用浏览器打开本目录的 [interactive.html](interactive.html)。

在线演示由 GitHub Pages 从 `master` 分支根目录发布，后续更新该 HTML 并推送后会自动部署。根目录的 `.nojekyll` 用于直接发布静态文件。

演示默认使用下方的 `3 × 3` 示例，可切换正方形、横向长方形（`3 × 4`）、纵向长方形（`4 × 3`）、单行（`1 × 4`）、单列（`4 × 1`）和单个元素（`1 × 1`），支持「上一步」「下一步」「自动播放 / 暂停」。每一步同步显示当前格子、行列下标、四个边界、对应循环和结果列表。带“当前”的格子是正在读取的位置，带 ✓ 的格子已经读取。

切换矩阵会暂停播放、清空结果并回到第一步。

- 正方形：观察右列阶段，`right` 固定为 `2`，`row` 从 `1` 变为 `2`，依次读取 `6、9`。
- 横向长方形：外圈结束后只剩一行，观察右边循环为何跳过。
- 纵向长方形：外圈结束后只剩一列，观察上边、右边如何完成读取。
- 单行、单列和单个元素：观察 `left < right && top < bottom` 为假时，下边、左边为何不再执行。

## 示例

```text
输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]

1 → 2 → 3
        ↓
4   5   6
↑       ↓
7 ← 8 ← 9

输出：[1,2,3,6,9,8,7,4,5]
```

## 思路：读完外圈，再向内缩一格

使用四个下标圈出当前尚未处理的区域：

| 变量 | 含义 | 示例中的初始值 |
| --- | --- | --- |
| `top` | 最上面的行下标 | `0` |
| `bottom` | 最下面的行下标 | `2` |
| `left` | 最左边的列下标 | `0` |
| `right` | 最右边的列下标 | `2` |

`matrix[行][列]` 的下标从 `0` 开始。横着走时行不变、列变化；竖着走时列不变、行变化。

每一圈按上边、右边、下边、左边的顺序读取。**这份实现是在整圈结束后统一收缩四个边界，不是在每条边读完后马上收缩。**

## 四条边怎么走？

### 1. 上边：从左到右，两个角都读

```java
for (int column = left; column <= right; column++) {
    order.add(matrix[top][column]);
}
```

固定第 `top` 行，列从 `left` 走到 `right`。示例依次读取 `1、2、3`。

### 2. 右边：从上到下，跳过右上角

```java
for (int row = top + 1; row <= bottom; row++) {
    order.add(matrix[row][right]);
}
```

右上角的 `3` 已经被上边读取，所以从下一行 `top + 1` 开始。

代入 `top = 0`、`bottom = 2`、`right = 2`，代码就变成：

```java
for (int row = 1; row <= 2; row++) {
    order.add(matrix[row][2]);
}
```

| 执行过程 | 位置 | 读取的值 |
| --- | --- | --- |
| `row = 1` | `matrix[1][2]`：第 2 行、第 3 列 | `6` |
| `row = 2` | `matrix[2][2]`：第 3 行、第 3 列 | `9` |
| `row = 3` | 不满足 `row <= 2`，循环结束 | — |

```text
1  2  3  ← 已读取，跳过
      ↓
4  5  6  ← row = 1
      ↓
7  8  9  ← row = 2
```

`right` 固定，只有 `row` 增加，因此是在最右列向下走。注意 `row++` 发生在本轮循环体执行之后。

### 3. 下边：从右到左，两个角都不读

```java
for (int column = right - 1; column > left; column--) {
    order.add(matrix[bottom][column]);
}
```

- 从 `right - 1` 开始：右下角 `9` 已经读过。
- 使用 `column > left`：左下角 `7` 留给左边循环。

示例只读取 `8`。如果当前恰好有两列，下边循环不执行，两个下角分别由右边和左边读取。

### 4. 左边：从下到上，读取左下角，跳过左上角

```java
for (int row = bottom; row > top; row--) {
    order.add(matrix[row][left]);
}
```

示例读取 `7、4`。使用 `row > top`，避免再次读取左上角 `1`。

四个角的分工：上边读取左上角和右上角，右边读取右下角，左边读取左下角，下边不读取角。

## 为什么下边和左边前面有 if？

```java
if (left < right && top < bottom)
```

只有当前区域至少有两列、两行时，才读取下边和左边：

- 只剩一行：上边循环已经读完所有元素。
- 只剩一列：上边读取第一个元素，右边读取剩余元素。
- 只剩一个格子：上边读取该格子，其他循环跳过。

因此，这个判断用于避免重复读取。它和外层 `while` 不同：`while` 使用 `<=`，因为单行、单列、单个格子仍然需要进入循环处理。

## 一圈之后如何进入内圈？

```java
left++;
right--;
top++;
bottom--;
```

示例第一圈结束后，结果为 `[1,2,3,6,9,8,7,4]`，四个边界都变成 `1`，只剩中心 `5`。

下一轮由上边循环读取 `5`，其余循环不执行。再次收缩后，`left > right` 且 `top > bottom`，退出循环。

## Java 实现

```java
import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> spiralOrder(int[][] matrix) {
        List<Integer> order = new ArrayList<>();
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return order;
        }

        int rows = matrix.length, columns = matrix[0].length;
        int left = 0, right = columns - 1, top = 0, bottom = rows - 1;
        while (left <= right && top <= bottom) {
            // 上边包含左上角和右上角。
            for (int column = left; column <= right; column++) {
                order.add(matrix[top][column]);
            }
            // 右上角已读取，从下一行开始。
            for (int row = top + 1; row <= bottom; row++) {
                order.add(matrix[row][right]);
            }
            // 只有至少两行、两列时，才需要读取下边和左边。
            if (left < right && top < bottom) {
                // 右下角已读取，左下角留给左边。
                for (int column = right - 1; column > left; column--) {
                    order.add(matrix[bottom][column]);
                }
                for (int row = bottom; row > top; row--) {
                    order.add(matrix[row][left]);
                }
            }
            left++;
            right--;
            top++;
            bottom--;
        }
        return order;
    }
}
```

## 边界示例

| 输入 | 输出 | 关键处理 |
| --- | --- | --- |
| `[[1]]` | `[1]` | 只执行上边 |
| `[[1,2,3]]` | `[1,2,3]` | 单行由上边读完 |
| `[[1],[2],[3]]` | `[1,2,3]` | 上边读 1，右边读 2、3 |
| `[[1,2],[3,4]]` | `[1,2,4,3]` | 下边循环为空，左边读 3 |
| `[[1,2,3,4],[5,6,7,8],[9,10,11,12]]` | `[1,2,3,4,8,12,11,10,9,5,6,7]` | 内圈剩一行 |

代码额外处理 `null`、零行和零列输入，返回空列表；输入按题意为每行等长的矩阵，不处理空行引用或不规则二维数组。

## 复杂度

- 时间复杂度：`O(mn)`，每个元素读取一次。
- 额外空间复杂度：`O(1)`，不计返回列表；返回列表占用 `O(mn)` 空间。
