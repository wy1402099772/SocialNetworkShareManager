//
//  ViewController.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "SocialNetworkShareManager.h"
#import <FFToast/FFToast.h>

@interface ViewController () <SocialNetworkShareManagerDelegate>

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
    [SocialNetworkShareManager sharedInstance].associatedVC = self;
    [SocialNetworkShareManager sharedInstance].delegate = self;
    [[SocialNetworkShareManager sharedInstance] showShareViewWithAssociatedVC:self];
}


#pragma mark - SocialNetworkShareManagerDelegate
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
