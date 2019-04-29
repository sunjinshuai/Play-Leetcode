# 希尔排序

希尔排序又叫缩小增量排序。1959 年 Shell 发明，第一个突破 O(n²) 的排序算法，是简单插入排序的改进版。

### 算法思想
将整个待排序的序列分割成为若干子序列分别进行直接插入排序，待整个序列中的记录“基本有序”时，再对全体记录进行依次直接插入排序。

### 图示

![希尔排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/ShellSort/ShellSort.gif)

### 算法描述

* 初始时，有一个大小为 10 的无序序列。
* 在第一趟排序中，我们不妨设 gap1 = N / 2 = 5，即相隔距离为 5 的元素组成一组，可以分为 5 组。 接下来，按照直接插入排序的方法对每个组进行排序。
* 在第二趟排序中，我们把上次的 gap 缩小一半，即 gap2 = gap1 / 2 = 2 (取整数)。这样每相隔距离为 2 的元素组成一组，可以分为 2 组。按照直接插入排序的方法对每个组进行排序。
* 在第三趟排序中，再次把 gap 缩小一半，即gap3 = gap2 / 2 = 1。 这样相隔距离为 1 的元素组成一组，即只有一组。按照直接插入排序的方法对每个组进行排序。此时，排序已经结束。

### 增量
希尔排序在插入排序的基础上增加一个叫增量的概念。那什么增量？插入排序只能与相邻的元素进行比较，而希尔排序则是进行跳跃比较，而增量就是步长。比如增量为3时，下标为0的元素与下标为3的元素比较，3再与6比较，1与4比较，4再与7比较……比较完后，再去减少增量，重复之前步骤，直到增量为1，此时只有一个分组了，再对这一个分组进行插入排序，整个希尔排序就结束了。

增量序列的最后一个增量值必须等于1才行。

### 代码实现

```
- (NSArray *)shellSortWithArray:(NSArray *)shellSortArray {
    NSMutableArray *tempArray = shellSortArray.mutableCopy;
    NSInteger length = tempArray.count;
    NSInteger gap = length / 2;
    while (gap >= 1) {
        for (NSInteger i = gap; i < length; i++) {
            NSInteger temp = [tempArray[i] intValue];
            NSInteger j = i;
            while (j >= gap && temp < [tempArray[j - gap] intValue]) {
                [tempArray replaceObjectAtIndex:j
                                     withObject:[tempArray objectAtIndex:j - gap]];
                j -= gap;
            }
            [tempArray replaceObjectAtIndex:j
                                 withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap / 2;
    }
    return tempArray.copy;
}
``` 
 
### 稳定性
可能会把相同元素分到不同的组内，那么导致这两个相同元素可能会被调换多次，不是一种稳定的排序算法。

稳定的意思是指相同的元素在排序后的相对位置不变。比如有两个5，作为区分前面的叫51，后面的叫52，排序完成后51还在52的前面。

### 空间复杂度
空间复杂度为O(1)

### 时间复杂度
使用希尔增量，在最坏的情况下时间复杂度仍为 O(n²)，而使用 hibbard 增量在最坏的情况下却为 O(n²⁄³)。