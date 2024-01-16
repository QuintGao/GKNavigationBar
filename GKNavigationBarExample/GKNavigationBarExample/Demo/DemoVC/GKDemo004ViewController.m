//
//  GKDemo004ViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2020/11/26.
//  Copyright © 2020 QuintGao. All rights reserved.
//

#import "GKDemo004ViewController.h"

@interface GKDemo004ViewController ()

@end

@implementation GKDemo004ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"UITableViewController";
    self.gk_navBackgroundColor = UIColor.blueColor;
    self.gk_navBarAlpha = 0;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(self.gk_navigationBar.frame.size.height, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect navFrame = self.gk_navigationBar.frame;
    navFrame.origin.y = 0;
    self.gk_navigationBar.frame = navFrame;
    [self.tableView.superview addSubview:self.gk_navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view addSubview:self.gk_navigationBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect navFrame = self.gk_navigationBar.frame;
    
    if (self.gk_navigationBar.superview == self.view) {
        navFrame.origin.y += self.tableView.contentOffset.y;
    }else {
        navFrame.origin.y = 0;
    }
    self.gk_navigationBar.frame = navFrame;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row + 1];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat navbarH = self.gk_navigationBar.frame.size.height;
    
    CGFloat offsetY = scrollView.contentOffset.y + navbarH;
    
    CGFloat alpha = 0;
    if (offsetY <= 0) {
        alpha = 0;
    }else if (offsetY >= navbarH) {
        alpha = 1;
    }else {
        alpha = offsetY / navbarH;
    }
    
    if (alpha >= 1) {
        self.gk_backStyle = GKNavigationBarBackStyleWhite;
        self.gk_navTitleColor = UIColor.whiteColor;
        self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    }else {
        self.gk_backStyle = GKNavigationBarBackStyleBlack;
        self.gk_navTitleColor = UIColor.blackColor;
        self.gk_statusBarStyle = UIStatusBarStyleDefault;
    }
    
    self.gk_navBarAlpha = alpha;
}

@end
