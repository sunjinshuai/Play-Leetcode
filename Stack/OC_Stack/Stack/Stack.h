//
//  Stack.h
//  Stack
//
//  Created by aikucun on 2019/10/10.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stack : NSObject

- (instancetype)initWithSize:(NSUInteger)size;

- (id)popObject;
- (void)push:(id)object;
- (id)peek;
- (NSInteger)sizeOfStack;
- (BOOL)isEmpty;
- (BOOL)isFull;
- (void)clear;
- (NSArray *)allObjectsFromStack;

@end

NS_ASSUME_NONNULL_END
