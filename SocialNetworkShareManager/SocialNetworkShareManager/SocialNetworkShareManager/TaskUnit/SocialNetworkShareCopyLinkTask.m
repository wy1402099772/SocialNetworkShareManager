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
             model:(SocialNetworkShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    if(description) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:description];
        if(self.delegate && [self.delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
            [self.delegate requestShareManagerToShowAlert:shareModel.requestTitle
                                                  message:shareModel.requestDesc
                                              confirmInfo:shareModel.confirmStr
                                               cancelInfo:shareModel.cancelStr
                                                    delay:shareModel.delayInterval
                                               completion:^(BOOL success) {
                                                   if(success) {
                                                       
                                                   }
                                               }];
        }
    }
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}


@end
