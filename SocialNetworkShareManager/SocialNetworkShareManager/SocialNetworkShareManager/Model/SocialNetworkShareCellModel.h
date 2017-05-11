//
//  SocialNetworkShareCellModel.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialNetworkShareManager.h"

@interface SocialNetworkShareCellModel : NSObject

@property (nonatomic, strong, readonly) SocialNetworkShareType shareType;
@property (nonatomic, strong, readonly) NSString *imageName;
@property (nonatomic, strong, readonly) NSString *desc;
@property (nonatomic, strong, readonly) NSString *requestTitle;
@property (nonatomic, strong, readonly) NSString *requestDesc;
@property (nonatomic, strong, readonly) NSString *confirmStr;
@property (nonatomic, strong, readonly) NSString *cancelStr;
@property (nonatomic, assign, readonly) NSUInteger delayInterval;

- (instancetype)initWitnDict:(NSDictionary *)dict;

@end
