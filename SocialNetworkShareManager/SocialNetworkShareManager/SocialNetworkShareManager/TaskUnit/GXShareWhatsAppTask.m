//
//  GXShareWhatsAppTask.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareWhatsAppTask.h"
#import "GXShareManager.h"

@interface GXShareWhatsAppTask ()

@property (nonatomic, assign) GXShareType shareType;
@property (nonatomic, weak) id<GXShareTaskDelegate> delegate;

@end

@implementation GXShareWhatsAppTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeWhatsApp;
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
    NSMutableCharacterSet *chars = NSCharacterSet.URLQueryAllowedCharacterSet.mutableCopy;
    [chars removeCharactersInRange:NSMakeRange('&', 1)]; // %26
    NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@", [description stringByAddingPercentEncodingWithAllowedCharacters:chars]]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}

- (void)associateDelegate:(id<GXShareTaskDelegate>)delegate {
    _delegate = delegate;
}

@end
