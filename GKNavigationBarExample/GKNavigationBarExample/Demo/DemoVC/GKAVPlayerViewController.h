//
//  GKAVPlayerViewController.h
//  GKNavigationBarExample
//
//  Created by QuintGao on 2025/1/14.
//  Copyright © 2025 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKAVPlayerManager : NSObject

+ (instancetype)sharedManager;

- (void)playVideoFrom:(UIViewController *)fromVC;

@end

@interface GKAVPlayerViewController : AVPlayerViewController

@end

NS_ASSUME_NONNULL_END
