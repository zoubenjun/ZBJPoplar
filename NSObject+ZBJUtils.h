//
//  NSObject+ZBJUtils.h
//  ZBJPoplar
//
//  Created by zoubenjun on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZBJUtils)

- (id)zbj_deepCopy;

- (void)zbj_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;
- (void)zbj_removeObserverBlocksForKeyPath:(NSString*)keyPath;
- (void)zbj_removeObserverBlocks;

@end

NS_ASSUME_NONNULL_END
