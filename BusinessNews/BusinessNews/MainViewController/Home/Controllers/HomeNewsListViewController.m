//
//  HomeNewsListViewController.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "HomeNewsListViewController.h"
#import "SecondMainNewsCell.h"
#import "SysTools.h"
#import "Masonry.h"
#import "BNAPI.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "NewsListModel.h"
#import "NewsDetailViewController.h"

#import "UIImageView+WebCache.h"
#import "UIView+Size.h"
#import "NewsADModel.h"
#import "SVWebViewController.h"
#import "ZYBannerView.h"

#define kCellIdentifyMainNewsCell @"SecondMainNewsCell"
#define PageSize 20
#define Height_ADBanner FS(85.33f, 100, 110.4)

@interface HomeNewsListViewController()<UITableViewDelegate,UITableViewDataSource,ZYBannerViewDataSource,ZYBannerViewDelegate> {
    
    SecondMainNewsCell *cellRef;
    NSInteger currentPageIndex;
    NSMutableArray *photoArray;
}

@property (nonatomic, strong) UITableView *uTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) NSString *currentIndustryId;
@property (nonatomic, strong) NSMutableArray *currentAdArray;

@end

@implementation HomeNewsListViewController

- (instancetype)initWithIndustryId:(NSString *)industryId
{
    self = [super init];
    if (self) {
        _currentIndustryId = industryId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:COLOR_THEME];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_UI_BG;
    
    [self.view addSubview:self.uTableView];
    
    currentPageIndex = 0;
    
    self.uTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataFormServer)];
    [self.uTableView.mj_header beginRefreshing];
    
    self.uTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFormServer)];
    self.uTableView.mj_footer.hidden = YES;

}

#pragma mark - 初始化
- (UITableView *) uTableView {
    
    if (!_uTableView) {
        _uTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64 - 90) style:UITableViewStyleGrouped];
        _uTableView.dataSource = self;
        _uTableView.delegate = self;
        _uTableView.backgroundColor = COLOR_UI_BG;
        _uTableView.tableFooterView = [UIView new];
        [_uTableView registerNib:[UINib nibWithNibName:@"SecondMainNewsCell" bundle:nil] forCellReuseIdentifier:kCellIdentifyMainNewsCell];
        
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
    
    //第一页获取广告推荐新闻banner
    [self loadBannerViewDataFromServer];
}

- (void)loadMoreDataFormServer {
    [self loadDataFromServer:currentPageIndex+1];
}

- (void) loadDataFromServer:(NSInteger) targetPageIndex {
    
    
    __weak typeof (self) weakSelf = self;
    
    [BNAPI news_loadNewsByRmtIndustryWithPn:@(targetPageIndex)
                                         ps:@(PageSize)
                                    rmtInId:self.currentIndustryId
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
                                                          if (!ARRAY_IS_NIL(weakSelf.newsListArray)) {
                                                              [weakSelf.uTableView.mj_header endRefreshing];
                                                          }
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
                                                          weakSelf.uTableView.mj_footer.hidden = NO;
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
    [self.uTableView reloadData];
    
    [self.uTableView.mj_footer endRefreshing];
    
}

- (void)loadBannerViewDataFromServer {

    __weak typeof (self) weakSelf = self;
    [BNAPI news_loadTopNewsAticlesWithRmtInId:self.currentIndustryId Block:^(BaseCmd *model, NSError *error) {
       
        if (error) {
            
        } else {
            [model errorCheckSuccess:^{
                
                if ([model isKindOfClass:[NewsADModel class]]) {
                    NewsADModel *adModel = (NewsADModel *)model;
                    weakSelf.currentAdArray = adModel.newsADList;
                    [weakSelf reloadTableView];
                }
                
            } failed:^(NSInteger errCode) {
                [[AppDelegate sysDirector] showToastInBottom:[model errorMsg]];
            }];
        }
    }];
}

#pragma mark - 跳转到新闻详情
- (void)jumpToNewsDetailPageWithNewsListUnit:(NewsListUnit *)unit {
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.newsListArray){
        return self.newsListArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondMainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifyMainNewsCell forIndexPath:indexPath];
    
    cell.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 14;
    
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];
    
    [cell configureNewsListCellWithNewsListUnit:unit];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (self.currentAdArray.count > 0) {
        
        NSMutableArray *imgArray = [NSMutableArray new];

        for (int i = 0; i < self.currentAdArray.count; i++) {
            NewsADCmd *cmd = [self.currentAdArray objectAtIndex:i];
            [imgArray addObject:cmd.pic];
        }
        photoArray = [NSMutableArray new];
        for(int i=0;i<imgArray.count;i++){
            [photoArray addObject:[imgArray objectAtIndex:i]?:@""];
        }
        
        ZYBannerView *bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, Height_ADBanner)];
        bannerView.dataSource = self;
        bannerView.delegate = self;
        bannerView.autoScroll = YES;
        bannerView.shouldLoop = YES;
        if (photoArray && photoArray.count == 1) {
            bannerView.pageControl.hidden = YES;
        } else {
            bannerView.pageControl.hidden = NO;
        }
        
        return bannerView;
    } else {
        return nil;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];

    [self jumpToNewsDetailPageWithNewsListUnit:unit];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!cellRef){
        cellRef = [SysTools createViewFromXib:@"SecondMainNewsCell"];
    }
    NewsListUnit *unit = [self.newsListArray objectAtIndex:indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.currentAdArray.count > 0) {
        return Height_ADBanner;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}

#pragma mark - ZYBannerViewDataSource
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {

    return photoArray.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {

    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:photoArray[index]] placeholderImage:[UIImage imageNamed:@"cycle_scroll_image_default"]];
    return imageView;
}

- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {

    NewsADCmd *adItemClicked = [self.currentAdArray objectAtIndex:index];
    
    if (adItemClicked.type.integerValue == 0) {
        //新闻
        NewsListUnit *unit = [[NewsListUnit alloc] init];
        unit.newsId = adItemClicked.newsId;
        unit.websitId = adItemClicked.webSitId;
        unit.industryId = adItemClicked.industryId;
        unit.imagePic = adItemClicked.pic;
        [self jumpToNewsDetailPageWithNewsListUnit:unit];
    } else {
        //广告  直接跳转链接
        SVWebViewController *adViewController = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:StringObj(adItemClicked.targetUrl)]];
        [self pushViewController:adViewController animated:YES];
    }
    
    //统计
    [BNAPI sys_pushTrackEventWithType:@"click_banner" name:nil value:nil rmtInId:adItemClicked.rmtInid websitid:adItemClicked.webSitId imei:nil bannerId:adItemClicked.bannerId Block:^(BaseCmd *model, NSError *error) {
        //do nothing
    }];
}

@end
