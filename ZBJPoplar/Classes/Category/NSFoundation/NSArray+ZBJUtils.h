//
//  NSArray+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/15.
//

#import <Foundation/Foundation.h>

typedef void(^ZBJEnumerateBlock)(NSInteger index, id _Nullable obj);
typedef id _Nullable (^ZBJTransformBlock)(id _Nullable obj);
typedef BOOL (^ZBJValidationBlock)(id _Nullable obj);
typedef id _Nullable (^ZBJAccumulationBlock)(id _Nullable sum, id _Nullable obj);

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZBJUtils)
/// each 遍历数组内容，返回index和对应元素
/// @param block 在block 返回
- (void)zbj_each:(ZBJEnumerateBlock)block;
/// map 数据转换
/// @param block 转换block
/// @return 转换后的数组
- (NSArray *)zbj_map:(ZBJTransformBlock)block;
/// matchFirst 找到满足条件的第一个数据
/// @param block 筛选block
/// @return 筛选结果
- (id)zbj_matchFirst:(ZBJValidationBlock)block;
/// matchAll 找到满足条件的所有数据
/// @param block 筛选block
/// @return 筛选后的数组
- (NSArray *)zbj_matchAll:(ZBJValidationBlock)block;
/// reduce 计算
/// @param initial 初始值
/// @param block 计算block
/// @return 计算后的值
- (id)zbj_reduce:(id)initial withBlock:(ZBJAccumulationBlock)block;
/// allObjectsMatched 是否全部都满足筛选条件
/// @param block 筛选block
/// @return 全部匹配 YES 否则 NO
- (BOOL)zbj_allObjectsMatched:(ZBJValidationBlock)block;
/// anyObjectsMatched 是否有一个满足筛选条件
/// @param block 筛选block
/// @return 有一个匹配 YES 否则 NO
- (BOOL)zbj_anyObjectMatched:(ZBJValidationBlock)block;
/// join 连接数组 必须是字符串数组才能使用，建议直接使用NSArray 的 componentsJoinedByString
/// @param seperator 分隔符
/// @return 返回一个字符串
- (NSString *)zbj_join:(NSString *)seperator;
/// groupBy 分组
/// @param block 分组条件
/// @return 分组后的数组
- (NSArray *)zbj_groupBy:(ZBJTransformBlock)block;
/// seprate 按长度分组
/// @param length 长度
/// @return 分组后的数组
- (NSArray *)zbj_seprate:(NSInteger)length;
/// flatten 把多维数组变成一维数组
/// @return 一维数组
- (NSArray *)zbj_flatten;
@end

NS_ASSUME_NONNULL_END
