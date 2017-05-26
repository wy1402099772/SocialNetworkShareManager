//
//  GXShareCollectionViewCell.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareCollectionViewCell.h"
#import "GXShareCellModel.h"
#import "GXShareParameters.h"
#import "Masonry.h"

@interface GXShareCollectionViewCell ()

@property (nonatomic, strong) GXShareCellModel *shareModel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GXShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)loadData:(GXShareCellModel *)shareModel {
    _shareModel = shareModel;
    
    self.imageView.image = [UIImage imageWithContentsOfFile:[SNS_RESOUCE_BUNDLE pathForResource:shareModel.imageName ofType:@"png"]];
    self.titleLabel.text = shareModel.desc;
}


#pragma mark - Private
- (void)configureViews {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SNS_SCREENAPPLYHEIGHT(18));
        make.centerX.equalTo(self.contentView);
        make.height.width.mas_equalTo(SNS_SCREENAPPLYHEIGHT(44));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(SNS_SCREENAPPLYHEIGHT(8));
        make.height.mas_equalTo(SNS_SCREENAPPLYHEIGHT(30));
    }];
}


#pragma mark - Getter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = SNS_UIColorFromRGB(33, 33, 33);
        _titleLabel.font = [GXShareParameters getFontHeavy:SNS_SCREENAPPLYHEIGHT(12)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = SNS_SCREENAPPLYHEIGHT(22);
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
