//
//  Array.m
//  Array
//
//  Created by aikucun on 2019/10/21.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "Array.h"

typedef void * AnyObject;
static NSInteger const defaultCapacity = 10;

@interface Array () {
    AnyObject *_array;
}

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger capacity;

@end

@implementation Array

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetArray];
    }
    return self;
}

+ (instancetype)array {
    return [[Array alloc] initWithCapacity:defaultCapacity];
}

+ (instancetype)initWithCapacity:(NSUInteger)numItems {
    return [[Array alloc] initWithCapacity:numItems];
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    _capacity = numItems;
    _array = calloc(_capacity, sizeof(AnyObject));
    _size = 0;
    return self;
}

#pragma mark - 删除
- (void)removeObject:(id)anObject {
    NSInteger index = [self indexOfObject:anObject];
    if (index == NSNotFound) return;
    [self removeObjectAtIndex:index];
}

- (void)removeLastObject {
    if ([self isEmpty]) return;
    [self removeObjectAtIndex:_size-1];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    /// 判断越界
    if ((index > _size)) {
        @throw [NSException exceptionWithName:@"Array is out of bounds"
                                       reason:@"out of bounds"
                                     userInfo:nil];
        return;
    }
    AnyObject object = (_array[index]);
    CFRelease(object);
    for (NSInteger i = index + 1; i < _size; i ++) {
        _array[i - 1] = _array[i];
    }
    _size--;
    _array[_size] = NULL;
    
    /// 对数组空间缩减
    if (_size == _capacity / 2) {
        [self resize:_capacity / 2];
    }
}

- (void)removeAllObjects {
    NSInteger i = _size - 1;
    while (_size > 0) {
        [self removeObjectAtIndex:i];
        i--;
    }
    [self resetArray];
}

#pragma mark - 增加
- (void)addObject:(id)anObject {
    [self insertObject:anObject atIndex:_size];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        @throw [NSException exceptionWithName:@"add object null."
                                       reason:@"object must be not null ."
                                     userInfo:nil];
        return;
    }
    /// 越界判断
    if ((index > _size)) {
        @throw [NSException exceptionWithName:@"Array is out of bounds"
                                       reason:@"out of bounds"
                                     userInfo:nil];
        return;
    }
    
    if (_size == _capacity - 1) { /// 判断原来数组是否已经满了，如果满了就需要增加数组长度
        [self resize:2 * _capacity];
    }
    
    /// 交换索引位置
    if (self.count > 0) {
        for(NSInteger i = _size - 1; i >= index; i--)
            _array[i + 1] = _array[i];
    }
    self->_array[index] = (__bridge_retained AnyObject)(anObject);
    _size++;
}

#pragma mark - 查询
- (NSUInteger)count {
    return _size;
}

- (BOOL)isEmpty {
    return (self->_size == 0);
}

- (BOOL)isFull {
    return (self->_size == self->_capacity - 1);
}

- (id)firstObject {
    if ([self isEmpty]) return nil;
    return (__bridge id _Nullable)(_array[0]);
}

- (id)lastObject {
    if ([self isEmpty]) return nil;
    return (__bridge id _Nullable)(_array[_size]);
}

- (id)objectAtIndex:(NSUInteger)index {
    if ((index > _size)) {
        @throw [NSException exceptionWithName:@"Array is out of bounds"
                                       reason:@"out of bounds"
                                     userInfo:nil];
        return nil;
    }
    if ([self isEmpty]) { return nil; }
    AnyObject obj = _array[index];
    if (obj == NULL) return nil;
    return (__bridge id)(obj);
}

- (NSUInteger)indexOfObject:(id)anObject {
    for (int i = 0; i < _size; i++) {
        id obj = (__bridge id)(_array[i]);
        if ([anObject isEqual:obj]) return i;
    }
    return NSNotFound;
}

/**
 对数组扩容
 
 @param capacity 新的容量
 */
- (void)resize:(NSInteger)capacity {
    AnyObject *oldArray = _array;
    AnyObject *newArray = calloc(capacity, sizeof(AnyObject));
    for (int i = 0 ; i < _size; i++) {
        newArray[i] = oldArray[i];
    }
    _array = newArray;
    _capacity = capacity;
    free(oldArray);
}

/**
 数组重置
 */
- (void)resetArray {
    _size = 0;
    if (_array != NULL) {
        _array[_size] = NULL;
        free(_array);
    }
    _capacity = defaultCapacity;
    _array = calloc(_capacity, sizeof(AnyObject));
}

- (void)dealloc {
    if (_array != NULL) {
        [self removeAllObjects];
    }
    free(_array);
}

@end
