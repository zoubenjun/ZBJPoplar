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
/// 汉字转拼音
- (NSString *)zbj_pinyin;
/// 计算字符串size
/// @param attributes attributes
/// @param maxSize 最大宽高
- (CGSize)zbj_sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize;
/// 计算字符串size
/// @param font 字体
/// @param maxSize 最大宽高
- (CGSize)zbj_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/// 计算字符串size
/// @param font 字体
/// @param lineBreakMode NSLineBreakMode
/// @param maxWidth 最大宽度
- (CGSize)zbj_sizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxWidth:(CGFloat)maxWidth;
/// 计算字符串高度
/// @param font 字体
/// @param lineBreakMode NSLineBreakMode
/// @param maxWidth 最大宽度
- (CGFloat)zbj_heightWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxWidth:(CGFloat)maxWidth;
/// 计算字符串宽度
/// @param font 字体
/// @param lineBreakMode NSLineBreakMode
/// @param maxHeight 最大高度
- (CGFloat)zbj_widthWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxHeight:(CGFloat)maxHeight;
/// 计算字符串size
/// @param font 字体
/// @param size 最大宽高
/// @param alignment 对齐方式
/// @param linebreakMode NSLineBreakMode
/// @param lineSpace 行间距
/// @param maxLinesNum 最多几行
- (CGSize)zbj_sizeWithFont:(UIFont*)font size:(CGSize)size alignment:(NSTextAlignment)alignment linebreakMode:(NSLineBreakMode)linebreakMode lineSpace:(CGFloat)lineSpace maxLinesNum:(NSInteger)maxLinesNum;
@end

NS_ASSUME_NONNULL_END
