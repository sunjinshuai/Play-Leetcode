//
//  ViewController.m
//  QuickSort
//
//  Created by sunjinshuai on 2019/4/28.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *quickSortArray = @[@16, @1, @2, @9, @7, @12, @5, @3, @8, @13, @10].mutableCopy;
    [self quickSortArray:quickSortArray withLeftIndex:0 andRightIndex:quickSortArray.count - 1];
    
    NSLog(@"%@", quickSortArray);
}

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

@end
