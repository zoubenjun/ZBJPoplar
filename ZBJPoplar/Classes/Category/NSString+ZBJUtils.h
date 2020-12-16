//
//  NSString+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZBJUtils)
- (NSString *)subStringFrom:(NSUInteger)begin to:(NSUInteger)end;
- (NSString *)removeSubString:(NSString *)subString;
- (BOOL)onlyLetters;
- (BOOL)onlyNumbers;
- (BOOL)onlyNumbersAndLetters;
- (BOOL)isValidEmail;
- (BOOL)isValidUrl;
- (BOOL)isValidatedChineseID:(NSString *)idcard;
- (NSString *)urlEncode;
- (NSString *)urlDecode;
- (NSString *)base64UrlEncode;
- (NSString *)base64UrlDecode;
- (NSString *)md5;
@end

NS_ASSUME_NONNULL_END
