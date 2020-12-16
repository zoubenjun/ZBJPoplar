//
//  NSString+ZBJUtils.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/16.
//

#import "NSString+ZBJUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZBJUtils)

- (NSString *)subStringFrom:(NSUInteger)begin to:(NSUInteger)end {
    NSRange range;
    range.location = begin;
    range.length = end - begin;
    return [self substringWithRange:range];
}

- (NSString *)removeSubString:(NSString *)subString {
    if ([self containsString:subString]) {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

- (BOOL)onlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)onlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)onlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

- (BOOL)isValidEmail {
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

- (BOOL)isValidUrl {
    NSURL *url = [NSURL URLWithString:self];
    if(url) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidatedChineseIDFormart:(NSString *)idcard {
    NSString *nullRegex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([\\d|x|X]{1})$";
    NSPredicate *nullPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nullRegex];
    return [nullPredicate evaluateWithObject:idcard];
}

- (BOOL)isValidatedChineseID:(NSString *)idcard {
    if (![self isValidatedChineseIDFormart:idcard]) {
        return NO;
    }
    
    NSArray *power = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSArray *verifyCode = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    // 获取前17位
    NSString *idcard17 = [idcard substringToIndex:17];
    NSMutableArray *c = [NSMutableArray new];
    const char *chars = idcard17.UTF8String;
    for(NSInteger i = 0; i < idcard17.length; i++) {
        [c addObject:[NSString stringWithFormat:@"%c",chars[i]]];
    }
    
    // 校验位
    NSString *idcard18Code = [[idcard substringWithRange:NSMakeRange(17, 1)] lowercaseString];
    
    NSInteger sum17 = 0;
    for (NSInteger i = 0; i < c.count; i++) {
        sum17 = sum17 + [c[i] integerValue] * [power[i] integerValue];
    }
    // 获取和值与11取模得到余数进行校验码
    NSString *checkCode = verifyCode[sum17 % 11];
    if(![idcard18Code isEqualToString:checkCode]) {
        return NO;
    }
        
    return YES;
}

- (NSString *)urlEncode {
//    NSCharacterSet *URLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"#%/:<>?@[\\]^`{|}"] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)urlDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)base64UrlEncode {
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

- (NSString *)base64UrlDecode {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
