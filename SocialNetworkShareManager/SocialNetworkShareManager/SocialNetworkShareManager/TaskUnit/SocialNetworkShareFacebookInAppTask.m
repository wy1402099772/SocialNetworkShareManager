//
//  SocialNetworkShareFacebookInAppTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareFacebookInAppTask.h"
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareFacebookInAppTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;
@property (nonatomic, weak) id<SocialNetworkShareTaskDelegate> delegate;

@end

@implementation SocialNetworkShareFacebookInAppTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeFacebookInApp;
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
    
    if(description.length && self.delegate && [self.delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
        [self.delegate requestShareManagerToShowAlert:shareModel.requestTitle
                                              message:shareModel.requestDesc
                                          confirmInfo:shareModel.confirmStr
                                           cancelInfo:shareModel.cancelStr
                                                delay:shareModel.delayInterval
                                           completion:^(BOOL success) {
                                               if(success) {
                                                   
                                               }
                                           }];
    } else {
        
    }
}

- (void)associateDelegate:(id<SocialNetworkShareTaskDelegate>)delegate {
    _delegate = delegate;
}

@end
