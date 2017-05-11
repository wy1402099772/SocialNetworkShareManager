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
@property (nonatomic, weak) id<SocialNetworkShareTaskDelegate> delegate;

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
                    if(description.length) {
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        [pasteboard setString:description];
                    }
                    if(description.length && self.delegate && [self.delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:completion:)]) {
                        [self.delegate requestShareManagerToShowAlert:@"Post and tag your photo" message:@"Your link to share has been copied. You can directly paste the link and share with your friends when you send it" confirmInfo:@"Go To Instagram" cancelInfo:nil completion:^(BOOL success) {
                            if(success) {
                                NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[SocialNetworkShareAlbumUtil getLastAssetURL] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                                [[UIApplication sharedApplication] openURL:instagramURL];
                            }
                        }];
                    } else {
                        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[SocialNetworkShareAlbumUtil getLastAssetURL] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                        [[UIApplication sharedApplication] openURL:instagramURL];
                    }
                } else {
                    
                }
            }];
        } else {
            
        }
    }];
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}

@end
