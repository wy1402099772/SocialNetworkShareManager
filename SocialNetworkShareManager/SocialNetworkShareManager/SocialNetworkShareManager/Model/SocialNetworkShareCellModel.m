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
    }
    return self;
}

@end
