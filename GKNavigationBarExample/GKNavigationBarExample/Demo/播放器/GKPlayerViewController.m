//
//  GKPlayerViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/8/19.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKPlayerViewController.h"
#import "GKPlayerTransitionDelegate.h"

@interface GKPlayerViewController ()

@property (nonatomic, strong) GKPlayerTransitionDelegate *transitionDelegate;

@end

@implementation GKPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"播放器";
    self.gk_transitionDelegate = self.transitionDelegate;
}

#pragma mark - 懒加载
- (GKPlayerTransitionDelegate *)transitionDelegate {
    if (!_transitionDelegate) {
        _transitionDelegate = [[GKPlayerTransitionDelegate alloc] init];
    }
    return _transitionDelegate;
}

@end
