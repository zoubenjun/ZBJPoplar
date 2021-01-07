//
//  UIImage+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZBJUtils)
/// 是否包含透明度
- (BOOL)zbj_hasAlphaChannel;
/// 返回一个1*1大小color颜色的图片
/// @param color color
+ (nullable UIImage *)zbj_imageWithColor:(UIColor *)color;
/// 返回一个color颜色的图片
/// @param color color
/// @param size size
+ (nullable UIImage *)zbj_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 缩放图片
/// @param size 新尺寸
- (nullable UIImage *)zbj_imageByResizeToSize:(CGSize)size;
/// 缩放图片
/// @param size 新尺寸
/// @param contentMode 缩放的模式
- (nullable UIImage *)zbj_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;
/// 图片切圆角
/// @param radius 圆角大小
/// @param borderWidth 边框线条宽度
/// @param borderColor 边框颜色
- (nullable UIImage *)zbj_imageByRoundCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;
/// 图片切圆角
/// @param radius 圆角大小
/// @param corners 某些角
/// @param borderWidth 边框线条宽度
/// @param borderColor 边框颜色
/// @param borderLineJoin borderLineJoin
- (nullable UIImage *)zbj_imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;
/// 旋转图片
/// @param radians 角度
/// @param fitSize 是否返回旋转后的尺寸
- (nullable UIImage *)zbj_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;
/// 图片左旋90°
- (nullable UIImage *)zbj_imageByRotateLeft90;
/// 图片右旋90°
- (nullable UIImage *)zbj_imageByRotateRight90;
/// 图片旋转180°
- (nullable UIImage *)zbj_imageByRotate180;
/// 图片⥯
- (nullable UIImage *)zbj_imageByFlipVertical;
/// 图片⇋
- (nullable UIImage *)zbj_imageByFlipHorizontal;
/// 修改图片颜色
/// @param color color
- (nullable UIImage *)zbj_imageByTintColor:(UIColor *)color;
/// 模糊图片
/// @param tintColor  tintColor
- (nullable UIImage *)zbj_imageByBlurWithTint:(UIColor *)tintColor;
@end

NS_ASSUME_NONNULL_END
