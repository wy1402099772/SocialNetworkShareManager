//
//  GXShareView.m
//  GXShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareView.h"
#import "GXShareCollectionViewCell.h"
#import "Masonry.h"
#import "GXShareParameters.h"
#import "GXShareCellModel.h"

static NSString *GXShareCollectionViewCellIdentifier = @"GXShareCollectionViewCellIdentifier";

@interface GXShareView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<GXShareCellModel *> *cellModelArray;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation GXShareView

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
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95];
    
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.mas_equalTo(SNS_SCREENAPPLYHEIGHT(40));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SNS_SCREENAPPLYHEIGHT(18));
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
    GXShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXShareCollectionViewCellIdentifier forIndexPath:indexPath];
    if(indexPath.row < self.cellModelArray.count) {
        [cell loadData:self.cellModelArray[indexPath.row]];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SNS_SCREENAPPLYHEIGHT(66), SNS_SCREENAPPLYHEIGHT(103));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, SNS_SCREENAPPLYHEIGHT(7), 0, SNS_SCREENAPPLYHEIGHT(7));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark - Setter
- (void)setCellConfig:(NSArray<NSDictionary *> *)cellConfig {
    _cellConfig = cellConfig;
    _cellModelArray = nil;
    [self.collectionView reloadData];
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
        
        [_collectionView registerClass:[GXShareCollectionViewCell class] forCellWithReuseIdentifier:GXShareCollectionViewCellIdentifier];
        
    }
    return _collectionView;
}

- (NSArray<GXShareCellModel *> *)cellModelArray {
    if(!_cellModelArray) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.cellConfig.count];
        for (NSDictionary *dict in self.cellConfig) {
            GXShareCellModel *cellModel = [[GXShareCellModel alloc] initWitnDict:dict];
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
        _titleLabel.font = [GXShareParameters getFontHeavy:SNS_SCREENAPPLYHEIGHT(24)];
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
        [_closeButton setImage:[[UIImage imageWithContentsOfFile:[SNS_RESOUCE_BUNDLE pathForResource:@"image_close@3x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [_closeButton.imageView setTintColor:SNS_UIColorFromRGB(216, 216, 216)];
    }
    return _closeButton;
}

@end
