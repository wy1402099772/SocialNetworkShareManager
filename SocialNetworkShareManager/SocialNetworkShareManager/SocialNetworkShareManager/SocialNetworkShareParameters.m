//
//  SocialNetworkShareParameters.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareParameters.h"

@implementation SocialNetworkShareParameters

+ (UIFont*)getFontRegular:(CGFloat)fontSize
{
    UIFont* fontRegular;
    if(SNS_IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        fontRegular = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:fontSize];
    }
    else
    {
        fontRegular = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    }
    
    if(fontRegular == nil)
    {
        fontRegular = [UIFont systemFontOfSize:fontSize];
    }
    return fontRegular;
}

+ (UIFont*)getFontHeavy:(CGFloat)fontSize
{
    UIFont* fontHeavy;
    if(SNS_IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        fontHeavy = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
    }
    else
    {
        fontHeavy = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
    }
    
    if(fontHeavy == nil)
    {
        fontHeavy = [UIFont boldSystemFontOfSize:fontSize];
    }
    return fontHeavy;
}

+ (UIFont *)getFontLight:(CGFloat)fontSize
{
    UIFont* fontLight;
    fontLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:fontSize];
    
    if(fontLight == nil)
    {
        fontLight = [UIFont systemFontOfSize:fontSize];
    }
    return fontLight;
}

+ (NSArray<NSDictionary *> *)getSharePlatformConfig {
    return @[
             @{
                 kSNSTypeKey        : SNSTypeInstagram,
                 kSNSTitleKey       : @"Instagram\n",
                 kSNSImageStrKey    : @"image_share_instagram@3x",
                 kSNSRequestTitleKey: @"Post and tag your photo",
                 kSNSRequestDescKey : @"Your link to share has been copied. You can directly paste the link and share with your friends when you send it",
                 kSNSConfirmKey     : @"Go To Instagram",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeTwitter,
                 kSNSTitleKey       : @"Twitter\n",
                 kSNSImageStrKey    : @"image_share_twitter@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeFacebook,
                 kSNSTitleKey       : @"Facebook\n",
                 kSNSImageStrKey    : @"image_share_facebook@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeMessenger,
                 kSNSTitleKey       : @"Messenger\n",
                 kSNSImageStrKey    : @"image_share_messager@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeWhatsApp,
                 kSNSTitleKey       : @"WhatsApp\n",
                 kSNSImageStrKey    : @"image_share_whatsapp@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeIMessage,
                 kSNSTitleKey       : @"iMessage\n",
                 kSNSImageStrKey    : @"image_share_imessage@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeEmail,
                 kSNSTitleKey       : @"E-Mail\n",
                 kSNSImageStrKey    : @"image_share_email@3x",
                 kSNSRequestTitleKey: @"",
                 kSNSRequestDescKey : @"",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(0)
                 },
             @{
                 kSNSTypeKey        : SNSTypeyLinkCopy,
                 kSNSTitleKey       : @"Copy Link\n",
                 kSNSImageStrKey    : @"image_share_copy_link@3x",
                 kSNSRequestTitleKey: @"Copied to Clipboard",
                 kSNSRequestDescKey : @"Your link to share has been copied. You can directly paste the link and share with your friends.",
                 kSNSConfirmKey     : @"",
                 kSNSCancelKey      : @"",
                 kSNSDelayKey       : @(2)
                 },
             ];
}

@end
