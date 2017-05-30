//
//  GXShareInstagramTask.m
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareInstagramTask.h"
#import "GXShareManager.h"
#import "GXShareAlbumUtil.h"

@interface GXShareInstagramTask ()

@end

@implementation GXShareInstagramTask

#pragma mark - GXShareTaskProtocol
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
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    [GXShareAlbumUtil configAlbumsWithName:albumName completion:^(BOOL success, NSError *error) {
        if(success) {
            [GXShareAlbumUtil saveImage:image toAlbum:albumName completion:^(BOOL saveflag) {
                if(saveflag) {
                    if(description.length) {
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        [pasteboard setString:description];
                    }
                    if(description.length && _delegate && [_delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
                        [_delegate requestShareManagerToShowAlert:shareModel.requestTitle
                                                              message:shareModel.requestDesc
                                                          confirmInfo:shareModel.confirmStr
                                                           cancelInfo:shareModel.cancelStr
                                                                delay:shareModel.delayInterval
                                                           completion:^(BOOL success) {
                            if(success) {
                                NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[GXShareAlbumUtil getLastImageURL:PHAssetMediaTypeImage] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                                [[UIApplication sharedApplication] openURL:instagramURL];
                            }
                        }];
                    } else {
                        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[GXShareAlbumUtil getLastImageURL:PHAssetMediaTypeImage] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                        [[UIApplication sharedApplication] openURL:instagramURL];
                    }
                } else {
                    
                }
            }];
        } else {
            
        }
    }];
}

- (void)shareVideo:(NSURL *)videoURL
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    [GXShareAlbumUtil configAlbumsWithName:albumName completion:^(BOOL success, NSError *error) {
        if(success) {
            [GXShareAlbumUtil saveVideo:videoURL toAlbum:albumName completion:^(BOOL saveFlag) {
                if(saveFlag) {
                    if(description.length) {
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        [pasteboard setString:description];
                    }
                    if(description.length && _delegate && [_delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
                        [_delegate requestShareManagerToShowAlert:shareModel.requestTitleForVideo
                                                          message:shareModel.requestDesc
                                                      confirmInfo:shareModel.confirmStr
                                                       cancelInfo:shareModel.cancelStr
                                                            delay:shareModel.delayInterval
                                                       completion:^(BOOL success) {
                                                           if(success) {
                                                               NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[GXShareAlbumUtil getLastImageURL:PHAssetMediaTypeVideo] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                                                               [[UIApplication sharedApplication] openURL:instagramURL];
                                                           }
                                                       }];
                    } else {
                        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",[[[GXShareAlbumUtil getLastImageURL:PHAssetMediaTypeVideo] absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
                        [[UIApplication sharedApplication] openURL:instagramURL];
                    }
                } else {
                    
                }
            }];
        }
    }];
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    [super associateDelegate:delegate];
}

@end
