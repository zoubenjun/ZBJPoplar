//
//  UILabel+ZBJUtils.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import "UILabel+ZBJUtils.h"

@implementation UILabel (ZBJUtils)

+ (UILabel *)zbj_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor {
    return [[self class] zbj_labelWithFrame:frame font:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)zbj_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    if (frame.size.height < font.lineHeight) {
        frame.size.height = ceil(font.lineHeight);
    }
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}

+ (UILabel *)zbj_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [[self class] zbj_labelWithFrame:CGRectZero font:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)zbj_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    return [[self class] zbj_labelWithFrame:CGRectZero font:font textColor:textColor textAlignment:textAlignment];
}

@end
