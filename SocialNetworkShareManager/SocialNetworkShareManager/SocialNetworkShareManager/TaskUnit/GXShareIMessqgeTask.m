//
//  GXShareIMessageTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareIMessqgeTask.h"
#import "GXShareManager.h"
#import <MessageUI/MessageUI.h>

@interface GXShareIMessqgeTask () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, assign) GXShareType shareType;
@property (nonatomic, weak) id<GXShareTaskDelegate> delegate;

@end

@implementation GXShareIMessqgeTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeIMessage;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(UIImage *)image
           caption:(NSString *)caption
       description:(NSString *)description
             model:(GXShareCellModel *)shareModel
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setBody:description];
        if([MFMessageComposeViewController canSendAttachments] && image) {
            NSData *imgData = UIImagePNGRepresentation(image);
            [messageController addAttachmentData:imgData typeIdentifier:@"public.data" filename:@"image.png"];
        }
        [controller presentViewController:messageController animated:YES completion:nil];
    }
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    _delegate = delegate;
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
