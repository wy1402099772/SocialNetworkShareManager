//
//  SocialNetworkShareInstagramTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareInstagramTask.h"
#import "SocialNetworkShareManager.h"
#import "SocialNetworkShareAlbumUtil.h"

@interface SocialNetworkShareInstagramTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareInstagramTask

#pragma mark - SocialNetworkShareTaskProtocol
- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeInstagram;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image caption:(NSString *)caption description:(NSString *)description type:(id)shareType albumName:(NSString *)albumName andAssociatedVC:(UIViewController *)controller {
    [SocialNetworkShareAlbumUtil configAlbumsWithName:albumName];
}

@end
