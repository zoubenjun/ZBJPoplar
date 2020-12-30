//
//  ZBJMacros.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/30.
//

#ifndef ZBJMacros_h
#define ZBJMacros_h
#import <objc/message.h>

#pragma mark -- UIApplication

#define kApplication        ([UIApplication sharedApplication])
#define kKeyWindow          ([UIApplication sharedApplication].keyWindow)
#define kAppDelegate        ([UIApplication sharedApplication].delegate)

#pragma mark --

#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
#define kBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil

#pragma mark -- 屏幕尺寸

#define iPhoneXOrLater ({BOOL isiPhoneXOrLater = NO;\
if (@available(iOS 13.0, *)) {\
isiPhoneXOrLater = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom > 0.0;\
} else if (@available(iOS 11.0, *)) {\
isiPhoneXOrLater = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isiPhoneXOrLater);})

#define kTableBarHeight         (iPhoneXOrLater ? (49.f+34.f):49.f)
#define kStatusBarHeight        (iPhoneXOrLater ? 44.0f : 20.f)
#define kNavigationBarHeight    (kStatusBarHeight + 44.f)
#define kBottomSafeHeight       (iPhoneXOrLater ? 34.0f : 0.0f)

#define kScreenSize             ([UIScreen mainScreen].bounds.size)
#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([UIScreen mainScreen].bounds.size.height)
#define kScreenBounds           CGRectMake(0, 0, kScreenWidth, kScreenHeight)

#define kScaleWidth(w)          (w * kScreenWidth / 375.0)
#define kScaleHeight(h)         (h * kScreenHeight / 667.0)

#pragma mark -- weak,strong

#define weakself WeakObj(self)
#define strongself StrongObj(self)

#ifndef WeakObj
#if DEBUG
#if __has_feature(objc_arc)
#define WeakObj(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define WeakObj(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define WeakObj(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define WeakObj(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef StrongObj
#if DEBUG
#if __has_feature(objc_arc)
#define StrongObj(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define StrongObj(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define StrongObj(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define StrongObj(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#pragma mark -- 单例
/*
 使用方法:
 .h文件
 kSingleton_H(类名)
 .m文件
 kSingleton_M(类名)
*/
#define kSingleton_H(className) \
+ (instancetype)shared##className;

#if __has_feature(objc_arc)
#define kSingleton_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
#define kSingleton_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}
#endif

#pragma mark - 内联函数
/// 字典转Json字符串
NS_INLINE NSString * kDictionaryToJson(NSDictionary *dict){
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
/// 数组转Json字符串
NS_INLINE NSString * kArrayToJson(NSArray *array){
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonTemp;
}
/// Json字符串转字典
NS_INLINE NSDictionary *kJsonToDictionary(NSString *string){
    if (string == nil) return nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    return dic;
}
/// 校正ScrollView的偏移问题
NS_INLINE void kAdjustsScrollViewInsetNever(UIViewController *viewController, __kindof UIScrollView *scrollView) {
#if __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        viewController.automaticallyAdjustsScrollViewInsets = false;
    }
#else
    viewController.automaticallyAdjustsScrollViewInsets = false;
#endif
}

/// 交换方法的实现
NS_INLINE void kMethodSwizzling(Class clazz, SEL original, SEL swizzled) {
    Method method = class_getInstanceMethod(clazz, original);
    Method swmethod = class_getInstanceMethod(clazz, swizzled);
    if (class_addMethod(clazz, original, method_getImplementation(swmethod), method_getTypeEncoding(swmethod))) {
        class_replaceMethod(clazz, swizzled, method_getImplementation(method), method_getTypeEncoding(method));
    } else {
        method_exchangeImplementations(method, swmethod);
    }
}

#endif /* ZBJMacros_h */
