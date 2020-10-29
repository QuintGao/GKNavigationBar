//
//  UIViewController+GKGestureHandle.h
//  GKNavigationBarExample
//
//  Created by gaokun on 2020/10/29.
//  Copyright © 2020 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const GKViewControllerPropertyChangedNotification;

// 左滑push代理
@protocol GKViewControllerPushDelegate <NSObject>

- (void)pushToNextViewController;

@end

// 右滑pop代理
@protocol GKViewControllerPopDelegate <NSObject>

@optional
- (void)viewControllerPopScrollBegan;
- (void)viewControllerPopScrollUpdate:(float)progress;
- (void)viewControllerPopScrollEnded;

@end

@interface UIViewController (GKGestureHandle)

/// 是否禁止当前控制器的滑动返回（包括全屏滑动返回和边缘滑动返回）
@property (nonatomic, assign) BOOL gk_interactivePopDisabled;

/// 是否禁止当前控制器的全屏滑动返回
@property (nonatomic, assign) BOOL gk_fullScreenPopDisabled;

/// 全屏滑动时，滑动区域距离屏幕左侧的最大位置，默认是0：表示全屏可滑动
@property (nonatomic, assign) CGFloat gk_maxPopDistance;

/// 左滑push代理
@property (nonatomic, weak) id<GKViewControllerPushDelegate> gk_pushDelegate;

/// 右滑pop代理，如果设置了gk_popDelegate，原来的滑动返回手势将失效
@property (nonatomic, weak) id<GKViewControllerPopDelegate> gk_popDelegate;

/** 自定义push转场动画 */
@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning> gk_pushTransition;

/** 自定义pop转场动画 */
@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning> gk_popTransition;

@end

NS_ASSUME_NONNULL_END
