//
//  GXShareMessagerTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareMessengerTask.h"
#import "GXShareManager.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface GXShareMessengerTask ()

@end

@implementation GXShareMessengerTask

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
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    [FBSDKMessengerSharer shareImage:image withOptions:nil];
}

- (void)shareVideo:(NSURL *)videoURL
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    [super associateDelegate:delegate];
}

@end
