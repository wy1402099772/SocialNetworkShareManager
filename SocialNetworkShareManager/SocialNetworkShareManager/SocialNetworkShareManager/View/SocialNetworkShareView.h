//
//  SocialNetworkShareView.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialNetworkShareCellModel;

@protocol SocialNetworkShareViewDelegate <NSObject>

- (void)soicalShareViewDidClose;
- (void)soicalShareViewDidSelectCell:(SocialNetworkShareCellModel *)cellModel;

@end

@interface SocialNetworkShareView : UIView

@property (nonatomic, weak) id<SocialNetworkShareViewDelegate> delegate;
@property (nonatomic, strong) NSArray<NSDictionary *> *cellConfig;

@end
