//
//  GXShareManager.m
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareManager.h"
#import "SNSDropdownView.h"

#import "GXShareTaskProtocol.h"
#import "GXShareInstagramTask.h"
#import "GXShareFacebookTask.h"
#import "GXShareTwitterTask.h"
#import "GXShareWhatsAppTask.h"
#import "GXShareMessengerTask.h"
#import "GXShareIMessqgeTask.h"
#import "GXShareEmailTask.h"
#import "GXShareLineTask.h"
#import "GXShareCopyLinkTask.h"
#import "GXShareView.h"
#import "GXShareCellModel.h"

#import "GxShareTask.h"

GXShareType SNSTypeFacebook          = @"SNSTypeFacebook";
GXShareType SNSTypeInstagram         = @"SNSTypeInstagram";
GXShareType SNSTypeTwitter           = @"SNSTypeTwitter";
GXShareType SNSTypeMessenger         = @"SNSTypeMessenger";
GXShareType SNSTypeWhatsApp          = @"SNSTypeWhatsApp";
GXShareType SNSTypeIMessage          = @"SNSTypeIMessage";
GXShareType SNSTypeEmail             = @"SNSTypeEmail";
GXShareType SNSTypeLine              = @"SNSTypeLine";
GXShareType SNSTypeyLinkCopy         = @"SNSTypeyLinkCopy";

@interface GXShareManager () <SNSDropdownViewDelegate, GXShareViewDelegate, GXShareTaskDelegate>

@property (nonatomic, strong) NSMutableDictionary<GXShareType, GxShareTask *> *taskDict;

@property (nonatomic, strong) SNSDropdownView *dropdownView;
@property (nonatomic, strong) GXShareView *shareView;

@end

@implementation GXShareManager

@synthesize cellConfig = _cellConfig;

+ (instancetype)sharedInstance {
    static GXShareManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GXShareManager alloc] init];
    });
    return instance;
}

- (BOOL)willShareCallback:(GXShareType)shareType {
    GxShareTask *task = [self getSNSTaskFromShareType:shareType];
    return [task willCallbackWhenShareStop];
}

- (void)showShareViewWithAssociatedVC:(UIViewController *)controller {
    [self.dropdownView showInView:controller.view withContentView:self.shareView atOrigin:CGPointMake(0, controller.view.bounds.size.height - SNS_SCREENAPPLYHEIGHT(kSocialShareViewheight))];
}

#pragma mark - Private
- (void)shareImage:(UIImage *)image caption:(NSString *)caption description:(NSString *)description model:(GXShareCellModel *)shareModel andAssociatedVC:(UIViewController *)controller {
    self.associatedVC = controller;
    GxShareTask *task = [self getSNSTaskFromShareType:shareModel.shareType];
    if(task) {
        [task associateDelegate:self];
        if(self.videoURL.absoluteString.length) {
            [task shareVideo:self.videoURL
                     caption:caption
                 description:description
                       model:shareModel
                    shareUrl:nil
                   albumName:self.albumName
             andAssociatedVC:controller];
        } else {
            [task shareImage:image
                     caption:caption
                 description:description
                       model:shareModel
                    shareUrl:nil
                   albumName:self.albumName
             andAssociatedVC:controller];
        }
    }
}

- (GxShareTask *)getSNSTaskFromShareType:(GXShareType)shareType {
    GxShareTask *task = [self.taskDict objectForKey:shareType];
    if(!task) {
        if([shareType isEqualToString:SNSTypeFacebook]) {
            task = [[GXShareFacebookTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeInstagram]) {
            task = [[GXShareInstagramTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeTwitter]) {
            task = [[GXShareTwitterTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeMessenger]) {
            task = [[GXShareMessengerTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeWhatsApp]) {
            task = [[GXShareWhatsAppTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeIMessage]) {
            task = [[GXShareIMessqgeTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeEmail]) {
            task = [[GXShareEmailTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeLine]) {
            task = [[GXShareLineTask alloc] init];
        } else if ([shareType isEqualToString:SNSTypeyLinkCopy]) {
            task = [[GXShareCopyLinkTask alloc] init];
        }
        
        if(task) {
            [self.taskDict setObject:task forKey:shareType];
        }
    }
    return task;
}

#pragma mark - GXShareViewDelegate
- (void)soicalShareViewDidClose {
    [self.dropdownView hide];
}

- (void)soicalShareViewDidSelectCell:(GXShareCellModel *)cellModel {
    [self.dropdownView hide];
    if(self.associatedVC) {
        [[GXShareManager sharedInstance] shareImage:self.image
                                            caption:self.title
                                        description:self.desc
                                              model:cellModel
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


#pragma mark - GXShareTaskDelegate
- (void)requestShareManagerToShowAlert:(NSString *)title message:(NSString *)message confirmInfo:(NSString *)confirmInfo cancelInfo:(NSString *)cancelInfo delay:(NSUInteger)delayInterval completion:(void (^)(BOOL))block {
    if(self.delegate && [self.delegate respondsToSelector:@selector(shareManagerRequestToShowAlert:message:confirmInfo:cancelInfo:delay:completion:)]) {
        [self.delegate shareManagerRequestToShowAlert:title
                                              message:message
                                          confirmInfo:confirmInfo
                                           cancelInfo:cancelInfo
                                                delay:delayInterval
                                           completion:block];
    } else {
        if(block) {
            block(YES);
        }
    }
}


#pragma mark - Setter
- (void)setCellConfig:(NSArray<NSDictionary *> *)cellConfig {
    _cellConfig = cellConfig;
    self.shareView.cellConfig = cellConfig;
}


#pragma mark - Getter
- (NSMutableDictionary<GXShareType,GxShareTask *> *)taskDict {
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

- (GXShareView *)shareView {
    if(!_shareView) {
        _shareView = [[GXShareView alloc] initWithFrame:CGRectMake(0, 0, SNS_SCREEN_WIDTH, SNS_SCREENAPPLYHEIGHT(kSocialShareViewheight))];
        _shareView.delegate = self;
        _shareView.cellConfig = self.cellConfig;
    }
    return _shareView;
}

- (NSArray<NSDictionary *> *)cellConfig {
    if(!_cellConfig) {
        _cellConfig = [GXShareParameters getSharePlatformConfig];
    }
    return _cellConfig;
}


@end
