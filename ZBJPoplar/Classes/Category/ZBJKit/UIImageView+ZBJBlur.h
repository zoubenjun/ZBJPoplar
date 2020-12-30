//
//  UIImageView+ZBJBlur.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZBJBlur)
/// 高斯模糊
/// @param image 源图片
/// @param blur 模糊层度 [0,100] 值越大越模糊
- (void)zbj_gaussianBlurWithImage:(UIImage *)image blur:(CGFloat)blur;
/// 毛玻璃效果
/// @param image 源图片
/// @param blurStyle UIBlurEffectStyle
- (void)zbj_effectBlurWithImage:(UIImage *)image blurStyle:(UIBlurEffectStyle)blurStyle;
@end

NS_ASSUME_NONNULL_END
