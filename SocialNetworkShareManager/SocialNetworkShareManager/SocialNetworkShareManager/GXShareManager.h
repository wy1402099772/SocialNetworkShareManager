//
//  GXShareManager.h
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GXShareParameters.h"
#import <AVFoundation/AVFoundation.h>

@class GXShareCellModel;

typedef NSString* GXShareType;

extern GXShareType SNSTypeFacebook;
extern GXShareType SNSTypeInstagram;
extern GXShareType SNSTypeTwitter;
extern GXShareType SNSTypeMessenger;
extern GXShareType SNSTypeWhatsApp;
extern GXShareType SNSTypeIMessage;
extern GXShareType SNSTypeEmail;
extern GXShareType SNSTypeLine;
extern GXShareType SNSTypeyLinkCopy;
extern GXShareType SNSTypeFacebookInApp;

@protocol GXShareManagerDelegate <NSObject>

- (void)shareManagerRequestToShowAlert:(NSString *)title
                               message:(NSString *)message
                           confirmInfo:(NSString *)confirmInfo
                            cancelInfo:(NSString *)cancelInfo
                                 delay:(NSUInteger)delayInterval
                            completion:(void (^)(BOOL))block;

@end

@interface GXShareManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)willShareCallback:(GXShareType)shareType;

- (void)showShareViewWithAssociatedVC:(UIViewController *)controller;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *videoURL;

@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, weak)   UIViewController *associatedVC;
@property (nonatomic, strong) NSArray<NSDictionary *> *cellConfig;
@property (nonatomic, weak)   id<GXShareManagerDelegate> delegate;

@end
