//
//  SocialNetworkShareCopyLinkTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareCopyLinkTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareCopyLinkTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;
@property (nonatomic, weak) id<SocialNetworkShareTaskDelegate> delegate;

@end

@implementation SocialNetworkShareCopyLinkTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeyLinkCopy;
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
    
    if(description) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:description];
        if(self.delegate && [self.delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:completion:)]) {
            [self.delegate requestShareManagerToShowAlert:@"Copy Successfully" message:@"Your link to share has been copied. You can directly paste the link and share with your friends." confirmInfo:@"Sure" cancelInfo:nil completion:nil];
        }
    }
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}


@end
