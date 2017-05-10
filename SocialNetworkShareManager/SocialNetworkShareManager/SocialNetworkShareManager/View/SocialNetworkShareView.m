//
//  SocialNetworkShareView.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareView.h"

@interface SocialNetworkShareView ()



@end

@implementation SocialNetworkShareView

- (instancetype)init {
    if(self = [super init]) {
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

#pragma mark - Public
- (void)configureViews {
    self.backgroundColor = [UIColor whiteColor];
}

@end
