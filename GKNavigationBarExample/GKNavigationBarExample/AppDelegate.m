//
//  AppDelegate.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2019/11/2.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "AppDelegate.h"
#import "GKMainViewController.h"
#import "UIView+Extension.h"
#import "GKDemo007ViewController.h"
#import <math.h>
#import <sys/utsname.h>
#import "UIDevice+GKExtension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupNavBar];
    
    [self setupWindow];
    
//    CGFloat statusH = [UIDevice statusBarFullHeight];
//    CGFloat navbarH = [UIDevice navBarHeight];
//    CGFloat statusNavBarH = [UIDevice navBarFullHeight];
//    UIEdgeInsets safeInsets = [UIDevice safeAreaInsets];
//    
//    NSLog(@"状态栏高度---%f", statusH);
//    NSLog(@"导航栏高度---%f", navbarH);
//    NSLog(@"状态栏+导航栏高度---%f", statusNavBarH);
//    NSLog(@"安全区域---%@", NSStringFromUIEdgeInsets(safeInsets));
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.isSupportLandscape) {
        return UIInterfaceOrientationMaskAll;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)setupNavBar {
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, GK_STATUSBAR_NAVBAR_HEIGHT)];
        configure.backgroundImage = [view imageWithColors:@[(__bridge id)[UIColor colorWithRed:127/255.0 green:23/255.0 blue:135/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:37/255.0 green:26/255.0 blue:188/255.0 alpha:1.0].CGColor]];
        configure.darkBackgroundImage = [UIImage gk_imageWithColor:UIColor.lightGrayColor];
        // 导航栏背景色
        configure.backgroundColor = [UIColor whiteColor];
        // 导航栏标题颜色
        configure.titleColor = [UIColor whiteColor];
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleWhite;
        // 设置状态栏样式
        configure.statusBarStyle = UIStatusBarStyleLightContent;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 10.0f;
        configure.gk_navItemRightSpace = 10.0f;
        configure.gk_restoreSystemNavBar = YES;
    }];
    
    // 设置手势返回
    [GKGestureConfigure setupCustomConfigure:^(GKGestureHandleConfigure * _Nonnull configure) {
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        configure.gk_openScrollViewGestureHandle = YES;
    }];
}

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *nav = [UINavigationController rootVC:[GKMainViewController new]];
    nav.gk_openScrollLeftPush = YES;
    nav.gk_openSystemNavHandle = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

@end
