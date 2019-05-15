//
//  ViewController.m
//  RadixSort
//
//  Created by sunjinshuai on 2019/5/15.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@73, @22, @93, @43, @55, @14, @28, @65, @39, @81].mutableCopy;
    NSArray *radixSortArray = [self radixSortWithArray:array];
    NSLog(@"%@", radixSortArray);
}

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

@end
