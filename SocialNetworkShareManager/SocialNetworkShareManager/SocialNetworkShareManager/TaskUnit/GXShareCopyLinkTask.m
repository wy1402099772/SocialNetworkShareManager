//
//  GXShareCopyLinkTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareCopyLinkTask.h"
#import "GXShareManager.h"

@interface GXShareCopyLinkTask ()

@end

@implementation GXShareCopyLinkTask

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
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    if(description) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:description];
        if(_delegate && [_delegate respondsToSelector:@selector(requestShareManagerToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
            [_delegate requestShareManagerToShowAlert:shareModel.requestTitle
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

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    [super associateDelegate:delegate];
}


@end
