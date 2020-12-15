//
//  NSArray+ZBJUtils.m
//  Poplar
//
//  Created by zoubenjun on 2020/12/15.
//

#import "NSArray+ZBJUtils.h"

@implementation NSArray (ZBJUtils)

- (void)ZBJ_each:(ZBJEnumerateBlock)block {
    NSInteger index = 0;
    for (id obj in self) {
        block(index, obj);
        index++;
    }
}

@end
