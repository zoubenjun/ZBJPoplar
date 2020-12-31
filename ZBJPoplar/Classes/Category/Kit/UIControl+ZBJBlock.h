//
//  UIControl+ZBJBlock.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (ZBJBlock)

/// 添加事件
/// @param action 事件响应
/// @param controlEvents 事件类型
- (void)zbj_addAction:(void (^)(id sender))action forControlEvents:(UIControlEvents)controlEvents;
/// 删除事件
/// @param controlEvents 事件类型
- (void)zbj_removeActionsForControlEvents:(UIControlEvents)controlEvents;
/// 删除全部事件
- (void)zbj_removeAllTargets;
@end

NS_ASSUME_NONNULL_END
