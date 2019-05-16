# 基数排序

核心思想是按顺序遍历待排序数组，根据当前有效位将它们分配到对应桶的队列中，然后选择有效位不断的执行出桶和入桶的操作。

### 算法描述
* 先创建 10 个桶；
* 获取无序数列中最大的值，然后获取这个最大值的长度，即位数；
* 按顺序遍历待排序数组，根据当前有效位将它们分配到对应桶的队列中；
* 按桶编号顺序进行遍历，将每个桶中队列按顺序收集到原数组中；
* 选择下一个有效位执行入桶和出桶的操作；

### 图示
![基数排序](https://github.com/sunjinshuai/Play-Leetcode/blob/master/Algorithm-Sort/RadixSort/RadixSort.gif)

### 代码实现
```
- (NSArray *)radixSortWithArray:(NSArray *)radixSortArray {
    NSMutableArray *tempArray = radixSortArray.mutableCopy;
    // 创建空桶
    NSMutableArray *bucketArray = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [bucketArray addObject:array];
    }
    
    // 待排数组的最大数值
    NSNumber *maxNumber = tempArray.firstObject;
    for (NSNumber *number in tempArray) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = number;
        }
    }
    
    // 最大数值的数字位数
    NSInteger digitMaxLength = [NSString stringWithFormat:@"%ld", [maxNumber integerValue]].length;
    
    // 按照从低位到高位的顺序执行排序过程
    for (int digit = 1; digit <= digitMaxLength; digit++) {
        // 入桶
        for (NSNumber *item in tempArray) {
            // 确定item 归属哪个桶 以 digit 位数为基数
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray *mutArray = bucketArray[baseNumber];
            // 将数据放入空桶上
            [mutArray addObject:item];
        }
        NSInteger index = 0;
        // 出桶
        for (int i = 0; i < bucketArray.count; i++) {
            NSMutableArray *mutArray = bucketArray[i];
            while (mutArray.count > 0) {
                NSNumber *number = mutArray.firstObject;
                [tempArray replaceObjectAtIndex:index withObject:number];
                [mutArray removeObjectAtIndex:0];
                index ++;
            }
        }
    }
    return tempArray.copy;
}

- (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit {
    NSInteger numberLength = [NSString stringWithFormat:@"%@", number].length;
    // digit为基数位数
    if (digit > 0 && digit <= numberLength) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        // number的位数确定
        NSString *string = [NSString stringWithFormat:@"%ld", [number integerValue]];
        for (int index = 0; index < numberLength; index++) {
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        // number的位数 是几位数的
        NSString *str = numbersArray[numbersArray.count - digit];
        return [str integerValue];
    }
    return 0;
}
```
 
### 稳定性
是按照低位先排序，然后收集；再按照高位排序，然后再收集；依次类推，直到最高位。有时候有些属性是有优先级顺序的，先按低优先级排序，再按高优先级排序。最后的次序就是高优先级高的在前，高优先级相同的低优先级高的在前。基数排序基于分别排序，分别收集，所以是稳定的。

### 空间复杂度
空间复杂度为 O(n+k)，其中 k 为桶的数量。一般来说 n>>k，因此额外空间需要大概 n 个左右。
### 时间复杂度
O(d(n+r))，基数排序中，r 为基数，d 为位数。
