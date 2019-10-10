//
//  ViewController.m
//  0020-Valid-Parentheses
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

    NSString *str1 = @"()";
    NSString *str2 = @"()[]{}";
    NSString *str3 = @"(]";
    NSString *str4 = @"([)]";

    NSLog(@"字符串()是否匹配：%d", [self isValid:str1]);
    NSLog(@"字符串()[]{}是否匹配：%d", [self isValid:str2]);
    NSLog(@"字符串(]是否匹配：%d", [self isValid:str3]);
    NSLog(@"字符串([)]是否匹配：%d", [self isValid:str4]);
}

- (BOOL)isValid:(NSString *)inputStr {
    if (inputStr.length == 0 || inputStr.length % 2 == 1) {
        return NO;
    }
    Stack *stack = [[Stack alloc] initWithSize:10];
    for (int i = 0; i < inputStr.length; i++) {
        unichar tempChar = [inputStr characterAtIndex:i];
        NSString *tempStr = [NSString stringWithCharacters:&tempChar length:1];
        if ([tempStr isEqualToString:@"("] || [tempStr isEqualToString:@"["] || [tempStr isEqualToString:@"{"]) {
            [stack push:tempStr];
        } else {
            NSString *lastStr = stack.peek;
            if (stack && [self isPairMatch:lastStr rightPair:tempStr]) {
                [stack popObject];
            } else {
                return NO;
            }
        }
    }
    return [stack isEmpty];
}

- (BOOL)isPairMatch:(NSString *)leftPair rightPair:(NSString *)rightPair {
    return ([leftPair isEqualToString:@"("] && [rightPair isEqualToString:@")"]) ||
    ([leftPair isEqualToString:@"["] && [rightPair isEqualToString:@"]"]) ||
    ([leftPair isEqualToString:@"{"] && [rightPair isEqualToString:@"}"]);
}

@end
