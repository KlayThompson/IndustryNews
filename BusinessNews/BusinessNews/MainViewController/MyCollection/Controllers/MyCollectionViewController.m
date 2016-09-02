//
//  MyAccountViewController.m
//  HuaRongDao
//
//  Created by duhui on 16/8/11.
//  Copyright © 2016年 hrdapp. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MainNewsTableViewCell.h"
#import "SysTools.h"
#import "Masonry.h"
#import "BNAPI.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "NoDataTipView.h"

#define kCellIdentifyMainNewsCell @"MainNewsTableViewCell"


@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    MainNewsTableViewCell *cellRef;
    NSArray *orderMessageArray;
}


@property (nonatomic, strong) UITableView *uTableView;
@property (nonatomic, strong) NoDataTipView *noDataView;

@end

@implementation MyCollectionViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self loadDataFormServer];
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
    
    [self.uTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.uTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFormServer)];
    [self.uTableView.mj_header beginRefreshing];
    
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
        [_uTableView registerNib:[UINib nibWithNibName:@"MainNewsTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifyMainNewsCell];
        
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

#pragma mark - 网络
- (void)loadDataFormServer {

    __weak typeof (self) weakSelf = self;
//    [BNAPI news_loadNewsContentWithNewsId:@(968742) industryID:@(1) websitId:@(8) Block:^(BaseCmd *model, NSError *error) {
//        [weakSelf.uTableView.mj_header endRefreshing];
//        if (error) {
//            [weakSelf makeToastInBottom:TIP_NETWORK_ERROR];
//            SLOG(@"%@",error);
//        } else {
//            NSLog(@"%@",model);
//        }
//    }];
    [BNAPI news_loadNewsByRmtIndustryWithPn:@(1) ps:@(20) rmtInId:@"0617" Block:^(BaseCmd *model, NSError *error) {
        [weakSelf.uTableView.mj_header endRefreshing];

    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if(orderMessageArray){
//        return orderMessageArray.count;
//    }else{
//        return 0;
//    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifyMainNewsCell forIndexPath:indexPath];
    
    cell.newsTitleLabel.preferredMaxLayoutWidth = WIDTH_SCREEN - 105;
    
//    ZBOrderMessageListModel *model = [orderMessageArray objectAtIndex:indexPath.row];
//    
//    [cell configureOrderMessageWithOrderModel:model];
    
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
    
//    ZBOrderMessageListModel *model = [orderMessageArray objectAtIndex:indexPath.row];
//    
//    [cellRef configureOrderMessageWithOrderModel:model];
    
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
