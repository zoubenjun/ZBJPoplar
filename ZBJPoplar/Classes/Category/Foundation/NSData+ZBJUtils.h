//
//  NSData+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZBJUtils)
/// md5
- (NSString *)zbj_md5String;
- (NSData *)zbj_md5Data;
- (nullable NSString *)zbj_utf8String;
- (NSString *)zbj_base64EncodedString;
+ (NSData *)zbj_dataWithBase64EncodedString:(NSString *)base64EncodedString;
/// 解压gzip
- (nullable NSData *)gzipInflate;
/// 压缩gzip
- (nullable NSData *)gzipDeflate;
/// 解压zlib
- (nullable NSData *)zlibInflate;
/// 压缩zlib
- (nullable NSData *)zlibDeflate;
@end

NS_ASSUME_NONNULL_END
