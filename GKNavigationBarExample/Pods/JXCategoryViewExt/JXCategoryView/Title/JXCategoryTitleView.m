//
//  JXCategoryView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryTitleView

- (void)initializeData {
    [super initializeData];

    _titleNumberOfLines = 1;
    _titleLabelZoomEnabled = NO;
    _titleLabelZoomScale = 1.2;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
    _titleLabelMaskEnabled = NO;
    _titleLabelZoomScrollGradientEnabled = YES;
    _titleLabelStrokeWidthEnabled = NO;
    _titleLabelSelectedStrokeWidth = -3;
    _titleLabelVerticalOffset = 0;
    _titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleCenter;
}

- (UIFont *)titleSelectedFont {
    if (_titleSelectedFont) {
        return _titleSelectedFont;
    }
    return self.titleFont;
}

- (void)gk_refreshCellState {
    // 刷新cell颜色
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self reloadCellAtIndex:idx];
    }];
}

- (void)gk_refreshIndicatorState {
    // 刷新指示器颜色
    CGRect selectedCellFrame = CGRectZero;
    JXCategoryIndicatorCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryIndicatorCellModel *cellModel = (JXCategoryIndicatorCellModel *)self.dataSource[i];
        cellModel.sepratorLineShowEnabled = self.isSeparatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
        cellModel.backgroundViewMaskFrame = CGRectZero;
        cellModel.cellBackgroundColorGradientEnabled = self.isCellBackgroundColorGradientEnabled;
        cellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        cellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }
    
    for (UIView<JXCategoryIndicatorProtocol> *indicator in self.indicators) {
        if (self.dataSource.count <= 0) {
            indicator.hidden = YES;
        }else {
            indicator.hidden = NO;
            JXCategoryIndicatorParamsModel *indicatorParamsModel = [[JXCategoryIndicatorParamsModel alloc] init];
            indicatorParamsModel.selectedIndex = self.selectedIndex;
            indicatorParamsModel.selectedCellFrame = selectedCellFrame;
            [indicator jx_refreshState:indicatorParamsModel];
        }
    }
}

- (void)gk_refreshCellAndIndicatorState {
    [self gk_refreshCellState];
    [self gk_refreshIndicatorState];
}

#pragma mark - Override

- (Class)preferredCellClass {
    return [JXCategoryTitleCell class];
}

