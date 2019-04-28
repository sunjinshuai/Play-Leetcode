# 快速排序

快速排序的基本思想是：通过一趟排序将待排序的记录分割成独立的两部分，其中一部分记录的关键字均比另一部分记录的关键字小，则可分别对这两部分记录继续进行排序，以达到整个序列有序的目的。

当右游标找到一个比枢轴小的元素时，马上把枢轴交换到游标所在位置，而游标位置的元素则移到枢轴那里。完成一次枢轴更新。然后左游标再去寻找比枢轴大的元素，同理，在交换的过程中同时也把枢轴的位置不断进行更新，当游标相遇时，枢轴的定位也完成了。

### 算法描述

* 从待排序数组中选一个元素，称为 “基准”(pivot)，一般选第一个元素即可。
* 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面，枢轴放在中间。
* 记一个游标 i，指向待排序数组的首位，它将会不断向后移动；
* 再记一个游标 j，指向待排序数组的末位，它将会不断向前移动。
* 当 i 、j 终有相遇时，排序完成了。
* 递归把小于基准值元素的子数列和大于基准值元素的子数列排序。

#### 注意
i 指针默认指向第一个元素，即“基准”(pivot)，当 i 指针找到一个比 pivot 小的元素 x 时，马上把 pivot 交换到 x 所在位置，而 x 位置的元素则移到 pivot 那里。然后 j 指针再去寻找比枢轴大的元素，同理。在 j 指针扫描中已经知道 x 是比 pivot 小的，所以完全可以让 i 跳过 x，不需要拿着 x 和 pivot 再比较一次。
结论是在 j 游标的交换完成后，顺便把 i 往后移一位，i++。
同理，在 i 游标的交换完成后，顺便把 j 往前移一位，j--。

### 图示

![快速排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/QuickSort/QuickSort.gif)

### 代码实现

```
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex {
    // 如果数组长度为0或1时返回
    if (leftIndex >= rightIndex) {
        return;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    // 记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        // 如果比基准数大，继续查找
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        // 如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        // 如果比基准数小，继续查找
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        // 如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
    }
    
    // 将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    // 排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    // 排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}
``` 
 
### 稳定性
由于“基准”元素(pivot)的比较和交换是跳跃进行的，因此，快速排序是一种不稳定的排序方法。

### 空间复杂度
主要是递归造成的栈空间的使用，最好情况，递归树的深度为log₂n，其空间复杂度也就是O(longn)，最坏情况，需要进行n-1次递归调用，空间复杂度为O(n)，平均情况，空间复杂度为O(logn)。

### 时间复杂度
最优的情况下，时间复杂度为O(nlogn)，最坏的情况下为O(n²)，平均情况为O(nlogn)。