//
//  GKPlayerTransition.h
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/8/19.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import <GKNavigationBar/GKNavigationBar.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GKPlayerTransitionType) {
    GKPlayerTransitionType_Push,
    GKPlayerTransitionType_Pop
};

@interface GKPlayerTransition : GKBaseAnimatedTransition

+ (instancetype)transitionWithType:(GKPlayerTransitionType)type;

@end

NS_ASSUME_NONNULL_END
