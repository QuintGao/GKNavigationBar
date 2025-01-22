//
//  UIDevice+GKExtension.h
//  GKNavigationBarExample
//
//  Created by QuintGao on 2025/1/22.
//  Copyright © 2025 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (GKExtension)

// 灵动岛屏幕
+ (BOOL)gk_isDynamicIsland;

// 刘海屏
+ (BOOL)gk_isNotchedScreen;

// 状态栏高度
+ (CGFloat)gk_statusBarHeight;

// 导航栏高度
+ (CGFloat)gk_navBarHeight;

// 完整导航栏高度，不完全等于状态栏+导航栏
+ (CGFloat)gk_navBarFullHeight;

@end

NS_ASSUME_NONNULL_END
