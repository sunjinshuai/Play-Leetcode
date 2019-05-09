# 归并排序

归并排序采用分治法，先把待排序序列拆分成一个个子序列，直到子序列只有一个元素，停止拆分，然后对每个子序列进行边排序边合并。 

### 算法描述
* 把长度为 n 的待排序序列分成两个长度为 n/2 的子序列；
* 然后递归每个子序列，直到子序列只有一个元素；
* 然后对每个子序列进行边排序边合并。

### 图示
![冒泡排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/MergeSort/MergeSort.gif)

### 代码实现
```
- (NSArray *)mergeSortWithArray:(NSArray *)unSortArray {
    NSInteger len = unSortArray.count;
    // 递归终止条件
    if (len <= 1) {
        return unSortArray;
    }
    NSInteger mid = len / 2;
    // 对左半部分进行拆分
    NSArray *lList = [self mergeSortWithArray:[unSortArray subarrayWithRange:NSMakeRange(0, mid)]];
    // 对右半部分进行拆分
    NSArray *rList = [self mergeSortWithArray:[unSortArray subarrayWithRange:NSMakeRange(mid, len - mid)]];
    // 递归结束后执行下面的语句
    NSInteger lIndex = 0;
    NSInteger rIndex = 0;
    // 进行合并
    NSMutableArray *results = [NSMutableArray array];
    while (lIndex < lList.count && rIndex < rList.count) {
        if ([lList[lIndex] integerValue] < [rList[rIndex] integerValue]) {
            [results addObject:lList[lIndex]];
            lIndex ++;
        } else {
            [results addObject:rList[rIndex]];
            rIndex ++;
        }
    }
    // 把左边剩余元素加到排序结果中
    if (lIndex < lList.count) {
        [results addObjectsFromArray:[lList subarrayWithRange:NSMakeRange(lIndex, lList.count - lIndex)]];
    }
    // 把右边剩余元素加到排序结果中
    if (rIndex < rList.count) {
        [results addObjectsFromArray:[rList subarrayWithRange:NSMakeRange(rIndex, rList.count - rIndex)]];
    }
    return results;
}
```
 
### 稳定性
因为是两两比较，不存在跳跃，因此是一种稳定的排序算法。虽然占用内存比较多，但却是一种效率高的算法。

### 空间复杂度
由于在归并过程中需要原始序列同样数量的存储空间 n 和递归时深度为 logn 的栈空间，因此空间复杂度为 O(n+logn)。

### 时间复杂度
一趟归并需要将 1～n 个相邻的元素进行两两归并，需要的时间为O(n)，整个归并排序需要进行log₂n 次，因此总的时间复杂度为 O(nlogn)。这是该算法中最好、最坏和平均的时间性能。