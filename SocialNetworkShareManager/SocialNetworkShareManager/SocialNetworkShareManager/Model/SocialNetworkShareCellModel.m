//
//  SocialNetworkShareCellModel.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareCellModel.h"

@implementation SocialNetworkShareCellModel

- (instancetype)initWitnDict:(NSDictionary *)dict {
    if(self = [super init]) {
        if([dict objectForKey:kSNSTypeKey] && [[dict objectForKey:kSNSTypeKey] isKindOfClass:[NSString class]]) {
            _shareType = [dict objectForKey:kSNSTypeKey];
        }
        if([dict objectForKey:kSNSTitleKey] && [[dict objectForKey:kSNSTitleKey] isKindOfClass:[NSString class]]) {
            _desc = [dict objectForKey:kSNSTitleKey];
        }
        if([dict objectForKey:kSNSImageStrKey] && [[dict objectForKey:kSNSImageStrKey] isKindOfClass:[NSString class]]) {
            _imageName = [dict objectForKey:kSNSImageStrKey];
        }
        if([dict objectForKey:kSNSRequestTitleKey] && [[dict objectForKey:kSNSRequestTitleKey] isKindOfClass:[NSString class]]) {
            _requestTitle = [dict objectForKey:kSNSRequestTitleKey];
        }
        if([dict objectForKey:kSNSRequestDescKey] && [[dict objectForKey:kSNSRequestDescKey] isKindOfClass:[NSString class]]) {
            _requestDesc = [dict objectForKey:kSNSRequestDescKey];
        }
        if([dict objectForKey:kSNSConfirmKey] && [[dict objectForKey:kSNSConfirmKey] isKindOfClass:[NSString class]]) {
            _confirmStr = [dict objectForKey:kSNSConfirmKey];
        }
        if([dict objectForKey:kSNSCancelKey] && [[dict objectForKey:kSNSCancelKey] isKindOfClass:[NSString class]]) {
            _cancelStr = [dict objectForKey:kSNSCancelKey];
        }
        if([dict objectForKey:kSNSDelayKey] && [[dict objectForKey:kSNSDelayKey] isKindOfClass:[NSNumber class]]) {
            _delayInterval = [[dict objectForKey:kSNSDelayKey] unsignedIntegerValue];
        }
        
    }
    return self;
}

@end
