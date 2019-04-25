# 选择排序

选择排序是一种简单直观的排序算法，首先在待排序序列中找到最小(大)元素，存放到排序序列的起始位置，然后，再从剩余待排序元素中继续寻找最小(大)元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。 

### 算法描述
* 设数组内存放了 n 个待排数字，数组下标从 1 开始，到 n 结束。
* 从数组的第 i 个元素开始到第 n 个元素，寻找最小的元素。（具体过程为:先设 arr[i] 为最小，逐一比较，若遇到比之小的则交换）
* 将上一步找到的最小元素和第 i 位元素交换。
* 如果 i=n－1 算法结束，否则重复“从数组的第 i 个元素开始到第 n 个元素，寻找最小的元素”的过程。


### 图示
![冒泡排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/BubbleSort/BubbleSort.gif)

### 代码实现
```
- (NSArray *)bubbleSort1WithArray:(NSArray *)unsortArray {
    NSMutableArray *tempArray = unsortArray.mutableCopy;
    for (int i = 0; i < tempArray.count; i++) {
        for (int j = 0; j < tempArray.count; j++) {
            if ([tempArray[i] integerValue] < [tempArray[j] integerValue]) {
                [tempArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return tempArray.copy;
}

- (NSArray *)bubbleSort2WithArray:(NSArray *)unsortArray {
    NSMutableArray *tempArray = unsortArray.mutableCopy;
    for (int i = 0; i < tempArray.count; i++) {
        for (int j = 0; j < tempArray.count - 1 - i; j++) {
            if ([tempArray[j] integerValue] > [tempArray[j + 1] integerValue]) {
                NSInteger temp   = [tempArray[j] integerValue];
                tempArray[j]     = tempArray[j + 1];
                tempArray[j + 1] = @(temp);
            }
        }
    }
    return tempArray.copy;
}
 ```
 
 
### 稳定性
比如，如果 a 原本在 b 前面，排序之后 a 仍然在 b 的前面。冒泡排序是比较两个相邻位置元素的大小，显然不会破坏稳定性。

### 空间复杂度
O(1)

### 时间复杂度
由于是双层 for 循环，所以时间复杂度是 O(n*n)