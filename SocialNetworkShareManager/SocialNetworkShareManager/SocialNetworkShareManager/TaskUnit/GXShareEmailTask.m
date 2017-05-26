//
//  GXShareEmailTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareEmailTask.h"
#import "GXShareManager.h"
#import <MessageUI/MessageUI.h>

@interface GXShareEmailTask () <MFMailComposeViewControllerDelegate>

@end

@implementation GXShareEmailTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeEmail;
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
    
    MFMailComposeViewController *comp = [[MFMailComposeViewController alloc]init];
    [comp setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail])
    {
        if(caption) {
            [comp setSubject:caption];
        }
        if(description) {
            [comp setMessageBody:description isHTML:NO];
        }
        if(image) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            NSString *fileName = [@"share" stringByAppendingPathExtension:@"jpeg"];
            [comp addAttachmentData:imageData mimeType:@"image/jpeg" fileName:fileName];
        }
        
        if (comp)
        {
            [controller presentViewController:comp animated:YES completion:nil];
        }
    }
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    [super associateDelegate:delegate];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
