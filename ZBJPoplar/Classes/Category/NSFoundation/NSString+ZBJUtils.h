//
//  NSString+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZBJUtils)
/// 获取subString
/// @param begin 开始下标
/// @param end 结束下标
- (NSString *)zbj_subStringFrom:(NSUInteger)begin to:(NSUInteger)end;
/// 删除subString
/// @param subString 被删除的字符串
- (NSString *)zbj_removeSubString:(NSString *)subString;
/// 只包含字母
- (BOOL)zbj_onlyLetters;
/// 只包含数字
- (BOOL)zbj_onlyNumbers;
/// 只有数字和字母
- (BOOL)zbj_onlyNumbersAndLetters;
/// 验证邮箱格式
- (BOOL)zbj_isValidEmail;
/// 验证url格式
- (BOOL)zbj_isValidUrl;
/// 验证身份证格式
- (BOOL)zbj_isValidatedChineseID;
/// urlEncode
- (NSString *)zbj_urlEncode;
/// urlDecode
- (NSString *)zbj_urlDecode;
/// urlEncode & base64Encode
- (NSString *)zbj_base64UrlEncode;
/// base64Decode & urlDecode
- (NSString *)zbj_base64UrlDecode;
/// md5
- (NSString *)zbj_md5;
@end

NS_ASSUME_NONNULL_END
