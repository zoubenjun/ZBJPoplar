//
//  NSString+ZBJUtils.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/16.
//

#import "NSString+ZBJUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZBJUtils)

- (NSString *)zbj_subStringFrom:(NSUInteger)begin to:(NSUInteger)end {
    NSRange range;
    range.location = begin;
    range.length = end - begin;
    
    return [self substringWithRange:range];
}

- (NSString *)zbj_removeSubString:(NSString *)subString {
    if ([self containsString:subString]) {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return self;
}

- (BOOL)zbj_onlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)zbj_onlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)zbj_onlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

- (BOOL)zbj_isValidEmail {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)zbj_isValidUrl {
    NSURL *url = [NSURL URLWithString:self];
    if(url) {
        return YES;
    }
    
    return NO;
}

- (BOOL)zbj_isValidatedChineseIDFormart {
    NSString *nullRegex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([\\d|x|X]{1})$";
    NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nullRegex];
    
    return [nullPredicate evaluateWithObject:self];
}
- (BOOL)zbj_isValidatedChineseIDArea {
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15",
                           @"21", @"22", @"23",
                           @"31", @"32", @"33", @"34", @"35", @"36", @"37",
                           @"41", @"42", @"43", @"44", @"45", @"46",
                           @"50", @"51", @"52", @"53", @"54",
                           @"61", @"62", @"63", @"64", @"65",
                           @"71",
                           @"81", @"82",
                           @"91"];
    NSString *valueStart2 = [self substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray){
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    
    return areaFlag;
}

- (BOOL)zbj_isValidatedChineseIDCode {
    NSArray *power = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSArray *verifyCode = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    // 获取前17位
    NSString *idcard17 = [self substringToIndex:17];
    NSMutableArray *c = [NSMutableArray new];
    const char *chars = idcard17.UTF8String;
    for(NSInteger i = 0; i < idcard17.length; i++) {
        [c addObject:[NSString stringWithFormat:@"%c",chars[i]]];
    }
    
    // 校验位
    NSString *idcard18Code = [[self substringWithRange:NSMakeRange(17, 1)] lowercaseString];
    
    NSInteger sum17 = 0;
    for (NSInteger i = 0; i < c.count; i++) {
        sum17 = sum17 + [c[i] integerValue] * [power[i] integerValue];
    }
    // 获取和值与11取模得到余数进行校验码
    NSString *checkCode = verifyCode[sum17 % 11];
    
    return [idcard18Code isEqualToString:checkCode];
}

- (BOOL)zbj_isValidatedChineseID {
    //验证身份证号码格式，出生日期
    if (![self zbj_isValidatedChineseIDFormart]) {
        return NO;
    }
    
    //验证地区码
    if (![self zbj_isValidatedChineseIDArea]) {
        return NO;
    }
    
    //验证校验位
    if (![self zbj_isValidatedChineseIDCode]) {
        return NO;
    }
    
    return YES;
}

- (NSString *)zbj_urlEncode {
    //    NSCharacterSet *URLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"#%/:<>?@[\\]^`{|}"] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)zbj_urlDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)zbj_base64UrlEncode {
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return base64String;
}

- (NSString *)zbj_base64UrlDecode {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

- (NSString *)zbj_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)zbj_pinyin {
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    
    return [result uppercaseString];
}

- (CGSize)zbj_sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize {
    CGSize newSize = [self boundingRectWithSize:maxSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil].size;
    
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}

- (CGSize)zbj_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    return [self zbj_sizeWithAttributes:attributes maxSize:maxSize];
}

- (CGSize)zbj_sizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxWidth:(CGFloat)maxWidth {
    return [self zbj_sizeWithFont:font size:CGSizeMake(maxWidth, MAXFLOAT) alignment:(NSTextAlignmentLeft) linebreakMode:lineBreakMode lineSpace:0 maxLinesNum:NSIntegerMax];
}

- (CGFloat)zbj_heightWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxWidth:(CGFloat)maxWidth {
    return [self zbj_sizeWithFont:font lineBreakMode:lineBreakMode maxWidth:maxWidth].height;
}

- (CGFloat)zbj_widthWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxHeight:(CGFloat)maxHeight {
    return [self zbj_sizeWithFont:font size:CGSizeMake(MAXFLOAT, maxHeight) alignment:(NSTextAlignmentLeft) linebreakMode:lineBreakMode lineSpace:0 maxLinesNum:NSIntegerMax].width;
}

- (CGSize)zbj_sizeWithFont:(UIFont*)font size:(CGSize)size alignment:(NSTextAlignment)alignment linebreakMode:(NSLineBreakMode)linebreakMode lineSpace:(CGFloat)lineSpace maxLinesNum:(NSInteger)maxLinesNum {
    if (self.length == 0) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = linebreakMode;
    paragraphStyle.alignment = alignment;
    if (lineSpace > 0) {
        paragraphStyle.lineSpacing = lineSpace;
    }
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize s = [self zbj_sizeWithAttributes:attributes maxSize:size];
    CGFloat maxHeight = MAXFLOAT;
    if (maxLinesNum >= 1 && maxLinesNum != NSIntegerMax) {
        maxHeight = maxLinesNum * font.lineHeight + (maxLinesNum - 1) * lineSpace;
    }
    
    return CGSizeMake(s.width, MIN(s.height, maxHeight));
}

@end
