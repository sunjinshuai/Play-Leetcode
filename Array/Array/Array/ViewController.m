//
//  ViewController.m
//  Array
//
//  Created by aikucun on 2019/10/21.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "ViewController.h"
#import "Array.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Array *array = [Array initWithCapacity:5];

    [array addObject:@(1)];
    [array addObject:@(3)];
    [array addObject:@(4)];
    [array addObject:@(15)];
    [array addObject:@(25)];

    NSLog(@"%ld", array.count);
}


@end
