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
    
    // 系统导航，需设置下面的属性导航栏间距才能生效
    self.gk_openFixNavItemSpace = YES;
    self.gk_navItemRightSpace = 40.0f;
    UIBarButtonItem *rightItem = [UIBarButtonItem gk_itemWithTitle:@"push" target:self action:@selector(click)];
    rightItem.customView.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem gk_itemWithTitle:@"返回" target:self action:@selector(backItemClick:)];
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationController.navigationBar.standardAppearance;
        appearance.backgroundColor = UIColor.redColor;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        // Fallback on earlier versions
    }
    
    self.gk_pushDelegate = self;
    self.gk_popDelegate  = self;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, self.view.bounds.size.width, CGFLOAT_MAX)];
    [self.view addSubview:label];
    
    label.text = @"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好";
    label.numberOfLines = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(GK_STATUSBAR_NAVBAR_HEIGHT);
    }];
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