- (void)refreshDataSource {
    NSInteger count = [self numberOfTitles];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        JXCategoryTitleCellModel *cellModel = [[JXCategoryTitleCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryTitleCellModel *myUnselectedCellModel = (JXCategoryTitleCellModel *)unselectedCellModel;
    JXCategoryTitleCellModel *myselectedCellModel = (JXCategoryTitleCellModel *)selectedCellModel;
    if (self.isSelectedAnimationEnabled && (selectedCellModel.selectedType == JXCategoryCellSelectedTypeClick || selectedCellModel.selectedType == JXCategoryCellSelectedTypeCode)) {
        //开启了动画过渡，且cell在屏幕内，current的属性值会在cell里面进行动画插值更新
        //1、当unselectedCell在屏幕外的时候，还是需要在这里更新值
        //2、当selectedCell在屏幕外的时候，还是需要在这里更新值（比如调用selectItemAtIndex方法选中的时候）
        BOOL isUnselectedCellVisible = NO;
        BOOL isSelectedCellVisible = NO;
        NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in indexPaths) {
            if (indexPath.item == myUnselectedCellModel.index) {
                isUnselectedCellVisible = YES;
                continue;
            } else if (indexPath.item == myselectedCellModel.index) {
                isSelectedCellVisible = YES;
                continue;
            }
        }
        if (!isUnselectedCellVisible) {
            //但是当unselectedCell在屏幕外时，不会在cell里面通过动画插值更新，在这里直接更新
            myUnselectedCellModel.titleCurrentColor = myUnselectedCellModel.titleNormalColor;
            myUnselectedCellModel.titleLabelCurrentZoomScale = myUnselectedCellModel.titleLabelNormalZoomScale;
            myUnselectedCellModel.titleLabelCurrentStrokeWidth = myUnselectedCellModel.titleLabelNormalStrokeWidth;
        }
        if (!isSelectedCellVisible) {
            //但是当selectedCell在屏幕外时，不会在cell里面通过动画插值更新，在这里直接更新
            myselectedCellModel.titleCurrentColor = myselectedCellModel.titleSelectedColor;
            myselectedCellModel.titleLabelCurrentZoomScale = myselectedCellModel.titleLabelSelectedZoomScale;
            myselectedCellModel.titleLabelCurrentStrokeWidth = myselectedCellModel.titleLabelSelectedStrokeWidth;
        }
    } else {
        //没有开启动画，可以直接更新属性
        myselectedCellModel.titleCurrentColor = myselectedCellModel.titleSelectedColor;
        myselectedCellModel.titleLabelCurrentZoomScale = myselectedCellModel.titleLabelSelectedZoomScale;
        myselectedCellModel.titleLabelCurrentStrokeWidth = myselectedCellModel.titleLabelSelectedStrokeWidth;

        myUnselectedCellModel.titleCurrentColor = myUnselectedCellModel.titleNormalColor;
        myUnselectedCellModel.titleLabelCurrentZoomScale = myUnselectedCellModel.titleLabelNormalZoomScale;
        myUnselectedCellModel.titleLabelCurrentStrokeWidth = myUnselectedCellModel.titleLabelNormalStrokeWidth;
    }
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    JXCategoryTitleCellModel *leftModel = (JXCategoryTitleCellModel *)leftCellModel;
    JXCategoryTitleCellModel *rightModel = (JXCategoryTitleCellModel *)rightCellModel;

    if (self.isTitleLabelZoomEnabled && self.isTitleLabelZoomScrollGradientEnabled) {
        leftModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
        rightModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
    }

    if (self.isTitleLabelStrokeWidthEnabled) {
        leftModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:leftModel.titleLabelSelectedStrokeWidth to:leftModel.titleLabelNormalStrokeWidth percent:ratio];
        rightModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:rightModel.titleLabelNormalStrokeWidth to:rightModel.titleLabelSelectedStrokeWidth percent:ratio];
    }

    if (self.isTitleColorGradientEnabled) {
        leftModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
        rightModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        if (self.titleDataSource && [self.titleDataSource respondsToSelector:@selector(categoryTitleView:widthForTitle:)]) {
            return [self.titleDataSource categoryTitleView:self widthForTitle:[self titleWithIndex:index]];
        } else {
            return ceilf([[self titleWithIndex:index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
        }
    } else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleCellModel *model = (JXCategoryTitleCellModel *)cellModel;
    model.title = [self titleWithIndex:index];
    model.titleNumberOfLines = self.titleNumberOfLines;
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleNormalColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.titleLabelMaskEnabled = self.isTitleLabelMaskEnabled;
    model.titleLabelZoomEnabled = self.isTitleLabelZoomEnabled;
    model.titleLabelNormalZoomScale = 1;
    model.titleLabelZoomSelectedVerticalOffset = self.titleLabelZoomSelectedVerticalOffset;
    model.titleLabelSelectedZoomScale = self.titleLabelZoomScale;
    model.titleLabelStrokeWidthEnabled = self.isTitleLabelStrokeWidthEnabled;
    model.titleLabelNormalStrokeWidth = 0;
    model.titleLabelSelectedStrokeWidth = self.titleLabelSelectedStrokeWidth;
    model.titleLabelVerticalOffset = self.titleLabelVerticalOffset;
    model.titleLabelAnchorPointStyle = self.titleLabelAnchorPointStyle;
    if (index == self.selectedIndex) {
        model.titleCurrentColor = model.titleSelectedColor;
        model.titleLabelCurrentZoomScale = model.titleLabelSelectedZoomScale;
        model.titleLabelCurrentStrokeWidth= model.titleLabelSelectedStrokeWidth;
    }else {
        model.titleCurrentColor = model.titleNormalColor;
        model.titleLabelCurrentZoomScale = model.titleLabelNormalZoomScale;
        model.titleLabelCurrentStrokeWidth = model.titleLabelNormalStrokeWidth;
    }
}

- (NSInteger)numberOfTitles {
    if ([self.titleDataSource respondsToSelector:@selector(numberOfTitleView:)] && [self.titleDataSource respondsToSelector:@selector(titleView:titleForIndex:)]) {
        return [self.titleDataSource numberOfTitleView:self];
    }
    return self.titles.count;
}

- (NSString *)titleWithIndex:(NSInteger)index {
    if ([self.titleDataSource respondsToSelector:@selector(numberOfTitleView:)] && [self.titleDataSource respondsToSelector:@selector(titleView:titleForIndex:)]) {
        return [self.titleDataSource titleView:self titleForIndex:index];
    }
    return self.titles[index];
}

@end
