//
//  IndustryCollectionViewController.m
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryCollectionViewController.h"
#import "Masonry.h"
#import "IndustryWebsiteCollectionViewCell.h"

@interface IndustryCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IndustryCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSubViews];
}

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 2.0f;
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.itemSize = CGSizeMake(FS(106, 124, 137), FS(106, 124, 137));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:(UICollectionViewFlowLayout *)flowLayout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.autoresizesSubviews = YES;
        //    self.autoresizesSubviews = YES;
        _collectionView.scrollEnabled = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsZero;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"IndustryWebsiteCollectionViewCell" bundle:nil]
              forCellWithReuseIdentifier:@"IndustryWebsiteCollectionViewCell"];
    }
    return _collectionView;
}

- (void)initSubViews {

    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    IndustryWebsiteCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"IndustryWebsiteCollectionViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
    
}

// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(FS(106, 124, 137), FS(106, 124, 137));
}


@end
