//
//  GXShareCollectionViewCell.h
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXShareCellModel;

@interface GXShareCollectionViewCell : UICollectionViewCell

- (void)loadData:(GXShareCellModel *)shareModel;

@end
