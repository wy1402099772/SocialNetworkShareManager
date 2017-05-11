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
    return @[@{
                 kSNSTypeKey        : SNSTypeInstagram,
                 kSNSTitleKey       : @"Instagram\n",
                 kSNSImageStrKey    : @"image_share_instagram@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeTwitter,
                 kSNSTitleKey       : @"Twitter\n",
                 kSNSImageStrKey    : @"image_share_twitter@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeFacebook,
                 kSNSTitleKey       : @"Facebook\n",
                 kSNSImageStrKey    : @"image_share_facebook@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeMessenger,
                 kSNSTitleKey       : @"Messenger\n",
                 kSNSImageStrKey    : @"image_share_messager@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeWhatsApp,
                 kSNSTitleKey       : @"WhatsApp\n",
                 kSNSImageStrKey    : @"image_share_whatsapp@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeIMessage,
                 kSNSTitleKey       : @"iMessage\n",
                 kSNSImageStrKey    : @"image_share_imessage@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeEmail,
                 kSNSTitleKey       : @"E-Mail\n",
                 kSNSImageStrKey    : @"image_share_email@3x"
                 },
             @{
                 kSNSTypeKey        : SNSTypeyLinkCopy,
                 kSNSTitleKey       : @"Copy Link\n",
                 kSNSImageStrKey    : @"image_share_copy_link@3x"
                 },
             ];
}

@end
