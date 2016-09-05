//
//  IndustryWebsiteNewsListViewController.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryWebsiteNewsListViewController.h"
#import "MainNewsTableViewCell.h"
#import "SysTools.h"
#import "Masonry.h"
#import "BNAPI.h"
#import "AppDelegate.h"
#import "MJRefresh.h"

#define kCellIdentifyMainNewsCell @"MainNewsTableViewCell"
#define PageSize 20

@interface IndustryWebsiteNewsListViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSInteger currentPageIndex;
    MainNewsTableViewCell *cellRef;
}

@property (nonatomic, strong) NSNumber *currentIndustryId;
@property (nonatomic, strong) NSNumber *currentWebsiteId;
@property (nonatomic, strong) UITableView *uTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;

@end

@implementation IndustryWebsiteNewsListViewController

- (instancetype)initWithIndustryId:(NSNumber *)industryId websiteId:(NSNumber *)websiteId
{
    self = [super init];
    if (self) {
        _currentIndustryId = industryId;
        _currentWebsiteId = websiteId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_UI_BG;
    
    [self.view addSubview:self.uTableView];
    
    currentPageIndex = 0;
    
    [self.uTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.uTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.uTableView.mj_header beginRefreshing];
    
    self.uTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

#pragma mark - 初始化
- (UITableView *) uTableView {
    
    if (!_uTableView) {
        _uTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _uTableView.dataSource = self;
        _uTableView.delegate = self;
        _uTableView.backgroundColor = COLOR_UI_BG;
        _uTableView.tableFooterView = [UIView new];
        [_uTableView registerNib:[UINib nibWithNibName:@"MainNewsTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifyMainNewsCell];
        
    }
    return _uTableView;
}

- (NSMutableArray *)newsListArray {
    
    if (!_newsListArray) {
        _newsListArray = [NSMutableArray new];
    }
    return _newsListArray;
}

#pragma mark - 网络
- (void)refresh {
    [self loadDataFromServer:1];
}

- (void)loadMore {
    [self loadDataFromServer:currentPageIndex+1];
}

- (void) loadDataFromServer:(NSInteger) targetPageIndex {

    __weak typeof (self) weakSelf = self;
    
    [BNAPI news_loadNewsBySqtIndustryWithPn:@(targetPageIndex) ps:@(PageSize) inid:self.currentIndustryId webSitId:self.currentWebsiteId Block:^(BaseCmd *model, NSError *error) {
        
    }];
}

- (void)reloadTableView {
    [self.uTableView.mj_header endRefreshing];
    [self.uTableView.mj_footer endRefreshing];
    [self.uTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.newsListArray){
        return self.newsListArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifyMainNewsCell forIndexPath:indexPath];
    
    cell.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 105;
    
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];
    
    [cell configureNewsListCellWithNewsListUnit:unit];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!cellRef){
        cellRef = [SysTools createViewFromXib:@"MainNewsTableViewCell"];
    }
    cellRef.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 105 - 8;
    
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];
    
    [cellRef configureNewsListCellWithNewsListUnit:unit];
    
    cellRef.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cellRef.bounds));
    CGFloat height = [cellRef.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // 要为cell的分割线加上额外的1pt高度。因为分隔线是被加在cell底边和contentView底边之间的。
    height += 1.0f;
    return height;
}

- (NSString *)title {
    return @"新闻列表";
}
@end