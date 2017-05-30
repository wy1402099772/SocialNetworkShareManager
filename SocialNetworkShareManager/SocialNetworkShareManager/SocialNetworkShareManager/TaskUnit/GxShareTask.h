//
//  GxShareTask.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 2017/5/26.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GXShareTaskProtocol.h"

@interface GxShareTask : NSObject {
@protected
    GXShareType _shareType;
    id<GXShareTaskDelegate> _delegate;
}

#pragma mark - GXShareTaskProtocol
- (instancetype)init;

- (BOOL)willCallbackWhenShareStop;

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller;

- (void)shareVideo:(NSURL *)videoURL
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller;

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate;

@end
