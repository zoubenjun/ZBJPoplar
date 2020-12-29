//
//  UILabel+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZBJUtils)
/// 初始化
/// @param frame frame
/// @param font font
/// @param textColor textColor
+ (UILabel *)zbj_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor;
/// 初始化
/// @param frame frame
/// @param font font
/// @param textColor textColor
/// @param textAlignment textAlignment
+ (UILabel *)zbj_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
/// 初始化
/// @param font font
/// @param textColor textColor
+ (UILabel *)zbj_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
/// 初始化
/// @param font font
/// @param textColor textColor
/// @param textAlignment textAlignment
+ (UILabel *)zbj_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
@end

NS_ASSUME_NONNULL_END
