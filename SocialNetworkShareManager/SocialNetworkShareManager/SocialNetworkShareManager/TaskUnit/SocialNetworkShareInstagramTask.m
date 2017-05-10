//
//  SocialNetworkShareInstagramTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareInstagramTask.h"
#import "SocialNetworkShareManager.h"
#import "SocialNetworkShareAlbumUtil.h"

@interface SocialNetworkShareInstagramTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareInstagramTask

#pragma mark - SocialNetworkShareTaskProtocol
- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeInstagram;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image
           caption:(NSString *)caption
       description:(NSString *)description
              type:(id)shareType
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    [SocialNetworkShareAlbumUtil configAlbumsWithName:albumName completion:^(BOOL success, NSError *error) {
        if(success) {
            [SocialNetworkShareAlbumUtil saveImage:image toAlbum:albumName completion:^(BOOL saveflag) {
                if(saveflag) {
                    if(description) {
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        [pasteboard setString:description];
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[SocialNetworkShareAlbumUtil getLastAssetURL] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                        [[UIApplication sharedApplication] openURL:instagramURL];
                    });
                } else {
                    
                }
            }];
        } else {
            
        }
    }];
    
    
}

@end
