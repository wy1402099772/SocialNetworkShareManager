//
//  SocialNetworkShareParameters.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SNSCompletion)(BOOL success, NSError *error);

#define kSocialAlbumName @"SocialShare"

#define kSocialShareViewheight 167

#define SNS_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SNS_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SNS_SCREENAPPLYSPACE(x) SNS_SCREEN_WIDTH / 375.0 * (x)
#define SNS_SCREENAPPLYHEIGHT(x) SNS_SCREEN_HEIGHT / 667.0 * (x)

#define SNS_RESOUCE_BUNDLE [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SocialNetworkShare" ofType:@"bundle"]]

#define SNS_IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SNS_UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SNS_UIColorFromRGB(r,g,b)               SNS_UIColorFromRGBA(r,g,b,1.0)

#undef	SNS_AS_SINGLETON
#define SNS_AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	SNS_DEF_SINGLETON
#define SNS_DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
} \
- (id)init \
{ \
if (self = [super init] ) \
{ \
\
} \
return self; \
}

@interface SocialNetworkShareParameters : NSObject

+ (UIFont*)getFontRegular:(CGFloat)fontSize;
+ (UIFont*)getFontHeavy:(CGFloat)fontSize;
+ (UIFont *)getFontLight:(CGFloat)fontSize;

@end
