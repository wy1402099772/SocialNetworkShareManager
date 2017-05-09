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

SocialNetworkShareType SNSTypeFacebookInApp     = @"SNSTypeFacebook";
SocialNetworkShareType SNSTypeInstagram         = @"SNSTypeInstagram";
SocialNetworkShareType SNSTypeTwitter           = @"SNSTypeTwitter";
SocialNetworkShareType SNSTypeMessager          = @"SNSTypeMessager";
SocialNetworkShareType SNSTypeWhatsApp          = @"SNSTypeWhatsApp";
SocialNetworkShareType SNSTypeIMessage          = @"SNSTypeIMessage";
SocialNetworkShareType SNSTypeEmail             = @"SNSTypeEmail";
SocialNetworkShareType SNSTypeLine              = @"SNSTypeLine";
SocialNetworkShareType SNSTypeyLinkCopy         = @"SNSTypeyLinkCopy";

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
        if([shareType isEqualToString:SNSTypeFacebookInApp]) {
            
        } else if ([shareType isEqualToString:SNSTypeFacebookInApp]) {
            
        } else if ([shareType isEqualToString:SNSTypeInstagram]) {
            task = [[SocialNetworkShareInstagramTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeTwitter]) {
            
        } else if ([shareType isEqualToString:SNSTypeMessager]) {
            
        } else if ([shareType isEqualToString:SNSTypeWhatsApp]) {
            
        } else if ([shareType isEqualToString:SNSTypeIMessage]) {
            
        } else if ([shareType isEqualToString:SNSTypeEmail]) {
            
        } else if ([shareType isEqualToString:SNSTypeLine]) {
            
        } else if ([shareType isEqualToString:SNSTypeyLinkCopy]) {
            
        } else {
            
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
