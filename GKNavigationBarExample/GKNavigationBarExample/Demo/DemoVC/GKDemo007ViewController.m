//
//  GKDemo007ViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/7/29.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKDemo007ViewController.h"
#import <JXCategoryViewExt/JXCategoryView.h>
#import "GKDemo007ListViewController.h"

@interface GKDemo007ViewController ()<JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *containerView;

@end

@implementation GKDemo007ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"分类";
    self.gk_navItemRightSpace = 0;
    self.gk_navRightBarButtonItem = [UIBarButtonItem gk_itemWithTitle:@"更多" target:self action:@selector(moreAction)];
    self.gk_navRightBarButtonItem.customView.backgroundColor = UIColor.blueColor;
    [self.gk_navigationBar layoutIfNeeded];
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.containerView];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.gk_navigationBar.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.categoryView.mas_bottom);
    }];
}

- (void)moreAction {
    
}

#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [GKDemo007ListViewController new];
}

#pragma mark - 懒加载
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] init];
        _categoryView.titles = @[@"关注", @"推荐", @"同城", @"直播"];
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = UIColor.redColor;
        _categoryView.indicators = @[lineView];
        
        _categoryView.listContainer = self.containerView;
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    }
    return _containerView;
}

@end
