//
//  ViewController.m
//  BubbleSort
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
    
    NSArray *unsortArray = @[@11, @2, @5, @8, @1, @35, @4, @15, @7, @88];
    NSArray *sortArray = [self bubbleSort2WithArray:unsortArray];
    NSLog(@"%@", sortArray);
    
}

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

@end
