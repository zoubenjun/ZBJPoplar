//
//  UIView+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZBJUtils)
@property (nonatomic, assign) CGFloat zbj_x;//self.frame.origin.x
@property (nonatomic, assign) CGFloat zbj_y;//self.frame.origin.y
@property (nonatomic, assign) CGFloat zbj_width;//self.frame.size.width
@property (nonatomic, assign) CGFloat zbj_height;//self.frame.size.height
@property (nonatomic, assign) CGPoint zbj_origin;//self.frame.origin
@property (nonatomic, assign) CGSize zbj_size;//self.frame.size
@property (nonatomic, assign) CGFloat zbj_aspectScaledHeight;//根据设置的高度，按以前比列修改宽度，宽高都会改变
@property (nonatomic, assign) CGFloat zbj_aspectScaledWidth;//根据设置的宽度，按以前比列修改高度，宽高都会改变
@property (nonatomic, strong) UIColor *zbj_borderColor;//layer对应的属性
@property (nonatomic, assign) CGFloat zbj_borderWidth;//layer对应的属性
@property (nonatomic, assign) CGFloat zbj_cornerRadius;//layer对应的属性
@property (nonatomic, assign, readonly) CGFloat zbj_screenViewX;//到屏幕的x距离
@property (nonatomic, assign, readonly) CGFloat zbj_screenViewY;//到屏幕的y距离
@property (nonatomic, strong, readonly) UIViewController *zbj_currentViewController;//当前view所在的ViewController
@property (nonatomic, strong, readonly) UIViewController *zbj_topViewController;//当前view的最上层ViewController

/// 删除所有子view
- (void)zbj_removeAllSubviews;
/// 添加渐变背景
/// @param colors 渐变颜色数组
/// @param locations 渐变颜色的分割点
/// @param startPoint 渐变颜色起点
/// @param endPoint 渐变颜色终点
- (void)zbj_gradientBgColorWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/// 虚线边框
/// @param lineColor 虚线颜色
/// @param lineWidth 虚线宽度
/// @param spaceArray 虚线长度和间隔长度
- (void)zbj_dashBorderWithLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceArray:(NSArray<NSNumber*>*)spaceArray;
@end

NS_ASSUME_NONNULL_END
