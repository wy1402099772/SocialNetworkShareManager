//
//  GXShareTwitterTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareTwitterTask.h"
#import "GXShareManager.h"
#import <Social/Social.h>
#import "GxShareVideoHelper.h"

@interface GXShareTwitterTask ()

@end

@implementation GXShareTwitterTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeTwitter;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (composeViewController) {
            [composeViewController addImage:image];
            if(shareURL) {
                [composeViewController addURL:shareURL];
            }
            [composeViewController setInitialText:description];
            [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"Posted");
                } else if (result == SLComposeViewControllerResultCancelled) {
                    NSLog(@"Post Cancelled");
                } else {
                    NSLog(@"Post Failed");
                }
            }];
            [controller presentViewController:composeViewController animated:YES completion:nil];
        }
    }
}

- (void)shareVideo:(NSURL *)videoURL
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:twitterAccountType
                                          options:nil
                                       completion:^(BOOL granted, NSError *error) {
                                           if(granted) {
                                               NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
                                               if(twitterAccounts.count > 0) {
                                                   [GxShareVideoHelper uploadTwitterVideo:[NSData dataWithContentsOfURL:videoURL]
                                                                                  comment:description
                                                                                  account:[twitterAccounts lastObject]
                                                                           withCompletion:^(BOOL success, NSString *errorMessage) {
                                                                               
                                                                           }];
                                               }
                                           }
                                       }];
    
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    [super associateDelegate:delegate];
}

@end
