//
//  GKPresentViewController.m
//  GKNavigationBarExample
//
//  Created by gaokun on 2021/5/7.
//  Copyright © 2021 QuintGao. All rights reserved.
//

#import "GKPresentViewController.h"

@interface GKPresentViewController ()

@end

@implementation GKPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.gk_navTitle = @"presentVC";
    self.gk_navRightBarButtonItem = [UIBarButtonItem gk_itemWithTitle:@"关闭" target:self action:@selector(close)];
    self.gk_navBackgroundColor = UIColor.blueColor;
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"%@", NSStringFromCGRect(UIScreen.mainScreen.bounds));
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
