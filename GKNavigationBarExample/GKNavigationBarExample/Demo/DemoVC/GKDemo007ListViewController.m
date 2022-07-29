//
//  GKDemo007ListViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/7/29.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKDemo007ListViewController.h"

@interface GKDemo007ListViewController ()

@end

@implementation GKDemo007ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

@end
