//
//  JXCategoryViewDefines.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat JXCategoryViewAutomaticDimension = -1;

typedef void(^JXCategoryCellSelectedAnimationBlock)(CGFloat percent);

// 指示器的位置
typedef NS_ENUM(NSUInteger, JXCategoryComponentPosition) {
    JXCategoryComponentPosition_Bottom,
    JXCategoryComponentPosition_Top
};

// cell 被选中的类型
typedef NS_ENUM(NSUInteger, JXCategoryCellSelectedType) {
    JXCategoryCellSelectedTypeUnknown, // 未知，不是选中（cellForRow方法里面、两个cell过渡时）
    JXCategoryCellSelectedTypeClick,   // 点击选中
    JXCategoryCellSelectedTypeCode,    // 调用方法 selectItemAtIndex: 选中
    JXCategoryCellSelectedTypeScroll   // 通过滚动到某个 cell 选中
};

// cell 标题锚点位置
typedef NS_ENUM(NSUInteger, JXCategoryTitleLabelAnchorPointStyle) {
    JXCategoryTitleLabelAnchorPointStyleCenter,
    JXCategoryTitleLabelAnchorPointStyleTop,
    JXCategoryTitleLabelAnchorPointStyleBottom
};

// 指示器滚动样式
typedef NS_ENUM(NSUInteger, JXCategoryIndicatorScrollStyle) {
    JXCategoryIndicatorScrollStyleSimple,           // 简单滚动，即从当前位置过渡到目标位置
    JXCategoryIndicatorScrollStyleSameAsUserScroll  // 和用户左右滚动列表时的效果一样
};

#define JXCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 2021.1.21添加 by：QuintGao
#define HasIndicatorBackgroundView (__has_include(<JXCategoryViewExt/JXCategoryIndicatorBackgroundView.h>) || __has_include("JXCategoryIndicatorBackgroundView.h"))

#define HasRTL (__has_include(<JXCategoryViewExt/RTLManager.h>) || __has_include("RTLManager.h"))
