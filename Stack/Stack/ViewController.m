//
//  ViewController.m
//  Stack
//
//  Created by aikucun on 2019/10/10.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Stack *stack = [[Stack alloc] initWithSize:4];
    [stack push:@(1)];

    NSLog(@"%@", stack.allObjectsFromStack);
}


@end
