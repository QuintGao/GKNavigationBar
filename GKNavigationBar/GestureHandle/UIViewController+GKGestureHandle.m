//
//  UIViewController+GKGestureHandle.m
//  GKNavigationBarExample
//
//  Created by gaokun on 2020/10/29.
//  Copyright © 2020 QuintGao. All rights reserved.
//

#import "UIViewController+GKGestureHandle.h"
#import "GKGestureHandleDefine.h"

NSString *const GKViewControllerPropertyChangedNotification = @"GKViewControllerPropertyChangedNotification";

@implementation UIViewController (GKGestureHandle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray <NSString *> *oriSels = @[@"viewDidAppear:"];
        
        [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull oriSel, NSUInteger idx, BOOL * _Nonnull stop) {
            gk_gestureHandle_swizzled_instanceMethod(@"gk", self, oriSel, self);
        }];
    });
}

- (void)gk_viewDidAppear:(BOOL)animated {
    [self postPropertyChangeNotification];

    [self gk_viewDidAppear:animated];
}

static char kAssociatedObjectKey_interactivePopDisabled;
- (void)setGk_interactivePopDisabled:(BOOL)gk_interactivePopDisabled {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_interactivePopDisabled, @(gk_interactivePopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self postPropertyChangeNotification];
}

- (BOOL)gk_interactivePopDisabled {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_interactivePopDisabled) boolValue];
}

static char kAssociatedObjectKey_fullScreenPopDisabled;
- (void)setGk_fullScreenPopDisabled:(BOOL)gk_fullScreenPopDisabled {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_fullScreenPopDisabled, @(gk_fullScreenPopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self postPropertyChangeNotification];
}

- (BOOL)gk_fullScreenPopDisabled {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_fullScreenPopDisabled) boolValue];
}

static char kAssociatedObjectKey_maxPopDistance;
- (void)setGk_maxPopDistance:(CGFloat)gk_maxPopDistance {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_maxPopDistance, @(gk_maxPopDistance), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self postPropertyChangeNotification];
}

- (CGFloat)gk_maxPopDistance {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_maxPopDistance) floatValue];
}

static char kAssociatedObjectKey_pushDelegate;
- (void)setGk_pushDelegate:(id<GKViewControllerPushDelegate>)gk_pushDelegate {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_pushDelegate, gk_pushDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self postPropertyChangeNotification];
}

- (id<GKViewControllerPushDelegate>)gk_pushDelegate {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_pushDelegate);
}

static char kAssociatedObjectKey_popDelegate;
- (void)setGk_popDelegate:(id<GKViewControllerPopDelegate>)gk_popDelegate {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_popDelegate, gk_popDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self postPropertyChangeNotification];
}

- (id<GKViewControllerPopDelegate>)gk_popDelegate {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_popDelegate);
}

static char kAssociatedObjectKey_pushTransition;
- (id<UIViewControllerAnimatedTransitioning>)gk_pushTransition {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_pushTransition);
}

- (void)setGk_pushTransition:(id<UIViewControllerAnimatedTransitioning>)gk_pushTransition {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_pushTransition, gk_pushTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char kAssociatedObjectKey_popTransition;
- (id<UIViewControllerAnimatedTransitioning>)gk_popTransition {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_popTransition);
}

- (void)setGk_popTransition:(id<UIViewControllerAnimatedTransitioning>)gk_popTransition {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_popTransition, gk_popTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Private Methods
// 发送属性改变通知
- (void)postPropertyChangeNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:GKViewControllerPropertyChangedNotification object:@{@"viewController": self}];
}

@end
