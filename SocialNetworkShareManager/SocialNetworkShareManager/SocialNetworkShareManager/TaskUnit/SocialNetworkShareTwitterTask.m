//
//  SocialNetworkShareTwitterTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareTwitterTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareTwitterTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareTwitterTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeTwitter;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image caption:(NSString *)caption description:(NSString *)description type:(id)shareType albumName:(NSString *)albumName andAssociatedVC:(UIViewController *)controller {
    
    
}

@end
