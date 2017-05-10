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

- (instancetype)initWitnDict:(NSDictionary *)dict;

@end
