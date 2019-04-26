//
//  ViewController.m
//  InsertionSort
//
//  Created by sunjinshuai on 2019/4/26.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@13,@2, @6, @9, @8, @5, @7, @1, @4, @20];
    NSArray *insertionSortArray = [self insertionSortWithArray:array];
    NSLog(@"%@", insertionSortArray);
}

// 插入排序的原理：始终定义第一个元素为有序的，将元素逐个插入到有序排列之中，其特点是要不断的
- (NSArray *)insertionSortWithArray:(NSArray *)unsortArray {
    NSMutableArray *tempArray = unsortArray.mutableCopy;
    // 移动数据，空出一个适当的位置，把待插入的元素放到里面去。
    for (int i = 0; i < tempArray.count; i++) {
        // temp 为待排元素 i为其位置 j为已排元素最后一个元素的位置（即取下一个元素，在已经排好序的元素序列中从后向前扫描）
        NSNumber *temp = tempArray[i];
        
        int j = i - 1;
        
        // 当j < 0 时， i 为第一个元素 该元素认为已经是排好序的 所以不进入while循环
        while (j >= 0 && [tempArray[j] intValue] > [temp intValue]) {
            //如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置
            [tempArray replaceObjectAtIndex:j + 1 withObject:tempArray[j]];
            j--;
        }
        // 跳出while循环时，j的元素小于或等于i的元素(待排元素)。插入新元素 a[j+1] = temp,即将空出来的位置插入待排序的值
        [tempArray replaceObjectAtIndex:j + 1 withObject:temp];
    }
    return tempArray.copy;
}

@end
