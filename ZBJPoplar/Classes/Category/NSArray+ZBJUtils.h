//
//  NSArray+ZBJUtils.h
//  Poplar
//
//  Created by zoubenjun on 2020/12/15.
//

#import <Foundation/Foundation.h>

typedef void(^ZBJEnumerateBlock)(NSInteger index, id _Nullable obj);

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZBJUtils)

/// 便利数组内容，返回index和对应元素
/// @param block 在block 返回
- (void)ZBJ_each:(ZBJEnumerateBlock)block;
@end

NS_ASSUME_NONNULL_END
