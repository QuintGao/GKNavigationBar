//
//  GKSecondViewController.m
//  GKNavigationController
//
//  Created by QuintGao on 2017/6/21.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKDemo002ViewController.h"
#import "GKDemo003ViewController.h"

@interface GKDemo002ViewController ()<UIScrollViewDelegate, GKViewControllerPopDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GKDemo002ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.gk_navBarAlpha = 0.5f;
    self.gk_statusBarStyle = UIStatusBarStyleDefault;
    self.gk_navigationItem.title = @"控制器002";
    self.gk_navBackgroundColor = [UIColor blueColor];
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize     = CGSizeMake(0, self.view.frame.size.height + 500);
    [self.view insertSubview:self.scrollView atIndex:0];
    
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 400, 60, 20);
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.gk_popDelegate = self;
}

#pragma mark - GKViewControllerPopDelegate
- (void)viewControllerPopScrollBegan {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.gk_popDelegate = nil;
        
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)btnAction {
    GKDemo003ViewController *demo003VC = [GKDemo003ViewController new];
    demo003VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:demo003VC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.gk_statusBarStyle == UIStatusBarStyleDefault) {
        self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    }else {
        self.gk_statusBarStyle = UIStatusBarStyleDefault;
    }
}

#pragma mark - UIScrollViewDelegate

// 渐变导航栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentY = scrollView.contentOffset.y;
    
    if (contentY <= 0) {
        self.gk_navBarAlpha = 0;
        return;
    }
    
    // 渐变区间 (0 - 80)
    if (contentY > 0 && contentY < 160) {
        CGFloat alpha = contentY / (160 - 0);
        
        self.gk_navBarAlpha = alpha;
        self.gk_backStyle = GKNavigationBarBackStyleWhite;
    }else {
        self.gk_navBarAlpha = 1.0;
        
        self.gk_backStyle = GKNavigationBarBackStyleBlack;
    }
}

@end
