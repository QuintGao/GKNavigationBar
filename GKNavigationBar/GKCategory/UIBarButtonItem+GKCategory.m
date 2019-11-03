//
//  UIBarButtonItem+GKCategory.m
//  GKNavigationBar
//
//  Created by QuintGao on 2019/10/28.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "UIBarButtonItem+GKCategory.h"

@implementation UIBarButtonItem (GKCategory)

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIImage *image = nil;
    return [self itemWithTitle:title image:image target:target action:action];
}

+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    NSString *title = nil;
    return [self itemWithTitle:title image:image target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action {
    UIImage *highLightImage = nil;
    return [self itemWithTitle:title image:image highLightImage:highLightImage target:target action:action];
}

+ (instancetype)itemWithImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action {
    NSString *title = nil;
    return [self itemWithTitle:title image:image highLightImage:highLightImage target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton new];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (highLightImage) {
        [button setImage:highLightImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (button.bounds.size.width < 44.0f) {
        button.bounds = CGRectMake(0, 0, 44.0f, 44.0f);
    }
    
    return [[self alloc] initWithCustomView:button];
}

@end
