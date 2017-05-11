//
//  ViewController.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "SocialNetworkShareManager.h"

@interface ViewController () <SocialNetworkShareManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
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
//    [[SocialNetworkShareManager sharedInstance] shareImage:[UIImage imageNamed:@"image_comment_banner"]
//                                                   caption:@"Caption"
//                                               description:@"hello, word"
//                                                      type:SNSTypeFacebook
//                                           andAssociatedVC:self];
    [SocialNetworkShareManager sharedInstance].associatedVC = self;
    [SocialNetworkShareManager sharedInstance].delegate = self;
    [[SocialNetworkShareManager sharedInstance] showShareViewWithAssociatedVC:self];
}


#pragma mark - SocialNetworkShareManagerDelegate
- (void)shareManagerRequestToShowAlert:(NSString *)title message:(NSString *)message confirmInfo:(NSString *)confirmInfo cancelInfo:(NSString *)cancelInfo completion:(void (^)(BOOL))block {
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
    
    if(cancelInfo) {
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

@end
