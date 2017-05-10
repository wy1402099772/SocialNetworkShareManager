//
//  SocialNetworkShareCopyLinkTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareCopyLinkTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareCopyLinkTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareCopyLinkTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeyLinkCopy;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image
           caption:(NSString *)caption
       description:(NSString *)description
              type:(id)shareType
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    
}

@end
