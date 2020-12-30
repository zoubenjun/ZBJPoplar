//
//  ZBJSystemInfo.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/30.
//

#import <Foundation/Foundation.h>
#import "ZBJMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBJSystemInfo : NSObject

@property (nonatomic, copy, readonly) NSString *bundleID;
@property (nonatomic, copy, readonly) NSString *bundleName;
@property (nonatomic, copy, readonly) NSString *bundleDisplayName;
@property (nonatomic, copy, readonly) NSString *bundleVersion;
@property (nonatomic, copy, readonly) NSString *bundleShortVersion;
@property (nonatomic, copy, readonly) NSString *uuid;
@property (nonatomic, copy, readonly) NSString *idfa;
@property (nonatomic, copy, readonly) NSString *deviceLanguage;
@property (nonatomic, copy, readonly) NSString *platform;
@property (nonatomic, copy, readonly) NSString *systemVersion;
@property (nonatomic, copy, readonly) NSString *cpuType;
@property (nonatomic, copy, readonly) NSString *osVersion;
@property (nonatomic, assign, readonly) pid_t processID;
@property (nonatomic, copy, readonly) NSString *processName;
@property (nonatomic, assign, readonly) pid_t parentProcessID;
@property (nonatomic, copy, readonly) NSString *parentProcessName;
@property (atomic, assign, readonly) BOOL isForeground;

kSingleton_H(SystemInfo);

@end

NS_ASSUME_NONNULL_END
