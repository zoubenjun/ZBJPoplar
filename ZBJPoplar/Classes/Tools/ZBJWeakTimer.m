//
//  ZBJWeakTimer.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import "ZBJWeakTimer.h"

@interface ZBJWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end

@implementation ZBJWeakTimerTarget

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation ZBJWeakTimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    ZBJWeakTimerTarget* timerTarget = [[ZBJWeakTimerTarget alloc] init];
    timerTarget.target = target;
    timerTarget.selector = selector;
    timerTarget.timer = [NSTimer timerWithTimeInterval:interval target:timerTarget selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timerTarget.timer forMode:NSRunLoopCommonModes];
    
    return timerTarget.timer;
}

@end
