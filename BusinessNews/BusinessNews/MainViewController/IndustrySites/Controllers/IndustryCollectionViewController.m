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
#import "BNAPI.h"
#import "AppDelegate.h"
#import "IndustryWebsiteNewsListRootViewController.h"
#import "SysTools.h"

@interface IndustryCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *websiteArray;
@property (nonatomic, strong) IndustryCmd *industryCmd;
@property (nonatomic, strong) NSString *industryName;
@end

@implementation IndustryCollectionViewController

- (instancetype)initWithIndustryCmd:(IndustryCmd *)industryCmd industryName:(NSString *)name
{
    self = [super init];
    if (self) {
        _industryCmd = industryCmd;
        _industryName = name;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:COLOR_THEME];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    
    self.websiteArray = self.industryCmd.websits;
}

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 2.0f;
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.itemSize = CGSizeMake(FS(106, 124, 137), FS(106, 124, 137));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64 - 90) collectionViewLayout:(UICollectionViewFlowLayout *)flowLayout];
        
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
}

- (NSArray *)websiteArray {

    if (!_websiteArray) {
        _websiteArray = [NSArray new];
    }
    return _websiteArray;
}

- (void)reloadCollectionView {
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.websiteArray){
        return self.websiteArray.count;
    }else{
        return 0;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    IndustryWebsiteCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"IndustryWebsiteCollectionViewCell" forIndexPath:indexPath];
    
    WebsitesUnit *unit = [self.websiteArray objectAtIndex:indexPath.row];
    
    [cell configureCellWithIndustryCmd:unit];
    
    return cell;
    
}

// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WebsitesUnit *unit = [self.websiteArray objectAtIndex:indexPath.row];
    
    IndustryWebsiteNewsListRootViewController *list = [[IndustryWebsiteNewsListRootViewController alloc] initWithWebsiteArray:self.websiteArray industryName:self.industryName selectIndex:indexPath.row];
    
    [self pushViewController:list animated:YES];
    
    
    //统计
    [BNAPI sys_pushTrackEventWithType:@"click_industry_websit" name:@"行业站点各网站的点击" value:nil rmtInId:[NSNumber numberWithInteger:self.industryCmd.industryCode.integerValue] websitid:unit.websiteId imei:nil bannerId:nil Block:^(BaseCmd *model, NSError *error) {
        //do nothing
    }];
}

#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(FS(106, 124, 137), FS(106, 124, 137));
}


@end
