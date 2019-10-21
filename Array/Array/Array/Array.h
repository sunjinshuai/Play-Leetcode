//
//  Array.h
//  Array
//
//  Created by aikucun on 2019/10/21.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Array : NSObject

+ (instancetype)array;
+ (instancetype)initWithCapacity:(NSUInteger)numItems;

- (instancetype)initWithCapacity:(NSUInteger)numItems;

#pragma mark - 删除
- (void)removeObject:(id)anObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeAllObjects;

#pragma mark - 增加
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

#pragma mark - 查询
- (NSUInteger)count;
- (BOOL)isEmpty;
- (BOOL)isFull;
- (id)firstObject;
- (id)lastObject;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END
