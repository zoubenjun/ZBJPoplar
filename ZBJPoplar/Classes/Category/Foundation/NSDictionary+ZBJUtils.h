//
//  NSDictionary+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZBJUtils)

- (NSArray *)zbj_allKeysSorted;
- (NSArray *)zbj_allValuesSortedByKeys;
- (BOOL)zbj_containsObjectForKey:(id)key;

- (BOOL)zbj_boolValueForKey:(NSString *)key default:(BOOL)def;

- (char)zbj_charValueForKey:(NSString *)key default:(char)def;
- (unsigned char)zbj_unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)zbj_shortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)zbj_unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)zbj_intValueForKey:(NSString *)key default:(int)def;
- (unsigned int)zbj_unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)zbj_longValueForKey:(NSString *)key default:(long)def;
- (unsigned long)zbj_unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)zbj_longLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)zbj_unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)zbj_floatValueForKey:(NSString *)key default:(float)def;
- (double)zbj_doubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)zbj_integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)zbj_unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (nullable NSNumber *)zbj_numberValueForKey:(NSString *)key default:(nullable NSNumber *)def;
- (nullable NSString *)zbj_stringValueForKey:(NSString *)key default:(nullable NSString *)def;

@end

NS_ASSUME_NONNULL_END
