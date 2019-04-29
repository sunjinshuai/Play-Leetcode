//
//  ViewController.m
//  ShellSort
//
//  Created by sunjinshuai on 2019/4/29.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *shellSortArray = @[@84, @83, @88, @87, @61, @50, @70, @60, @80, @99];
    NSArray *tempArray = [self shellSortWithArray:shellSortArray.mutableCopy];
    NSLog(@"%@", tempArray);
}

- (NSArray *)shellSortWithArray:(NSArray *)shellSortArray {
    NSMutableArray *tempArray = shellSortArray.mutableCopy;
    NSInteger length = tempArray.count;
    NSInteger gap = length / 2;
    while (gap >= 1) {
        for (NSInteger i = gap; i < length; i++) {
            NSInteger temp = [tempArray[i] intValue];
            NSInteger j = i;
            while (j >= gap && temp < [tempArray[j - gap] intValue]) {
                [tempArray replaceObjectAtIndex:j
                                     withObject:[tempArray objectAtIndex:j - gap]];
                j -= gap;
            }
            [tempArray replaceObjectAtIndex:j
                                 withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap / 2;
    }
    return tempArray.copy;
}

@end
