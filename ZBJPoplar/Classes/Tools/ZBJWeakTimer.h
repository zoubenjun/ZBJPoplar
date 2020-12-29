//
//  ZBJWeakTimer.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJWeakTimer : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
