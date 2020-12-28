//
//  UIControl+ZBJBlock.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/28.
//

#import "UIControl+ZBJBlock.h"
#import <objc/runtime.h>

static const void *ZBJControlActionsKey = &ZBJControlActionsKey;

#pragma mark Private

@interface ZBJControlTarget : NSObject <NSCopying>

- (id)initWithAction:(void (^)(id sender))action forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^action)(id sender);

@end

@implementation ZBJControlTarget

- (id)initWithAction:(void (^)(id sender))action forControlEvents:(UIControlEvents)controlEvents {
    self = [super init];
    if (!self) return nil;

    self.action = action;
    self.controlEvents = controlEvents;

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[ZBJControlTarget alloc] initWithAction:self.action forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
    self.action(sender);
}

@end


@implementation UIControl (ZBJBlock)

- (void)zbj_addAction:(void (^)(id sender))action forControlEvents:(UIControlEvents)controlEvents {
    NSParameterAssert(action);
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, ZBJControlActionsKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, ZBJControlActionsKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSNumber *key = @(controlEvents);
    NSMutableSet *actions = events[key];
    if (!actions) {
        actions = [NSMutableSet set];
        events[key] = actions;
    }
    
    ZBJControlTarget *target = [[ZBJControlTarget alloc] initWithAction:action forControlEvents:controlEvents];
    [actions addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)zbj_removeActionsForControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = objc_getAssociatedObject(self, ZBJControlActionsKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, ZBJControlActionsKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSNumber *key = @(controlEvents);
    NSSet *actions = events[key];

    if (!actions) {
        return;
    }

    [actions enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];

    [events removeObjectForKey:key];
}

@end
