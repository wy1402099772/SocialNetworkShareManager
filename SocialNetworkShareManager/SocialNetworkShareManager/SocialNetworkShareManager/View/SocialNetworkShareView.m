//
//  SocialNetworkShareView.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareView.h"
#import "SocialNetworkShareCollectionViewCell.h"
#import "Masonry.h"
#import "SocialNetworkShareParameters.h"
#import "SocialNetworkShareCellModel.h"

static NSString *SocialNetworkShareCollectionViewCellIdentifier = @"SocialNetworkShareCollectionViewCellIdentifier";

@interface SocialNetworkShareView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<SocialNetworkShareCellModel *> *cellModelArray;
@property (nonatomic, strong) UIButton *closeButton;

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
    
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.mas_equalTo(SNS_SCREENAPPLYHEIGHT(40));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SNS_SCREENAPPLYHEIGHT(20));
        make.height.mas_equalTo(SNS_SCREENAPPLYHEIGHT(29));
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(SNS_SCREENAPPLYHEIGHT(103));
    }];
}


#pragma mark - Action
- (void)didSelectCloseAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(soicalShareViewDidClose)]) {
        [self.delegate soicalShareViewDidClose];
    }
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < self.cellModelArray.count) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(soicalShareViewDidSelectCell:)]) {
            [self.delegate soicalShareViewDidSelectCell:self.cellModelArray[indexPath.row]];
        }
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SocialNetworkShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SocialNetworkShareCollectionViewCellIdentifier forIndexPath:indexPath];
    if(indexPath.row < self.cellModelArray.count) {
        [cell loadData:self.cellModelArray[indexPath.row]];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SNS_SCREENAPPLYHEIGHT(70), SNS_SCREENAPPLYHEIGHT(103));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, SNS_SCREENAPPLYHEIGHT(7), 0, SNS_SCREENAPPLYHEIGHT(7));
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *follLayout = [[UICollectionViewFlowLayout alloc] init];
        [follLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:follLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[SocialNetworkShareCollectionViewCell class] forCellWithReuseIdentifier:SocialNetworkShareCollectionViewCellIdentifier];
        
    }
    return _collectionView;
}

- (NSArray<SocialNetworkShareCellModel *> *)cellModelArray {
    if(!_cellModelArray) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[SocialNetworkShareParameters getSharePlatformConfig].count];
        for (NSDictionary *dict in [SocialNetworkShareParameters getSharePlatformConfig]) {
            SocialNetworkShareCellModel *cellModel = [[SocialNetworkShareCellModel alloc] initWitnDict:dict];
            if(cellModel) {
                [array addObject:cellModel];
            }
        }
        _cellModelArray = [array copy];
    }
    return _cellModelArray;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = SNS_UIColorFromRGB(11, 149, 241);
        _titleLabel.font = [SocialNetworkShareParameters getFontHeavy:SNS_SCREENAPPLYHEIGHT(24)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Share with Friends";
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if(!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton addTarget:self action:@selector(didSelectCloseAction) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setTitle:@"ex" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _closeButton;
}

@end
