//
//  SocialNetworkShareLineTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareLineTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareLineTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareLineTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeLine;
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
