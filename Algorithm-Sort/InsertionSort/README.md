# 插入排序

插入排序的算法描述是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于待排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。

### 算法描述
一般来说，插入排序都采用 in-place 在数组上实现。具体算法描述如下：

* 从第一个元素开始，该元素可以认为已经被排序；
* 取出下一个元素，在已经排序的元素序列中从后向前扫描；
* 如果该元素（已排序）大于新元素，将该元素移到下一位置；
* 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
* 将新元素插入到该位置后；
* 重复步骤2~5。

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