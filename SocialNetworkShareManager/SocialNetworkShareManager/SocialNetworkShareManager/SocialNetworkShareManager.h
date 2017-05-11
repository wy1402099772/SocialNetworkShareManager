//
//  SocialNetworkShareManager.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SocialNetworkShareParameters.h"

@class SocialNetworkShareCellModel;

typedef NSString* SocialNetworkShareType;

extern SocialNetworkShareType SNSTypeFacebook;
extern SocialNetworkShareType SNSTypeInstagram;
extern SocialNetworkShareType SNSTypeTwitter;
extern SocialNetworkShareType SNSTypeMessenger;
extern SocialNetworkShareType SNSTypeWhatsApp;
extern SocialNetworkShareType SNSTypeIMessage;
extern SocialNetworkShareType SNSTypeEmail;
extern SocialNetworkShareType SNSTypeLine;
extern SocialNetworkShareType SNSTypeyLinkCopy;
extern SocialNetworkShareType SNSTypeFacebookInApp;

@protocol SocialNetworkShareManagerDelegate <NSObject>

- (void)shareManagerRequestToShowAlert:(NSString *)title
                               message:(NSString *)message
                           confirmInfo:(NSString *)confirmInfo
                            cancelInfo:(NSString *)cancelInfo
                                 delay:(NSUInteger)delayInterval
                            completion:(void (^)(BOOL))block;

@end

@interface SocialNetworkShareManager : NSObject

+ (instancetype)sharedInstance;

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(SocialNetworkShareCellModel *)shareModel
   andAssociatedVC:(UIViewController *)controller;

- (BOOL)willShareCallback:(SocialNetworkShareType)shareType;

- (void)showShareViewWithAssociatedVC:(UIViewController *)controller;

@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, weak)   UIViewController *associatedVC;
@property (nonatomic, weak)   id<SocialNetworkShareManagerDelegate> delegate;

@end
