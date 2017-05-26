//
//  GXShareTaskProtocol.h
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GXShareManager.h"
#import "GXShareTaskDelegate.h"
#import "GXShareCellModel.h"

@class UIImage, UIViewController;

@protocol GXShareTaskProtocol <NSObject>

- (instancetype)init;

- (BOOL)willCallbackWhenShareStop;

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller;

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate;

@end
