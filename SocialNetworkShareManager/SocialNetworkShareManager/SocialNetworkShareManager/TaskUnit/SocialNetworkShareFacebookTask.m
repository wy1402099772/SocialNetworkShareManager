//
//  SocialNetworkShareFacebookTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareFacebookTask.h"
#import "SocialNetworkShareManager.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface SocialNetworkShareFacebookTask () <FBSDKSharingDelegate>

@property (nonatomic, assign) SocialNetworkShareType shareType;
@property (nonatomic, weak) id<SocialNetworkShareTaskDelegate> delegate;

@end

@implementation SocialNetworkShareFacebookTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeFacebook;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(SocialNetworkShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    if(description.length && self.delegate && [self.delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
        [self.delegate requestShareManagerToShowAlert:shareModel.requestTitle
                                              message:shareModel.requestDesc
                                          confirmInfo:shareModel.confirmStr
                                           cancelInfo:shareModel.cancelStr
                                                delay:shareModel.delayInterval
                                           completion:^(BOOL success) {
                                               if(success) {
                                                   [FBSDKShareDialog showFromViewController:controller
                                                                                withContent:content
                                                                                   delegate:self];
                                               }
                                           }];
    } else {
        [FBSDKShareDialog showFromViewController:controller
                                     withContent:content
                                        delegate:self];
    }
    
    
    
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}

#pragma mark - FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
}

@end
