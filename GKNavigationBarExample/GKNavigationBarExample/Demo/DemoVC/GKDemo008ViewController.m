//
//  GKDemo008ViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2025/1/14.
//  Copyright © 2025 QuintGao. All rights reserved.
//

#import "GKDemo008ViewController.h"
#import "AppDelegate.h"
#import "GKAVPlayerViewController.h"

@interface GKDemo008ViewController ()

@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) UIButton *btn2;

@end

@implementation GKDemo008ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"横屏播放器";
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)dealloc {
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    appDelegate.isSupportLandscape = NO;
}

- (void)btn1Action {
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    appDelegate.isSupportLandscape = YES;
    
    [GKAVPlayerManager.sharedManager playVideoFrom:self];
}

- (void)btn2Action {
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    appDelegate.isSupportLandscape = NO;
    
    [GKAVPlayerManager.sharedManager playVideoFrom:self];
}

// 控制器竖屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - lazy
- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setTitle:@"App支持横屏" forState:UIControlStateNormal];
        [_btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setTitle:@"App不支持横屏" forState:UIControlStateNormal];
        [_btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

@end
