//
//  GKDemo003ViewController.m
//  GKNavigationBarViewControllerDemo
//
//  Created by gaokun on 2019/6/26.
//  Copyright © 2019 gaokun. All rights reserved.
//

#import "GKDemo003ViewController.h"
#import "GKDemo000ViewController.h"
#import "GKDemoTransitionViewController.h"

@interface GKDemo003ViewController ()<GKViewControllerPushDelegate, GKViewControllerPopDelegate>

@end

@implementation GKDemo003ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"系统导航";
    
    self.gk_disableFixNavItemSpace = YES;
    self.gk_navItemRightSpace = 40.0f;
    UIBarButtonItem *rightItem = [UIBarButtonItem gk_itemWithTitle:@"push" target:self action:@selector(click)];
    rightItem.customView.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.gk_pushDelegate = self;
    self.gk_popDelegate  = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO];
}

- (void)click {
    GKDemo000ViewController *demoVC = [GKDemo000ViewController new];
    [self.navigationController pushViewController:demoVC animated:YES];
}

#pragma mark - GKGesturePopHandlerProtocol
- (BOOL)navigationShouldPopOnClick {
    self.navigationController.navigationBar.hidden = YES;
    return YES;
}

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    GKDemoTransitionViewController *transitionVC = [GKDemoTransitionViewController new];
    transitionVC.isSystem = NO;
    [self.navigationController pushViewController:transitionVC animated:YES];
}

- (void)viewControllerPushScrollBegan {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewControllerPushScrollUpdate:(float)progress {
    self.navigationController.navigationBar.alpha = 1 - progress;
}

- (void)viewControllerPushScrollEnded:(BOOL)finished {
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBarHidden = finished;
}

#pragma mark - GKViewControllerPopDelegate
- (void)viewControllerPopScrollBegan {
    
}

- (void)viewControllerPopScrollUpdate:(float)progress {
    // 由于已经出栈，所以self.navigationController为nil，不能直接获取导航控制器
    UIViewController *vc = [GKConfigure visibleViewController];
    vc.navigationController.navigationBar.alpha = 1 - progress;
}

- (void)viewControllerPopScrollEnded:(BOOL)finished {
    // 由于已经出栈，所以self.navigationController为nil，不能直接获取导航控制器
    UIViewController *vc = [GKConfigure visibleViewController];
    vc.navigationController.navigationBar.alpha = 1;
    vc.navigationController.navigationBarHidden = finished;
}

@end
