//
//  SocialNetworkShareTaskProtocol.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialNetworkShareManager.h"

@class UIImage, UIViewController;

@protocol SocialNetworkShareTaskProtocol <NSObject>

- (instancetype)init;

- (BOOL)willCallbackWhenShareStop;

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
              type:(SocialNetworkShareType)shareType
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller;

@end
