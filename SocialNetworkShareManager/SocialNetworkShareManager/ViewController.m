//
//  ViewController.m
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "GXShareManager.h"
#import <FFToast/FFToast.h>
//#import "GXShareAlbumUtil.h"
//#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <GXShareManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [button addTarget:self action:@selector(presentAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentAction {
    [GXShareManager sharedInstance].associatedVC = self;
    [GXShareManager sharedInstance].delegate = self;
    [GXShareManager sharedInstance].title = @"Caption";
    [GXShareManager sharedInstance].desc = @"Hello , word!!  https://baidu.com";
    [GXShareManager sharedInstance].videoURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
    [GXShareManager sharedInstance].image = [UIImage imageNamed:@"image_comment_banner"];
//    [GXShareManager sharedInstance].cellConfig = [self getExampleData];
    [[GXShareManager sharedInstance] showShareViewWithAssociatedVC:self];
}

- (NSArray<NSDictionary *> *)getExampleData {
    return @[
//             @{
//                 kSNSTypeKey        : SNSTypeInstagram,
//                 kSNSTitleKey       : @"Instagram\n",
//                 kSNSImageStrKey    : @"image_share_instagram@3x",
//                 kSNSRequestTitleKey: @"Post and tag your photo",
//                 kSNSRequestDescKey : @"Your link to share has been copied. You can directly paste the link and share with your friends when you send it",
//                 kSNSConfirmKey     : @"Go To Instagram",
//                 kSNSCancelKey      : @"",
//                 kSNSDelayKey       : @(0)
//                 },
//             @{
//                 kSNSTypeKey        : SNSTypeFacebook,
//                 kSNSTitleKey       : @"Facebook\n",
//                 kSNSImageStrKey    : @"image_share_facebook@3x",
//                 kSNSRequestTitleKey: @"",
//                 kSNSRequestDescKey : @"",
//                 kSNSConfirmKey     : @"",
//                 kSNSCancelKey      : @"",
//                 kSNSDelayKey       : @(0)
//                 },
             @{
                 kSNSTypeKey        : SNSTypeTwitter,
                 kSNSTitleKey       : @"Twitter\n",
                 kSNSImageStrKey    : @"image_share_twitter@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeMessenger,
                 kSNSTitleKey       : @"Messenger\n",
                 kSNSImageStrKey    : @"image_share_messager@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeWhatsApp,
                 kSNSTitleKey       : @"WhatsApp\n",
                 kSNSImageStrKey    : @"image_share_whatsapp@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeIMessage,
                 kSNSTitleKey       : @"iMessage\n",
                 kSNSImageStrKey    : @"image_share_imessage@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeEmail,
                 kSNSTitleKey       : @"E-Mail\n",
                 kSNSImageStrKey    : @"image_share_email@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeyLinkCopy,
                 kSNSTitleKey       : @"Copy Link\n",
                 kSNSImageStrKey    : @"image_share_copy_link@3x",
                 kSNSRequestTitleKey: @"Copied to Clipboard",
                 kSNSRequestDescKey : @"Your link to share has been copied. You can directly paste the link and share with your friends.",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(2)
                 },
             ];
}


#pragma mark - GXShareManagerDelegate
- (void)shareManagerRequestToShowAlert:(NSString *)title
                               message:(NSString *)message
                           confirmInfo:(NSString *)confirmInfo
                            cancelInfo:(NSString *)cancelInfo
                                 delay:(NSUInteger)delayInterval
                            completion:(void (^)(BOOL))block {
    if(confirmInfo.length == 0) {
        if(delayInterval > 0) {
            [FFToast showToastWithTitle:title message:message iconImage:nil duration:delayInterval toastType:FFToastTypeDefault];
        }
        if(block) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                block(YES);
            });
        }
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:title
                                     message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle: (confirmInfo == nil ? @"YES" : confirmInfo)
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        if(block) {
                                            block(YES);
                                        }
                                    }];
        [alert addAction:yesButton];
        
        if(cancelInfo.length) {
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:cancelInfo
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * action) {
                                           if(block) {
                                               block(NO);
                                           }
                                       }];
            [alert addAction:noButton];
        }
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
