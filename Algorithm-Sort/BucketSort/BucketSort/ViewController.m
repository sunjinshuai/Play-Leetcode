//
//  ViewController.m
//  BucketSort
//
//  Created by sunjinshuai on 2019/5/14.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *tempArray = @[@8, @11, @4, @16, @2, @3, @5, @7];
    NSArray *bucketSortArray = [self bucketSortWithArray:tempArray];
    NSLog(@"%@", bucketSortArray);
}

- (NSArray *)bucketSortWithArray:(NSArray *)bucketSortArray {
    
    // 预计每个桶内能装3个
    NSInteger size = 3;
    // 桶的数量
    NSInteger bucketsCount = bucketSortArray.count / size;
    
    // 1.找出数组中最大数和最小数
    NSInteger max = [[bucketSortArray firstObject] integerValue];
    NSInteger min = [[bucketSortArray firstObject] integerValue];
    for (NSNumber *item in bucketSortArray) {
        if ([item integerValue] > max) {
            max = item.integerValue;
        }
        if ([item integerValue] < min) {
            min = item.integerValue;
        }
    }

    // 2.创建桶
    // a.计算桶中数据的平均值，这样分组数据的时候会把数据放到对应的桶中
    float space = (max - min + 1) / (bucketsCount * 1.0);

    NSMutableArray *buckets = [NSMutableArray arrayWithCapacity:bucketsCount];
    for (int i = 0; i < bucketsCount; i++) {
        NSMutableArray *aBucket = [NSMutableArray array];
        [buckets addObject:aBucket];
    }
    // 3.把数据分配到桶中，桶中的数据是有序的
    for (int i = 0; i < bucketSortArray.count; i++) {
        // b.根据数据值计算它在桶中的位置
        int index = floor(([bucketSortArray[i] integerValue] - min) / space);
        NSMutableArray *bucket = buckets[index];
        int maxCount = (int)bucket.count;
        NSInteger minIndex = 0;
        for (int j = maxCount - 1; j >= 0; j--) {
            if ([bucketSortArray[i] integerValue] > [bucket[j] integerValue]) {
                minIndex = j+1;
                break;
            }
        }
        [bucket insertObject:bucketSortArray[i] atIndex:minIndex];
    }
    // 4.把桶中的数据重新组装起来
    NSMutableArray *results = [NSMutableArray array];
    [buckets enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [results addObjectsFromArray:obj];
    }];
    
    return results;
}

@end
