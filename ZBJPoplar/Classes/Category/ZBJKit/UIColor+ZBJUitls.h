//
//  UIColor+ZBJUitls.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZBJGradietColorType) {
    ZBJGradietColorTypeTopToBottom = 0, /// 从上到下
    ZBJGradietColorTypeLeftToRight = 1, /// 从左到右
    ZBJGradietColorTypeLeftTopToRightBottom = 2, /// 从左上到右下
    ZBJGradietColorTypeRightTopToLeftBottom = 3, /// 从右上到左下
};

@interface UIColor (ZBJUitls)
/// 把FFFFFF, #FFFFFF, 0xFFFFFF转为UIColor
/// @param hexString FFFFFF, #FFFFFF, 0xFFFFFF
+ (UIColor *)zbj_colorWithHexString:(NSString *)hexString;
/// 把FFFFFF, #FFFFFF, 0xFFFFFF转为UIColor
/// @param hexString FFFFFF, #FFFFFF, 0xFFFFFF
/// @param alpha 透明度 [0,1]
+ (UIColor *)zbj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/// 0xFFFFFF转为UIColor
/// @param hexValue 0xFFFFFF
+ (UIColor *)zbj_colorWithHexValue:(unsigned int)hexValue;
/// 0xFFFFFF转为UIColor
/// @param hexValue 0xFFFFFF
/// @param alpha 透明度 [0,1]
+ (UIColor *)zbj_colorWithHexValue:(unsigned int)hexValue alpha:(CGFloat)alpha;
/// 快捷设置颜色
/// @param red [0,255]
/// @param green  [0,255]
/// @param blue  [0,255]
+ (UIColor *)zbj_colorWithRed:(float)red green:(float)green blue:(float)blue;
/// 快捷设置颜色
/// @param red [0,255]
/// @param green [0,255]
/// @param blue [0,255]
/// @param alpha 透明度 [0,1]
+ (UIColor *)zbj_colorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;
/// 渐变色
/// @param colors 根据这些颜色渐变
/// @param type  ZBJGradietColorType default:ZBJGradietColorTypeTopToBottom
/// @param size size
+ (UIColor *)zbj_gradientColorWithColors:(NSArray *)colors type:(ZBJGradietColorType)type size:(CGSize)size;
/// 随机颜色
+ (UIColor *)zbj_randomColor;
@end

NS_ASSUME_NONNULL_END
