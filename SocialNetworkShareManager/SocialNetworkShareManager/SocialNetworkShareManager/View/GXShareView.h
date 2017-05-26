//
//  GXShareView.h
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXShareCellModel;

@protocol GXShareViewDelegate <NSObject>

- (void)soicalShareViewDidClose;
- (void)soicalShareViewDidSelectCell:(GXShareCellModel *)cellModel;

@end

@interface GXShareView : UIView

@property (nonatomic, weak) id<GXShareViewDelegate> delegate;
@property (nonatomic, strong) NSArray<NSDictionary *> *cellConfig;

@end
