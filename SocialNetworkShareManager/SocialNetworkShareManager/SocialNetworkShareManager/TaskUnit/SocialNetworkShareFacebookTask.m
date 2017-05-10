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
              type:(id)shareType
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    [FBSDKShareDialog showFromViewController:controller
                                 withContent:content
                                    delegate:self];
    
}

#pragma mark - FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
}

@end
