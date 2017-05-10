//
//  SocialNetworkShareEmailTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareEmailTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareEmailTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareEmailTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeEmail;
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
