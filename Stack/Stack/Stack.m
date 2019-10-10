//
//  Stack.m
//  Stack
//
//  Created by aikucun on 2019/10/10.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "Stack.h"

/// 默认给数组一个默认的容量
static const int kDefaultCapacity = 4;

@interface Stack ()

/// 数组容器
@property (nonatomic, strong) NSMutableArray *stackArray;
/// 容器可存储元素的最大容量
@property (nonatomic, assign) NSUInteger     maxStackSize;

@end

@implementation Stack

- (instancetype)init {
    self = [super init];
    if (self) {
        _stackArray = [[NSMutableArray alloc] initWithCapacity:kDefaultCapacity];
        _maxStackSize = kDefaultCapacity;
    }
    return self;
}

- (instancetype)initWithSize:(NSUInteger)size {
    self = [super init];
    if (self) {
        if (size > 0) {
            _stackArray = [[NSMutableArray alloc] initWithCapacity:size];
            _maxStackSize = size;
        } else {
            NSAssert(size != 0, @"Stack size must be > 0");
        }
    }
    return self;
}

- (id)popLastObject {
    id object = [self peek];
    [self.stackArray removeLastObject];
    return object;
}

- (void)push:(id)object {
    if ([self isFull] && self.maxStackSize) {
        NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:_maxStackSize * 2];
        for (id object in self.stackArray) {
            @autoreleasepool {
                [newArray addObject:object];
            }
        }
        self.stackArray = newArray;
        _maxStackSize = _maxStackSize * 2;
    }
    if (object != nil) {
        [self.stackArray addObject:object];
    } else {
        NSAssert(object != nil, @"You can't push nil object to stack");
    }
}

- (id)peek {
    if ([self.stackArray count] > 0) {
        return [self.stackArray lastObject];
    }
    return nil;
}

- (NSInteger)sizeOfStack {
    return (NSInteger)[self.stackArray count];
}

- (BOOL)isEmpty {
    return [self.stackArray count] == 0;
}

- (BOOL)isFull {
    return ([self sizeOfStack] == (NSInteger)self.maxStackSize) ? YES : NO;
}

- (void)clear {
    [self.stackArray removeAllObjects];
}

- (NSArray *)allObjectsFromStack {
    NSMutableArray *buffer = [NSMutableArray array];
    for (id object in self.stackArray) {
        [buffer addObject:object];
    }
    return [buffer copy];
}

@end
