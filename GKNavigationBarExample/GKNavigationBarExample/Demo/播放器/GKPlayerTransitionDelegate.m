//
//  GKPlayerTransitionDelegate.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2022/8/26.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKPlayerTransitionDelegate.h"
#import "GKPlayerTransition.h"

@interface GKPlayerTransitionDelegate()

@property (nonatomic, weak) UIViewController *visibleVC;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *pushTransition;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *popTransition;

// 下滑
@property (nonatomic, assign) BOOL isPullDown;

@end

@implementation GKPlayerTransitionDelegate

#pragma mark - GKViewControllerTransitionDelegate
- (void)panGestureAction:(UIPanGestureRecognizer *)gesture transition:(GKNavigationInteractiveTransition *)transition {
    // 进度
    CGFloat progressX = [gesture translationInView:gesture.view].x / gesture.view.bounds.size.width;
    CGFloat progressY = [gesture translationInView:gesture.view].y / gesture.view.bounds.size.height;
    CGPoint velocity = [gesture velocityInView:gesture.view];
        
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.isPullDown = (velocity.x == 0 && velocity.y > 0);
        self.visibleVC = transition.navigationController.visibleViewController;
    }
    
    progressX = MIN(1.0, MAX(0.0, progressX));
    progressY = MIN(1.0, MAX(0.0, progressY));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.isPullDown) {
            self.popTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [transition.navigationController popViewControllerAnimated:YES];
        }else {
            self.popTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [transition.navigationController popViewControllerAnimated:YES];
        }
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (self.isPullDown) {
            [self.popTransition updateInteractiveTransition:progressY];
        }else {
            [self.popTransition updateInteractiveTransition:progressX];
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (self.isPullDown) {
            BOOL popFinished = progressY > 0.5;
            if ([GKGestureConfigure isVelocityInSensitivity:velocity.y] && velocity.y > 0) {
                popFinished = YES;
                [self.popTransition finishInteractiveTransition];
            }else {
                if (popFinished) {
                    [self.popTransition finishInteractiveTransition];
                }else {
                    [self.popTransition cancelInteractiveTransition];
                }
            }
        }else {
            BOOL popFinished = progressX > 0.5;
            if ([GKGestureConfigure isVelocityInSensitivity:velocity.x] && velocity.x < 0) {
                popFinished = YES;
                [self.popTransition finishInteractiveTransition];
            }else {
                if (popFinished) {
                    [self.popTransition finishInteractiveTransition];
                }else {
                    [self.popTransition cancelInteractiveTransition];
                }
            }
        }
        self.popTransition = nil;
        self.visibleVC = nil;
        self.isPullDown = NO;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer transition:(GKNavigationInteractiveTransition *)transition {
    
//     获取当前显示的VC
//    UIViewController *visibleVC = transition.navigationController.visibleViewController;
    
    // 根据transition判断滑动方向
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    if (translation.x < 0) { // 左滑
        return NO;
    }else if (translation.x > 0) { // 右滑
        [gestureRecognizer removeTarget:transition.systemTarget action:transition.systemAction];
        
        CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
        CGFloat maxAllowDistance = 30;
        if (maxAllowDistance > 0 && beginningLocation.x > maxAllowDistance) {
            return NO;
        }
    }else if (translation.y < 0) {
        return NO;
    }else if (translation.y > 0) {
        // 下滑
        [gestureRecognizer removeTarget:transition.systemTarget action:transition.systemAction];;
        
        return YES;
    }
    
    if ([[transition.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return YES;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC transition:(GKNavigationInteractiveTransition *)transition {
    if (operation == UINavigationControllerOperationPop && self.popTransition) {
        return [GKPlayerTransition transitionWithType:GKPlayerTransitionType_Pop];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController transition:(GKNavigationInteractiveTransition *)transition {
    
    if ([animationController isKindOfClass:GKPlayerTransition.class]) {
        return self.popTransition;
    }
    
    return nil;
}

@end
