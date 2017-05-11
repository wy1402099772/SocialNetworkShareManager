//
//  SocialNetworkShareMessagerTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareMessengerTask.h"
#import "SocialNetworkShareManager.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface SocialNetworkShareMessengerTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;
@property (nonatomic, weak) id<SocialNetworkShareTaskDelegate> delegate;

@end

@implementation SocialNetworkShareMessengerTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeMessenger;
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
    
    [FBSDKMessengerSharer shareImage:image withOptions:nil];
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}

@end
