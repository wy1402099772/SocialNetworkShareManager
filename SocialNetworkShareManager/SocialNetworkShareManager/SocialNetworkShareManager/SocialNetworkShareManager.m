//
//  SocialNetworkShareManager.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareManager.h"
#import "SocialNetworkShareTaskProtocol.h"
#import "SocialNetworkShareInstagramTask.h"
#import "SocialNetworkShareFacebookTask.h"
#import "SocialNetworkShareFacebookInAppTask.h"
#import "SocialNetworkShareTwitterTask.h"
#import "SocialNetworkShareWhatsAppTask.h"
#import "SocialNetworkShareMessagerTask.h"
#import "SocialNetworkShareIMessageTask.h"
#import "SocialNetworkShareEmailTask.h"
#import "SocialNetworkShareLineTask.h"
#import "SocialNetworkShareCopyLinkTask.h"

SocialNetworkShareType SNSTypeFacebook          = @"SNSTypeFacebook";
SocialNetworkShareType SNSTypeInstagram         = @"SNSTypeInstagram";
SocialNetworkShareType SNSTypeTwitter           = @"SNSTypeTwitter";
SocialNetworkShareType SNSTypeMessager          = @"SNSTypeMessager";
SocialNetworkShareType SNSTypeWhatsApp          = @"SNSTypeWhatsApp";
SocialNetworkShareType SNSTypeIMessage          = @"SNSTypeIMessage";
SocialNetworkShareType SNSTypeEmail             = @"SNSTypeEmail";
SocialNetworkShareType SNSTypeLine              = @"SNSTypeLine";
SocialNetworkShareType SNSTypeyLinkCopy         = @"SNSTypeyLinkCopy";
SocialNetworkShareType SNSTypeFacebookInApp     = @"SNSTypeFacebookInApp";

@interface SocialNetworkShareManager ()

@property (nonatomic, strong) NSMutableDictionary<SocialNetworkShareType, NSObject<SocialNetworkShareTaskProtocol> *> *taskDict;

@end

@implementation SocialNetworkShareManager

SNS_DEF_SINGLETON(SocialNetworkShareManager)

- (void)shareImage:(UIImage *)image caption:(NSString *)caption description:(NSString *)description type:(SocialNetworkShareType)shareType andAssociatedVC:(UIViewController *)controller {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self getSNSTaskFromShareType:shareType];
    [task shareImage:image
             caption:caption
         description:description
                type:shareType
           albumName:self.albumName
     andAssociatedVC:controller];
}

- (BOOL)willShareCallback:(SocialNetworkShareType)shareType {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self getSNSTaskFromShareType:shareType];
    return [task willCallbackWhenShareStop];
}

#pragma mark - Private
- (NSObject<SocialNetworkShareTaskProtocol> *)getSNSTaskFromShareType:(SocialNetworkShareType)shareType {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self.taskDict objectForKey:shareType];
    if(!task) {
        if([shareType isEqualToString:SNSTypeFacebook]) {
            task = [[SocialNetworkShareFacebookTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeInstagram]) {
            task = [[SocialNetworkShareInstagramTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeTwitter]) {
            task = [[SocialNetworkShareTwitterTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeMessager]) {
            task = [[SocialNetworkShareMessagerTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeWhatsApp]) {
            task = [[SocialNetworkShareWhatsAppTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeIMessage]) {
            task = [[SocialNetworkShareIMessageTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeEmail]) {
            task = [[SocialNetworkShareEmailTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeLine]) {
            task = [[SocialNetworkShareLineTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeyLinkCopy]) {
            task = [[SocialNetworkShareCopyLinkTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeFacebookInApp]) {
            task = [[SocialNetworkShareFacebookInAppTask alloc] init];
        }
        
        if(task) {
            [self.taskDict setObject:task forKey:shareType];
        }
    }
    return task;
}

#pragma mark - Getter
- (NSMutableDictionary<SocialNetworkShareType,NSObject<SocialNetworkShareTaskProtocol> *> *)taskDict {
    if(!_taskDict) {
        _taskDict = [NSMutableDictionary dictionary];
    }
    return _taskDict;
}

- (NSString *)albumName {
    if(!_albumName) {
        return kSocialAlbumName;
    } else {
        return _albumName;
    }
}

@end
