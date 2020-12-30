//
//  UIColor+ZBJUitls.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import "UIColor+ZBJUitls.h"

@implementation UIColor (ZBJUitls)

+ (UIColor *)zbj_colorWithHexString:(NSString *)hexString {
    return [[self class] zbj_colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)zbj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSAssert([hexString isKindOfClass:NSString.class], @"zbj_colorWithHexString的参数：hexString 应该是NSString类型！");
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符

    colorString = [[colorString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    colorString = [colorString stringByReplacingOccurrencesOfString: @"0X" withString: @""];
    unsigned int rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] zbj_colorWithHexValue:rgbValue alpha:alpha];
}

+ (UIColor *)zbj_colorWithHexValue:(unsigned int)hexValue {
    return [[self class] zbj_colorWithHexValue:hexValue alpha:1.0];
}

+ (UIColor *)zbj_colorWithHexValue:(unsigned int)hexValue alpha:(CGFloat)alpha {
    return [[self class] zbj_colorWithRed:((hexValue & 0xFF0000) >> 16) green:((hexValue & 0xFF00) >> 8) blue:(hexValue & 0xFF) alpha:alpha];
}

+ (UIColor *)zbj_colorWithRed:(float)red green:(float)green blue:(float)blue {
    return [[self class] zbj_colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)zbj_colorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)zbj_gradientColorWithColors:(NSArray *)colors type:(ZBJGradietColorType)type size:(CGSize)size {
    NSParameterAssert(colors.count > 1);
    NSMutableArray *temps = [NSMutableArray array];
    for(UIColor *c in colors){
        [temps addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)temps, NULL);
    temps = nil;
    CGPoint start = CGPointMake(0.0, 0.0), end = CGPointMake(0.0, 1);
    switch (type) {
        case ZBJGradietColorTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 0.0);
            break;
        case ZBJGradietColorTypeLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case ZBJGradietColorTypeRightTopToLeftBottom:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)zbj_randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
}

@end
