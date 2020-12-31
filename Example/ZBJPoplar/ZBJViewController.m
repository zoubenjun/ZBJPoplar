//
//  ZBJViewController.m
//  ZBJPoplar
//
//  Created by 502153525@qq.com on 12/15/2020.
//  Copyright (c) 2020 502153525@qq.com. All rights reserved.
//

#import "ZBJViewController.h"
#import "ZBJPoplar.h"

@interface ZBJViewController ()

@end

@implementation ZBJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"a", @"b", @"c", @"d", @[@"e", @"f", @[@"g", @"h"]], @[@"i", @"j", @[@"K"]]];
    [arr zbj_map:^id _Nullable(id  _Nullable obj) {
        return [NSString stringWithFormat:@"zbj_%@",obj];
    }];
    
    UIColor *color = [UIColor zbj_colorWithHexString:@"FF00FF"];
    NSLog(@"%@", color);
    
    [self blur];
}

- (void)blur {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    //    [ZBJBlur zbj_blurImageView:imgView blurType:(ZBJImageBlurTypevImage) blurImage:[UIImage imageNamed:@"image"] blurRadius:0.7];
//    [ZBJBlur zbj_blurImageView:imgView blurType:(ZBJImageBlurTypeMask) blurImage:[UIImage imageNamed:@"image"] blurRadius:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
