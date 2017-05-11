//
//  SocialNetworkShareTaskProtocol.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialNetworkShareManager.h"
#import "SocialNetworkShareTaskDelegate.h"
#import "SocialNetworkShareCellModel.h"

@class UIImage, UIViewController;

@protocol SocialNetworkShareTaskProtocol <NSObject>

- (instancetype)init;

- (BOOL)willCallbackWhenShareStop;

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(SocialNetworkShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller;

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate;

@end
