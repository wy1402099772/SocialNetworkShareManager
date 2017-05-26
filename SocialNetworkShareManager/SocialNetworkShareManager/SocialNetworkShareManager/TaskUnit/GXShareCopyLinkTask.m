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

@property (nonatomic, assign) GXShareType shareType;
@property (nonatomic, weak) id<GXShareTaskDelegate> delegate;

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

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    _delegate = delegate;
}


@end
