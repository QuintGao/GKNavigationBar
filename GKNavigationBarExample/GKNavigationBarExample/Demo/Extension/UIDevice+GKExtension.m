//
//  UIDevice+GKExtension.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2025/1/22.
//  Copyright © 2025 QuintGao. All rights reserved.
//

#import "UIDevice+GKExtension.h"
#import <sys/utsname.h>

@implementation UIDevice (GKExtension)

+ (BOOL)gk_isDynamicIsland {
    static BOOL isDynamicIsland;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *keyWindow = nil;
        if (@available(iOS 13.0, *)) {
            NSSet *set = UIApplication.sharedApplication.connectedScenes;
            UIWindowScene *windowScene = [set anyObject];
            keyWindow = windowScene.windows.firstObject;
        }else {
            keyWindow = UIApplication.sharedApplication.keyWindow;
        }
        if (!keyWindow) {
            keyWindow = UIApplication.sharedApplication.windows.firstObject;
        }
        if (@available(iOS 11.0, *)) {
            if (keyWindow.safeAreaInsets.top >= 59) {
                isDynamicIsland = YES;
            }
        }
    });
    return isDynamicIsland;
}

+ (BOOL)gk_isNotchedScreen {
    static BOOL isNotchedScreen;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *keyWindow = nil;
        if (@available(iOS 13.0, *)) {
            NSSet *set = UIApplication.sharedApplication.connectedScenes;
            UIWindowScene *windowScene = [set anyObject];
            keyWindow = windowScene.windows.firstObject;
        }else {
            keyWindow = UIApplication.sharedApplication.keyWindow;
        }
        if (!keyWindow) {
            keyWindow = UIApplication.sharedApplication.windows.firstObject;
        }
        if (@available(iOS 11.0, *)) {
            if (keyWindow.safeAreaInsets.bottom >= 0) {
                isNotchedScreen = YES;
            }
        }
    });
    return isNotchedScreen;
}

+ (CGFloat)gk_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = UIApplication.sharedApplication.connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    }else {
        return UIApplication.sharedApplication.statusBarFrame.size.height;
    }
}

+ (CGFloat)gk_navBarHeight {
    return 44;
}

+ (CGFloat)gk_navBarFullHeight {
    CGFloat result = [self gk_statusBarHeight];
    CGFloat pixelOne = 1.0 / UIScreen.mainScreen.scale;
    if ([self gk_isDynamicIsland]) { // 灵动岛屏幕
        NSString *deviceModel = [self gk_deviceModel];
        if ([deviceModel isEqualToString:@"iPhone17,1"] || [deviceModel isEqualToString:@"iPhone17,2"]) { // 16 Pro / 16 Pro Max
            result += (2 + pixelOne); // 56.333
        }else {
            result -= pixelOne;  //53.667
        }
    }
    
    // 添加导航栏高度
    result += [self gk_navBarHeight];
    
    return result;
}

+ (NSString *)gk_deviceModel {
    if ([self gk_isSimulator]) {
        // Simulator doesn't return the identifier for the actual physical model, but returns it as an environment variable
        // 模拟器不返回物理机器信息，但会通过环境变量的方式返回
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    
    // See https://www.theiphonewiki.com/wiki/Models for identifiers
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

static NSInteger isSimulator = -1;
+ (BOOL)gk_isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}

@end
