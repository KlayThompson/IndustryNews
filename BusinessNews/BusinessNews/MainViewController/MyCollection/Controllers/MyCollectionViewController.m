//
//  MyAccountViewController.m
//  HuaRongDao
//
//  Created by duhui on 16/8/11.
//  Copyright © 2016年 hrdapp. All rights reserved.
//

#import "MyCollectionViewController.h"
//#import "MainNewsTableViewCell.h"
#import "SysTools.h"
#import "Masonry.h"
#import "BNAPI.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "NoDataTipView.h"

#import "NewsListModel.h"
#import "IndustryWebsiteNewsListViewController.h"
#import "NewsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIView+Size.h"
#import "SecondMainNewsCell.h"


#define kCellIdentifyMainNewsCell @"SecondMainNewsCell"


@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    SecondMainNewsCell *cellRef;
}


@property (nonatomic, strong) UITableView *uTableView;
@property (nonatomic, strong) NoDataTipView *noDataView;
@property (nonatomic, strong) NSMutableArray<NewsListUnit*> *currentNewsArray;

@end

@implementation MyCollectionViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:COLOR_THEME];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //将保存的收藏列表copy到当前页面
    self.currentNewsArray = [AppDelegate sysDirector].collectNewsArray;
    [self reloadTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.uTableView.mj_header beginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = COLOR_UI_BG;
    
    [self.view addSubview:self.uTableView];
    
    self.navigationController.navigationBar.translucent = NO;

    [self.uTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //提示没有数据
    [self.uTableView addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.uTableView).insets(UIEdgeInsetsMake(0, FS(38, 48, 58), 0, 0));
    }];
}

#pragma mark - 初始化
- (UITableView *) uTableView {
    
    if (!_uTableView) {
        _uTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _uTableView.dataSource = self;
        _uTableView.delegate = self;
        _uTableView.backgroundColor = COLOR_UI_BG;
        _uTableView.tableFooterView = [UIView new];
        [_uTableView registerNib:[UINib nibWithNibName:@"SecondMainNewsCell" bundle:nil] forCellReuseIdentifier:kCellIdentifyMainNewsCell];
        
    }
    return _uTableView;
}

- (NoDataTipView *)noDataView {

    if (!_noDataView) {
        _noDataView = [SysTools createViewFromXib:@"NoDataTipView"];
        _noDataView.publishButton.hidden = YES;
        _noDataView.tipDetailLabel.hidden = YES;
        _noDataView.imageViewToTopSpaceConstant.constant = FS(150, 200, 220);
        _noDataView.hidden = YES;
    }
    return _noDataView;
}

- (void)reloadTableView {
    if (ARRAY_IS_NIL(self.currentNewsArray)) {
        self.noDataView.hidden = NO;
    } else {
        self.noDataView.hidden = YES;
    }
    [self.uTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.currentNewsArray){
        return self.currentNewsArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondMainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifyMainNewsCell forIndexPath:indexPath];
    
    cell.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 14;
    
    NewsListUnit *unit = [self.currentNewsArray objectAtIndex:indexPath.row];
    
    [cell configureNewsListCellWithNewsListUnit:unit];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewsListUnit *unit = [self.currentNewsArray objectAtIndex:indexPath.row];
    
    __weak typeof (self) weakSelf = self;
    [BNAPI news_loadNewsContentWithNewsId:unit.newsId industryID:unit.industryId websitId:unit.websitId Block:^(BaseCmd *model, NSError *error) {
        
        if (error) {
            [weakSelf makeToastInBottom:error.domain];
            
        } else {
            
            [model errorCheckSuccess:^{
                
                if ([model isKindOfClass:[NewsDetailModel class]]) {
                    
                    NewsDetailModel *detailModel = (NewsDetailModel *)model;
                    
                    NewsDetailViewController *detail = [[NewsDetailViewController alloc] initWithNewsDetailModel:detailModel newsListUnit:unit];
                    
                    [weakSelf pushViewController:detail animated:YES];
                }
                
            } failed:^(NSInteger errCode) {
                [[AppDelegate sysDirector] showToastInBottom:[model errorMsg]];
            }];
        }
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!cellRef){
        cellRef = [SysTools createViewFromXib:@"SecondMainNewsCell"];
    }
    NewsListUnit *unit = [self.currentNewsArray objectAtIndex:indexPath.row];
    
    if (STR_IS_NIL(unit.imagePic)) {
        cellRef.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 14 - 35;
    } else {
        cellRef.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 14 - 120;
    }
    
    [cellRef configureNewsListCellWithNewsListUnit:unit];
    
    cellRef.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cellRef.bounds));
    CGFloat height = [cellRef.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // 要为cell的分割线加上额外的1pt高度。因为分隔线是被加在cell底边和contentView底边之间的。
    height += 1.0f;
    return height;
}

- (NSString *)title {
    return @"我的收藏";
}

@end
