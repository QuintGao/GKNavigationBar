//
//  GKNavigationBarConfigure.m
//  GKNavigationBar
//
//  Created by QuintGao on 2019/10/27.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "GKNavigationBarConfigure.h"
#import "GKNavigationBarDefine.h"
#import "UIImage+GKCategory.h"

@interface GKNavigationBarConfigure()

@property (nonatomic, assign) CGFloat navItemLeftSpace;
@property (nonatomic, assign) CGFloat navItemRightSpace;

@end

@implementation GKNavigationBarConfigure

+ (instancetype)sharedInstance {
    static GKNavigationBarConfigure *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [GKNavigationBarConfigure new];
    });
    return instance;
}

- (void)setupDefaultConfigure {
    self.backgroundColor = [UIColor whiteColor];
    self.lineHidden = NO;
    
    self.titleColor = [UIColor blackColor];
    self.titleFont = [UIFont boldSystemFontOfSize:17.0f];
    
    self.backStyle = GKNavigationBarBackStyleBlack;
    self.gk_disableFixSpace = NO;
    self.gk_navItemLeftSpace = 0;
    self.gk_navItemRightSpace = 0;
    self.navItemLeftSpace = 0;
    self.navItemRightSpace = 0;
    
    self.statusBarHidden = NO;
    self.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupCustomConfigure:(void (^)(GKNavigationBarConfigure * _Nonnull))block {
    [self setupDefaultConfigure];
    
    !block ? : block(self);
    
    self.navItemLeftSpace  = self.gk_navItemLeftSpace;
    self.navItemRightSpace = self.gk_navItemRightSpace;
}

- (void)updateConfigure:(void (^)(GKNavigationBarConfigure * _Nonnull))block {
    !block ? : block(self);
}

- (UIViewController *)visibleViewController {
    return [[GKConfigure getKeyWindow].rootViewController gk_visibleViewControllerIfExist];
}

- (UIEdgeInsets)gk_safeAreaInsets {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [GKConfigure getKeyWindow];
        if (keyWindow) {
            safeAreaInsets = keyWindow.safeAreaInsets;
        }else { // 如果获取到的window是空
            // 对于刘海屏，当window没有创建的时候，可根据状态栏设置安全区域顶部高度
            // iOS14之后顶部安全区域不再是固定的44，所以修改为以下方式获取
            if ([GKConfigure gk_isNotchedScreen]) {
                safeAreaInsets = UIEdgeInsetsMake([GKConfigure gk_statusBarFrame].size.height, 0, 34, 0);
            }
        }
    }
    return safeAreaInsets;
}

- (CGRect)gk_statusBarFrame {
    CGRect statusBarFrame = CGRectZero;
    if (@available(iOS 13.0, *)) {
        statusBarFrame = [GKConfigure getKeyWindow].windowScene.statusBarManager.statusBarFrame;
    }
    
    if (CGRectEqualToRect(statusBarFrame, CGRectZero)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
#pragma clang diagnostic pop
    }
    
    if (CGRectEqualToRect(statusBarFrame, CGRectZero)) {
        CGFloat statusBarH = [GKConfigure gk_isNotchedScreen] ? 44 : 20;
        statusBarFrame = CGRectMake(0, 0, GK_SCREEN_WIDTH, statusBarH);
    }
    
    return statusBarFrame;
}

- (BOOL)gk_isNotchedScreen {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [self getKeyWindow];
        if (keyWindow) {
            return keyWindow.safeAreaInsets.bottom > 0;
        }
    }
    
    // 当iOS11以下或获取不到keyWindow时用以下方案
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    return (CGSizeEqualToSize(screenSize, CGSizeMake(375, 812)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(812, 375)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(414, 896)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(896, 414)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(390, 844)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(844, 390)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(428, 926)) ||
            CGSizeEqualToSize(screenSize, CGSizeMake(926, 428)));
}

- (CGFloat)gk_fixedSpace {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return MIN(screenSize.width, screenSize.height) > 375.0f ? 20.0f : 16.0f;
}

- (UIWindow *)getKeyWindow {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *w in windowScene.windows) {
                    if (window.isKeyWindow) {
                        window = w;
                        break;
                    }
                }
            }
        }
    }
    
    if (!window) {
        window = [UIApplication sharedApplication].windows.firstObject;
        if (!window.isKeyWindow) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
#pragma clang diagnostic pop
            if (CGRectEqualToRect(keyWindow.bounds, UIScreen.mainScreen.bounds)) {
                window = keyWindow;
            }
        }
    }
    return window;
}


@end
