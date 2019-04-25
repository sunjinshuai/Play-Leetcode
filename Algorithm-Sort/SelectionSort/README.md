# 选择排序

选择排序是一种简单直观的排序算法，首先在待排序序列中找到最小(大)元素，存放到排序序列的起始位置，然后，再从剩余待排序元素中继续寻找最小(大)元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。 

### 算法描述
* 设数组内存放了 n 个待排数字，数组下标从 1 开始，到 n 结束。
* 从数组的第 i 个元素开始到第 n 个元素，寻找最小的元素。（具体过程为:先设 arr[i] 为最小，逐一比较，若遇到比之小的则交换）
* 将上一步找到的最小元素和第 i 位元素交换。
* 如果 i=n－1 算法结束，否则重复“从数组的第 i 个元素开始到第 n 个元素，寻找最小的元素”的过程。


### 图示
![冒泡排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/SelectionSort/SelectionSort.gif)

### 代码实现
```
- (NSArray *)selectSort1WithArray:(NSArray *)unSelectSortArray {
    NSMutableArray *tempArray = unSelectSortArray.mutableCopy;
    for (int i = 0; i < tempArray.count; i ++) {
        NSInteger min = i;
        for (int j = i + 1 ; j < tempArray.count ; j ++ ) {
            if ([tempArray[j] integerValue] < [tempArray[min] integerValue]) {
                min = j;
            }
        }
        [tempArray exchangeObjectAtIndex:i withObjectAtIndex:min];
    }
    return tempArray.copy;
}

- (NSArray *)selectSort2WithArray:(NSArray *)unSelectSortArray {
    NSMutableArray *tempArray = unSelectSortArray.mutableCopy;
    for (int i = 0; i < tempArray.count; i ++) {
        NSInteger min = i;
        for (int j = i + 1 ; j < tempArray.count ; j ++ ) {
            if ([tempArray[j] integerValue] < [tempArray[min] integerValue]) {
                min = j;
            }
        }
        // 交换数据
        if (i != min) {
            NSInteger temp = [tempArray[min] integerValue];
            tempArray[min] = tempArray[i];
            tempArray[i] = @(temp);
        }
    }
    return tempArray.copy;
}
```
 
 
### 稳定性
选择排序是不稳定的排序方法。（如序列[5， 5， 3]第一次就将第一个[5]与[3]交换，导致第一个5挪动到第二个5后面）。

### 空间复杂度
最优的情况下（已经有顺序）复杂度为：O(0) ；最差的情况下（全部元素都要重新排序）复杂度为：O(n )；平均的时间复杂度：O(1)

### 时间复杂度
选择排序的比较次数与序列的初始排序无关。 假设待排序的序列有 n 个元素，则比较次数总是 [n * (n - 1)]/2。
而移动次数与序列的初始排序有关。当序列正序时，移动次数最少，为 0。当序列反序时，移动次数最多，为[3n * (n - 1)]/  2。选择排序的最优时间复杂度和最差时间复杂度和平均时间复杂度都为 ：O(n * n)

