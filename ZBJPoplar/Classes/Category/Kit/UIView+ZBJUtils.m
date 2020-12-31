//
//  UIView+ZBJUtils.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import "UIView+ZBJUtils.h"

@implementation UIView (ZBJUtils)

- (CGFloat)zbj_x {
    return self.frame.origin.x;
}

- (void)setZbj_x:(CGFloat)zbj_x {
    CGRect frame = self.frame;
    frame.origin.x = zbj_x;
    self.frame = frame;
}

- (CGFloat)zbj_y {
    return self.frame.origin.y;
}

- (void)setZbj_y:(CGFloat)zbj_y {
    CGRect frame = self.frame;
    frame.origin.y = zbj_y;
    self.frame = frame;
}

- (CGFloat)zbj_width {
    return self.frame.size.width;
}

- (void)setZbj_width:(CGFloat)zbj_width {
    CGRect frame = self.frame;
    frame.size.width = zbj_width;
    self.frame = frame;
}

- (CGFloat)zbj_height {
    return self.frame.size.height;
}

- (void)setZbj_height:(CGFloat)zbj_height {
    CGRect frame = self.frame;
    frame.size.height = zbj_height;
    self.frame = frame;
}

- (CGPoint)zbj_origin {
    return self.frame.origin;
}

- (void)setZbj_origin:(CGPoint)zbj_origin {
    CGRect frame = self.frame;
    frame.origin = zbj_origin;
    self.frame = frame;
}

- (CGSize)zbj_size {
    return self.frame.size;
}

- (void)setZbj_size:(CGSize)zbj_size {
    CGRect frame = self.frame;
    frame.size = zbj_size;
    self.frame = frame;
}

- (CGFloat)zbj_aspectScaledHeight {
    return self.frame.size.height;
}

- (void)setZbj_aspectScaledHeight:(CGFloat)zbj_aspectScaledHeight {
    self.zbj_width = self.zbj_width * zbj_aspectScaledHeight / self.zbj_height;
    self.zbj_height = zbj_aspectScaledHeight;
}

- (CGFloat)zbj_aspectScaledWidth {
    return self.frame.size.width;
}

- (void)setZbj_aspectScaledWidth:(CGFloat)zbj_aspectScaledWidth {
    self.zbj_width = self.zbj_height * zbj_aspectScaledWidth / self.zbj_width;
    self.zbj_height = zbj_aspectScaledWidth;
}

@dynamic zbj_borderColor, zbj_borderWidth, zbj_cornerRadius;
- (void)setZbj_borderColor:(UIColor *)zbj_borderColor {
    [self.layer setBorderColor:zbj_borderColor.CGColor];
}

- (void)setZbj_borderWidth:(CGFloat)zbj_borderWidth {
    NSAssert(zbj_borderWidth > 0, @"zbj_borderWidth 应该大于0");
    [self.layer setBorderWidth:zbj_borderWidth];
}

- (void)setZbj_cornerRadius:(CGFloat)zbj_cornerRadius {
    NSAssert(zbj_cornerRadius > 0, @"zbj_cornerRadius 应该大于0");
    [self.layer setCornerRadius:zbj_cornerRadius];
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
}

- (CGFloat)zbj_screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.zbj_x;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)zbj_screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.zbj_y;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (UIViewController *)zbj_currentViewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    
    return nil;
}

- (UIViewController *)zbj_topViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)vc;
        UINavigationController *nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UIViewController *nav = (UIViewController *)vc;
        result = nav.childViewControllers.lastObject;
    } else {
        result = vc;
    }
    
    return result;
}

- (void)zbj_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CAGradientLayer *)zbj_gradientLayerWithColors:(NSArray *)colors frame:(CGRect)frame locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (colors == nil || [colors isKindOfClass:[NSNull class]] || colors.count == 0) {
        return nil;
    }
    if (locations == nil || [locations isKindOfClass:[NSNull class]] || locations.count == 0) {
        return nil;
    }
    NSMutableArray *colorsArr = [NSMutableArray new];
    for (UIColor *color in colors) {
        if ([color isKindOfClass:[UIColor class]]) {
            [colorsArr addObject:(__bridge id)color.CGColor];
        }
    }
    gradientLayer.colors = colorsArr;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame =  frame;
    
    return gradientLayer;
}

- (void)zbj_gradientBgColorWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [self zbj_gradientLayerWithColors:colors frame:self.bounds locations:locations startPoint:startPoint endPoint:endPoint];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)zbj_dashBorderWithLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceArray:(NSArray<NSNumber*>*)spaceArray {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    if (self.layer.cornerRadius > 0) {
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    } else {
        borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    }
    borderLayer.lineWidth = lineWidth / [UIScreen mainScreen].scale;
    borderLayer.lineDashPattern = spaceArray;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
