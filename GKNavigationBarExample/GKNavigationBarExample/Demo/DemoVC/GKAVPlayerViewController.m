//
//  GKAVPlayerViewController.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2025/1/14.
//  Copyright © 2025 QuintGao. All rights reserved.
//

#import "GKAVPlayerViewController.h"
#import "AppDelegate.h"

@implementation GKAVPlayerManager

+ (instancetype)sharedManager {
    static GKAVPlayerManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[GKAVPlayerManager alloc] init];
    });
    return mgr;
}

- (void)playVideoFrom:(UIViewController *)fromVC {
    NSString *url = @"https://vdept3.bdstatic.com/mda-qm4br6w8xehg6635/720p/h264/1733386683871039898/mda-qm4br6w8xehg6635.mp4?v_from_s=hkapp-haokan-hbf&auth_key=1736848119-0-0-d6adf27b5f58573a8be5c7120d2f7a4a&bcevod_channel=searchbox_feed&cr=2&cd=0&pd=1&pt=3&logid=2919366242&vid=5399183411636004740&klogid=2919366242&abtest=";
    
    GKAVPlayerViewController *vc = [[GKAVPlayerViewController alloc] init];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    vc.player = player;
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayback error:nil];
    [AVAudioSession.sharedInstance setActive:YES error:nil];
    
    __weak __typeof(vc) weakVC = vc;
    [fromVC presentViewController:vc animated:YES completion:^{
        __strong __typeof(weakVC) vc = weakVC;
        [vc.player play];
    }];
}

@end

@implementation GKAVPlayerViewController

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
