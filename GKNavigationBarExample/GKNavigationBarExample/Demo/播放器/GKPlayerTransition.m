//
//  GKPlayerTransition.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/8/19.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKPlayerTransition.h"

@interface GKPlayerTransition()

@property (nonatomic, assign) GKPlayerTransitionType type;

@end

@implementation GKPlayerTransition

+ (instancetype)transitionWithType:(GKPlayerTransitionType)type {
    return [[self alloc] initWithType:type];
}

- (instancetype)initWithType:(GKPlayerTransitionType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition {
    if (self.type == GKPlayerTransitionType_Push) {
        [self pushTransition];
    }else {
        [self popTransition];
    }
}

- (void)pushTransition {
    // 解决UITabbarController左滑push时的显示问题
    self.isHideTabBar = self.fromViewController.tabBarController && self.toViewController.hidesBottomBarWhenPushed;

    CGFloat screenW = self.containerView.bounds.size.width;
    CGFloat screenH = self.containerView.bounds.size.height;

    __block UIView *fromView = nil;
    if (self.isHideTabBar) {
        // 获取fromViewController的截图
        UIImage *captureImage = [GKGestureConfigure getCaptureWithView:self.fromViewController.view.window];
        UIImageView *captureView = [[UIImageView alloc] initWithImage:captureImage];
        captureView.frame = CGRectMake(0, 0, screenW, screenH);
        [self.containerView addSubview:captureView];
        fromView = captureView;
        self.fromViewController.gk_captureImage = captureImage;
        self.fromViewController.view.hidden = YES;
        self.fromViewController.tabBarController.tabBar.hidden = YES;
    }else {
        fromView = self.fromViewController.view;
    }
    self.contentView = fromView;

    // 设置toViewController
    self.toViewController.view.frame = CGRectMake(0, screenH, screenW, screenH);
    self.toViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toViewController.view.layer.shadowOpacity = 0.15f;
    self.toViewController.view.layer.shadowRadius = 3.0f;
    [self.containerView addSubview:self.toViewController.view];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.toViewController.view.frame = CGRectMake(0, 0, screenW, screenH);
    } completion:^(BOOL finished) {
        [self completeTransition];
        if (self.isHideTabBar) {
            [self.contentView removeFromSuperview];
            self.contentView = nil;

            self.fromViewController.view.hidden = NO;
            if (self.fromViewController.navigationController.childViewControllers.count == 1) {
                self.fromViewController.tabBarController.tabBar.hidden = NO;
            }
        }
    }];
}

- (void)popTransition {
    [self.containerView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    
    // 是否隐藏tabBar
    self.isHideTabBar = self.toViewController.tabBarController && self.fromViewController.hidesBottomBarWhenPushed && self.toViewController.gk_captureImage;
    
    CGFloat screenW = self.containerView.bounds.size.width;
    CGFloat screenH = self.containerView.bounds.size.height;
    
    __block UIView *toView = nil;
    if (self.isHideTabBar) {
        UIImageView *captureView = [[UIImageView alloc] initWithImage:self.toViewController.gk_captureImage];
        captureView.frame = CGRectMake(0, 0, screenW, screenH);
        [self.containerView insertSubview:captureView belowSubview:self.fromViewController.view];
        toView = captureView;
        self.toViewController.view.hidden = YES;
        self.toViewController.tabBarController.tabBar.hidden = YES;
    }else {
        toView = self.toViewController.view;
    }
    self.contentView = toView;
    
    toView.frame = CGRectMake(0, 0, screenW, screenH);
    
    self.fromViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.fromViewController.view.layer.shadowOpacity = 0.15f;
    self.fromViewController.view.layer.shadowRadius = 3.0f;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.fromViewController.view.frame = CGRectMake(0, screenH, screenW, screenH);
    } completion:^(BOOL finished) {
        [self completeTransition];
        if (self.isHideTabBar) {
            [self.contentView removeFromSuperview];
            self.contentView = nil;
            
            self.toViewController.view.hidden = NO;
            if (self.toViewController.navigationController.childViewControllers.count == 1) {
                self.toViewController.tabBarController.tabBar.hidden = NO;
            }
        }
    }];
}

@end
