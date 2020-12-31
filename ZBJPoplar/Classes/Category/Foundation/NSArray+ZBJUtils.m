//
//  NSArray+ZBJUtils.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/15.
//

#import "NSArray+ZBJUtils.h"

@implementation NSArray (ZBJUtils)

- (void)zbj_each:(ZBJEnumerateBlock)block {
    NSParameterAssert(block != nil);
    NSInteger index = 0;
    for (id obj in self) {
        block(index, obj);
        index++;
    }
}

- (NSArray *)zbj_map:(ZBJTransformBlock)block {
    NSParameterAssert(block != nil);
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        id result = block(obj);
        if (result) {
            [ret addObject:result];
        }
    }
    
    return ret;
}

- (id)zbj_matchFirst:(ZBJValidationBlock)block {
    NSParameterAssert(block != nil);
    for (id obj in self) {
        if (block(obj)) {
            return obj;
        }
    }
    
    return nil;
}

- (NSArray *)zbj_matchAll:(ZBJValidationBlock)block {
    NSParameterAssert(block != nil);
    
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }]];
}

- (id)zbj_reduce:(id)initial withBlock:(ZBJAccumulationBlock)block {
    NSParameterAssert(block != nil);
    id result = initial;
    for (id obj in self) {
        result = block(result, obj);
    }
    
    return result;
}

- (BOOL)zbj_allObjectsMatched:(ZBJValidationBlock)block {
    NSParameterAssert(block != nil);
    for (id obj in self) {
        if (!block(obj)) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)zbj_anyObjectMatched:(ZBJValidationBlock)block {
    NSParameterAssert(block != nil);
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)zbj_join:(NSString *)seperator {
    NSMutableString *string = [NSMutableString string];
    [self zbj_each:^(NSInteger index, id obj) {
        if (index != 0) {
            [string appendString:seperator];
        }
        [string appendString:obj];
    }];
    
    return string;
}

- (NSArray *)zbj_groupBy:(ZBJTransformBlock)block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (id obj in self) {
        NSString *key = block(obj);
        if (dic[key] == nil) {
            dic[key] = [NSMutableArray array];
        }
        [dic[key] addObject:obj];
    }
    
    return [dic allValues];
}

- (NSArray *)zbj_seprate:(NSInteger)length {
    NSMutableArray *array = [@[] mutableCopy];
    for (int i = 0; i < self.count; i += length) {
        if (i + length <= self.count) {
            [array addObject:[self subarrayWithRange:(NSRange){i, length}]];
        } else {
            [array addObject:[self subarrayWithRange:NSMakeRange(i, self.count - i)]];
        }
    }
    
    return [array copy];
}

- (NSArray *)zbj_flatten {
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *subArray in self) {
        if ([subArray isKindOfClass:[NSArray class]]) {
            [array addObjectsFromArray:[subArray zbj_flatten]];
        } else {
            id obj = subArray;
            [array addObject:obj];
        }
    }
    
    return [array copy];
}

@end
