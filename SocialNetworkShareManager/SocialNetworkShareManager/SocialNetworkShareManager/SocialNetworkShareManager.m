//
//  SocialNetworkShareManager.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareManager.h"
#import "SNSDropdownView.h"

#import "SocialNetworkShareTaskProtocol.h"
#import "SocialNetworkShareInstagramTask.h"
#import "SocialNetworkShareFacebookTask.h"
#import "SocialNetworkShareFacebookInAppTask.h"
#import "SocialNetworkShareTwitterTask.h"
#import "SocialNetworkShareWhatsAppTask.h"
#import "SocialNetworkShareMessengerTask.h"
#import "SocialNetworkShareIMessqgeTask.h"
#import "SocialNetworkShareEmailTask.h"
#import "SocialNetworkShareLineTask.h"
#import "SocialNetworkShareCopyLinkTask.h"
#import "SocialNetworkShareView.h"
#import "SocialNetworkShareCellModel.h"

SocialNetworkShareType SNSTypeFacebook          = @"SNSTypeFacebook";
SocialNetworkShareType SNSTypeInstagram         = @"SNSTypeInstagram";
SocialNetworkShareType SNSTypeTwitter           = @"SNSTypeTwitter";
SocialNetworkShareType SNSTypeMessenger         = @"SNSTypeMessenger";
SocialNetworkShareType SNSTypeWhatsApp          = @"SNSTypeWhatsApp";
SocialNetworkShareType SNSTypeIMessage          = @"SNSTypeIMessage";
SocialNetworkShareType SNSTypeEmail             = @"SNSTypeEmail";
SocialNetworkShareType SNSTypeLine              = @"SNSTypeLine";
SocialNetworkShareType SNSTypeyLinkCopy         = @"SNSTypeyLinkCopy";
SocialNetworkShareType SNSTypeFacebookInApp     = @"SNSTypeFacebookInApp";

@interface SocialNetworkShareManager () <SNSDropdownViewDelegate, SocialNetworkShareViewDelegate>

@property (nonatomic, strong) NSMutableDictionary<SocialNetworkShareType, NSObject<SocialNetworkShareTaskProtocol> *> *taskDict;

@property (nonatomic, strong) SNSDropdownView *dropdownView;
@property (nonatomic, strong) SocialNetworkShareView *shareView;

@end

@implementation SocialNetworkShareManager

+ (instancetype)sharedInstance {
    static SocialNetworkShareManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SocialNetworkShareManager alloc] init];
    });
    return instance;
}

- (void)shareImage:(UIImage *)image caption:(NSString *)caption description:(NSString *)description type:(SocialNetworkShareType)shareType andAssociatedVC:(UIViewController *)controller {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self getSNSTaskFromShareType:shareType];
    [task shareImage:image
             caption:caption
         description:description
                type:shareType
            shareUrl:nil
           albumName:self.albumName
     andAssociatedVC:controller];
}

- (BOOL)willShareCallback:(SocialNetworkShareType)shareType {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self getSNSTaskFromShareType:shareType];
    return [task willCallbackWhenShareStop];
}

- (void)showShareViewWithAssociatedVC:(UIViewController *)controller {
    [self.dropdownView showInView:controller.view withContentView:self.shareView atOrigin:CGPointMake(0, controller.view.bounds.size.height - SNS_SCREENAPPLYHEIGHT(kSocialShareViewheight))];
}

#pragma mark - Private
- (NSObject<SocialNetworkShareTaskProtocol> *)getSNSTaskFromShareType:(SocialNetworkShareType)shareType {
    NSObject<SocialNetworkShareTaskProtocol> *task = [self.taskDict objectForKey:shareType];
    if(!task) {
        if([shareType isEqualToString:SNSTypeFacebook]) {
            task = [[SocialNetworkShareFacebookTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeInstagram]) {
            task = [[SocialNetworkShareInstagramTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeTwitter]) {
            task = [[SocialNetworkShareTwitterTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeMessenger]) {
            task = [[SocialNetworkShareMessengerTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeWhatsApp]) {
            task = [[SocialNetworkShareWhatsAppTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeIMessage]) {
            task = [[SocialNetworkShareIMessqgeTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeEmail]) {
            task = [[SocialNetworkShareEmailTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeLine]) {
            task = [[SocialNetworkShareLineTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeyLinkCopy]) {
            task = [[SocialNetworkShareCopyLinkTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeFacebookInApp]) {
            task = [[SocialNetworkShareFacebookInAppTask alloc] init];
        }
        
        if(task) {
            [self.taskDict setObject:task forKey:shareType];
        }
    }
    return task;
}

#pragma mark - SocialNetworkShareViewDelegate
- (void)soicalShareViewDidClose {
    [self.dropdownView hide];
}

- (void)soicalShareViewDidSelectCell:(SocialNetworkShareCellModel *)cellModel {
    [self.dropdownView hide];
    if(self.associatedVC) {
        [[SocialNetworkShareManager sharedInstance] shareImage:[UIImage imageNamed:@"image_comment_banner"]
                                                       caption:@"Caption"
                                                   description:@"hello, word"
                                                          type:cellModel.shareType
                                               andAssociatedVC:self.associatedVC];
    }
}


#pragma mark - SNSDropdownViewDelegate
- (void)dropdownViewWillShow:(SNSDropdownView *)dropdownView {
    
}

- (void)dropdownViewDidShow:(SNSDropdownView *)dropdownView {
    
}

- (void)dropdownViewWillHide:(SNSDropdownView *)dropdownView {
    
}

- (void)dropdownViewDidHide:(SNSDropdownView *)dropdownView {
    
}


#pragma mark - Getter
- (NSMutableDictionary<SocialNetworkShareType,NSObject<SocialNetworkShareTaskProtocol> *> *)taskDict {
    if(!_taskDict) {
        _taskDict = [NSMutableDictionary dictionary];
    }
    return _taskDict;
}

- (NSString *)albumName {
    if(!_albumName) {
        return kSocialAlbumName;
    } else {
        return _albumName;
    }
}

- (SNSDropdownView *)dropdownView {
    if (!_dropdownView) {
        _dropdownView = [SNSDropdownView dropdownView];
        _dropdownView.delegate = self;
        _dropdownView.closedScale = 1;
        _dropdownView.blurRadius = 0;
        _dropdownView.animationBounceHeight = 0;
        _dropdownView.blackMaskAlpha = 0.4;
        _dropdownView.direction = SNSDropdownViewDirectionBottom;
    }
    return _dropdownView;
}

- (SocialNetworkShareView *)shareView {
    if(!_shareView) {
        _shareView = [[SocialNetworkShareView alloc] initWithFrame:CGRectMake(0, 0, SNS_SCREEN_WIDTH, SNS_SCREENAPPLYHEIGHT(kSocialShareViewheight))];
        _shareView.delegate = self;
    }
    return _shareView;
}


@end
