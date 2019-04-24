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
    NSArray *sortArray = [self bubbleSortWithArray:unsortArray];
    NSLog(@"%@", sortArray);
    
}

- (NSArray *)bubbleSortWithArray:(NSArray *)unsortArray {
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

@end
