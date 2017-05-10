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

@end

@interface SocialNetworkShareManager : NSObject

SNS_AS_SINGLETON(SocialNetworkShareManager)

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
              type:(SocialNetworkShareType)shareType
   andAssociatedVC:(UIViewController *)controller;

- (BOOL)willShareCallback:(SocialNetworkShareType)shareType;

@property (nonatomic, strong) NSString *albumName;

@end
