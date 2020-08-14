//
//  AppDelegate.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2019/11/2.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "AppDelegate.h"
#import "GKMainViewController.h"
#import "GKWYMusicViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        // 导航栏背景色
        configure.backgroundColor = [UIColor whiteColor];
        // 导航栏标题颜色
        configure.titleColor = [UIColor blackColor];
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 30.0f;
        configure.gk_navItemRightSpace = 30.0f;
        
        configure.shiledItemSpaceVCs = @[NSClassFromString(@"TZPhotoPickerController"), @"TZAlbumPickerController"];
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nav = [UINavigationController rootVC:[GKMainViewController new]];
    nav.gk_openScrollLeftPush = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
