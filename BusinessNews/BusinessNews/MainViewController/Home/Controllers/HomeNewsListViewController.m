//
//  HomeNewsListViewController.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "HomeNewsListViewController.h"
#import "MainNewsTableViewCell.h"
#import "SysTools.h"
#import "Masonry.h"
#import "BNAPI.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "NewsListModel.h"
#import "NewsDetailViewController.h"

#define kCellIdentifyMainNewsCell @"MainNewsTableViewCell"
#define PageSize 20

@interface HomeNewsListViewController()<UITableViewDelegate,UITableViewDataSource> {
    
    MainNewsTableViewCell *cellRef;
    NSInteger currentPageIndex;
}

@property (nonatomic, strong) UITableView *uTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) NSNumber *currentIndustryId;

@end

@implementation HomeNewsListViewController

- (instancetype)initWithIndustryId:(NSNumber *)industryId
{
    self = [super init];
    if (self) {
        _currentIndustryId = industryId;
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
    
    self.uTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataFormServer)];
    [self.uTableView.mj_header beginRefreshing];
    
    self.uTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFormServer)];
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
- (void)refreshDataFormServer {
    [self loadDataFromServer:1];
}

- (void)loadMoreDataFormServer {
    [self loadDataFromServer:currentPageIndex+1];
}

- (void) loadDataFromServer:(NSInteger) targetPageIndex {
    
    
    __weak typeof (self) weakSelf = self;
    
    [BNAPI news_loadNewsByRmtIndustryWithPn:@(targetPageIndex)
                                         ps:@(PageSize)
                                    rmtInId:[NSString stringWithFormat:@"%@",self.currentIndustryId]
                                      Block:^(BaseCmd *model, NSError *error) {
                                          
                                          if (error) {
                                              [[AppDelegate sysDirector] showToastInBottom:error.domain];
                                          } else {
                                              [model errorCheckSuccess:^{
                                                  
                                                  if ([model isKindOfClass:[NewsListModel class]]) {
                                                      
                                                      NewsListModel *unit = (NewsListModel *)model;
                                                      
                                                      if (targetPageIndex == 1) {
                                                          
                                                          [weakSelf.newsListArray removeAllObjects];
                                                          weakSelf.newsListArray = [unit.newsList mutableCopy];
                                                          currentPageIndex = 1;
                                                      }else{
                                                          if(unit.newsList){
                                                              
                                                              [weakSelf.newsListArray addObjectsFromArray:unit.newsList];
                                                              
                                                              currentPageIndex =  targetPageIndex;
                                                          }else{
                                                              //认为server端没有返回数据
                                                          }
                                                      }
                                                      
                                                      //控制上拉更多
                                                      if (unit.newsList && unit.newsList.count < PageSize && unit.newsList.count >0 ) {
                                                          
                                                          weakSelf.uTableView.mj_footer = nil;
                                                          
                                                      } else if(unit.newsList.count == PageSize) {
                                                          
                                                          weakSelf.uTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFormServer)];
                                                          
                                                      } else if (unit.newsList.count == 0){
                                                          
                                                          weakSelf.uTableView.mj_footer = nil;
                                                          
                                                      } else {
                                                          
                                                          NSAssert(0, @"程序错误，检查代码！");
                                                          
                                                      }
                                                      [weakSelf reloadTableView];
                                                      
                                                  }else{
                                                      NSAssert(0, @"程序错误，检查代码！");
                                                  }
                                                  
                                              } failed:^(NSInteger errCode) {
                                                  [[AppDelegate sysDirector] showToastInBottom:[model errorMsg]];
                                              }];
                                          }
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
    
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];

    __weak typeof (self) weakSelf = self;
    [BNAPI news_loadNewsContentWithNewsId:unit.newsId industryID:unit.industryId websitId:unit.websitId Block:^(BaseCmd *model, NSError *error) {
        
        if (error) {
            [weakSelf makeToastInBottom:error.domain];
            
        } else {
            
            [model errorCheckSuccess:^{
                
                if ([model isKindOfClass:[NewsDetailModel class]]) {
                    
                    NewsDetailModel *detailModel = (NewsDetailModel *)model;
                    
                    NewsDetailViewController *detail = [[NewsDetailViewController alloc] initWithNewsDetailModel:detailModel webSiteName:unit.webSitName];
                    
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
@end
