//
//  SocialNetworkShareCollectionViewCell.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialNetworkShareCellModel;

@interface SocialNetworkShareCollectionViewCell : UICollectionViewCell

- (void)loadData:(SocialNetworkShareCellModel *)shareModel;

@end
