//
//  ViewController.m
//  SelectionSort
//
//  Created by sunjinshuai on 2019/4/24.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *selectSortArray = @[@9, @1, @2, @5, @7, @4, @8, @6, @3, @5];
    NSArray *tempArray = [self selectSort1WithArray:selectSortArray];
    NSLog(@"%@", tempArray);
}

/*
 选择排序的原理：每一次从待排序的数据元素中选出最小（或最大）的一个元素，
 存放在序列的起始位置，直到全部待排序的数据元素排完。
 */
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

@end
