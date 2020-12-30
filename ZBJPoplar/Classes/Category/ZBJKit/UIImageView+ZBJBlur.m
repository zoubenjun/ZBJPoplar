//
//  UIImageView+ZBJBlur.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/30.
//

#import "UIImageView+ZBJBlur.h"

@implementation UIImageView (ZBJBlur)

- (void)zbj_gaussianBlurWithImage:(UIImage *)image blur:(CGFloat)blur {
    __weak __typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
        CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp" keysAndValues:kCIInputImageKey,ciimage,nil];
        CIImage *clampResult = [clampFilter valueForKey:kCIOutputImageKey];
        
        CIFilter *gaussianFilter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey,clampResult,nil];
        [gaussianFilter setValue:@(blur) forKey:kCIInputRadiusKey];
        CIImage *gaussianResult = [gaussianFilter valueForKey:kCIOutputImageKey];
        
        CGImageRef cgImage = [context createCGImage:gaussianResult fromRect:[ciimage extent]];
        UIImage *newImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.image = newImage;
        });
    });
}

- (void)zbj_effectBlurWithImage:(UIImage *)image blurStyle:(UIBlurEffectStyle)blurStyle {
    self.image = image;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
}

@end
