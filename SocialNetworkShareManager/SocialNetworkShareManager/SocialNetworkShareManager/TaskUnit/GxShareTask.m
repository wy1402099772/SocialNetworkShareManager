//
//  GxShareTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 2017/5/26.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "GxShareTask.h"
#import "GXShareManager.h"

@interface GxShareTask () {
   
}

@end

@implementation GxShareTask

- (instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    _delegate = delegate;
}

@end
