//
//  GKDemo006ViewController.m
//  GKNavigationBarExample
//
//  Created by gaokun on 2022/2/23.
//  Copyright © 2022 QuintGao. All rights reserved.
//

#import "GKDemo006ViewController.h"
#import "GKDemo003ViewController.h"

@interface GKDemo006ViewController ()<UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) UIButton *printBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation GKDemo006ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"系统功能";
    self.view.backgroundColor = UIColor.whiteColor;
    self.gk_navRightBarButtonItem = [UIBarButtonItem gk_itemWithTitle:@"哈哈" target:self action:@selector(systemAction:)];
    self.gk_navItemRightSpace = 40;
    
    [self.view addSubview:self.printBtn];
    [self.view addSubview:self.shareBtn];
    
    [self.printBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(50);
        make.width.mas_equalTo(100.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.printBtn.mas_bottom).offset(50);
        make.width.mas_equalTo(100.0f);
        make.height.mas_equalTo(40.0f);
    }];
}

- (void)systemAction:(id)sender {
    GKDemo003ViewController *demoVC = [[GKDemo003ViewController alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}

- (void)printAction:(id)sender{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=566500983,3412942035&fm=253&fmt=auto&app=138&f=JPEG?w=440&h=955"];
    if (pic && [UIPrintInteractionController canPrintURL:url]) {
        pic.delegate = self;
        
        //        打印任务细节在 UIPrintInfo 实例中设置。可以使用以下属性：
        UIPrintInfo* printInfo = [UIPrintInfo printInfo];
        
        //        UIPrintInfoOutputType：给 UIKit 提供要打印内容的类型提示。可以是以下任意一个：
        //        .General（默认）：文本和图形混合类型；允许双面打印。
        //        .Grayscale：如果你的内容只包括黑色文本，那么该类型比 .General 更好。
        //        .Photo：彩色或黑白图像；禁用双面打印，更适用于图像媒体的纸张类型。
        //        .PhotoGrayscale：对于仅灰度的图像，根据打印机的不同，该类型可能比 .Photo 更好。
        printInfo.outputType = UIPrintInfoOutputGeneral;
        //        jobName String：此打印任务的名称。这个名字将被显示在设备的打印中心，对于有些打印机则显示在液晶屏上
        printInfo.jobName = @"PrintingImage";
        //         UIPrintInfoDuplex：.None、.ShortEdge 或 .LongEd​​ge。short- 和 long- 的边界设置指示如何装订双面页面，而 .None 不支持双面打印（这里不是 UI 切换为双面打印，令人困惑）
        printInfo.duplex = UIPrintInfoDuplexShortEdge;
        
        //        UIPrintInfo：之前所述的打印任务的配置
        pic.printInfo = printInfo;
        //        showsPageRange Bool：当值为 true 时，让用户从打印源中选择一个子范围。这只在多页内容时有用，它默认关闭了图像。
        pic.showsPageRange = NO;
        
        pic.printingItem = url;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %lu", error.domain, error.code);
            }
        };
        
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [pic presentFromRect:self.view.frame inView:self.view animated:YES completionHandler:completionHandler];
        }
        else {
            [pic presentAnimated:YES completionHandler:completionHandler];
        }
    }
}

- (void)shareAction:(id)sender {
    // 分享文件
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=566500983,3412942035&fm=253&fmt=auto&app=138&f=JPEG?w=440&h=955"];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    
//         根据需要指定不需要分享的平台
    activityVC.excludedActivityTypes = @[UIActivityTypeMail,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed) { // 确定分享
            NSLog(@"分享成功");
        }else {
            NSLog(@"分享失败");
        }
    };
    
    UIPopoverPresentationController *popover = activityVC.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.shareBtn;
        popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - UIPrintInteractionControllerDelegate


- (UIButton *)printBtn {
    if (!_printBtn) {
        _printBtn = [[UIButton alloc] init];
        [_printBtn setTitle:@"打印机" forState:UIControlStateNormal];
        [_printBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_printBtn addTarget:self action:@selector(printAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _printBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setTitle:@"系统分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end
