//
//  ActivityViewController.m
//  HuaRongDao
//
//  Created by duhui on 16/8/11.
//  Copyright © 2016年 hrdapp. All rights reserved.
//

#import "HomeViewController.h"
#import "NinaPagerView.h"
#import "Masonry.h"
#import "HomeNewsListViewController.h"
#import "UIView+Size.h"
#import "SKTagView.h"
#import "AppDelegate.h"
#import "SysTools.h"
#import "Notification_Definition.h"
#import "BNAPI.h"

#define SaveIndustryCode @"IndustryTree"

@interface HomeViewController ()<NinaPagerViewDelegate> {

    NSMutableArray *titleArray;
    UIScrollView *scroll;
}

@property (nonatomic, strong) UIButton *showMoreButton;
@property (nonatomic, strong) NinaPagerView *slideView;
@property (nonatomic, strong) SKTagView *tagView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_UI_BG;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpSubViews) name:NOTIFICATION_UpdateIndustryCode object:nil];
    
    [self setUpSubViews];
}


- (void)setUpSubViews {

    NSMutableArray *currentIndstryArray = [NSMutableArray new];
    titleArray = [NSMutableArray new];
    NSMutableArray *vcsArray = [NSMutableArray new];
    
    //首页行业需要插入一个@"推荐"
    currentIndstryArray = [AppDelegate sysDirector].currentIndstryTree;
    IndustryCmd *commend = [[IndustryCmd alloc] init];
    commend.industryCode = @"0000";
    commend.industryName = @"推荐";
    if (!ARRAY_IS_NIL(currentIndstryArray)) {
        [currentIndstryArray insertObject:commend atIndex:0];
    }
    
    for (int index = 0; index < currentIndstryArray.count; index++) {
        IndustryCmd *cmd = [currentIndstryArray objectAtIndex:index];
        [titleArray addObject:StringObj(cmd.industryName)];
        
        HomeNewsListViewController *view = [[HomeNewsListViewController alloc] initWithIndustryId:cmd.industryCode];
        [vcsArray addObject:view];
    }
    
    NSArray *colorArray = @[
                            kColorWithHex(0xd41e12), /**< Title SelectColor  **/
                            kColorWithHex(0x7b7b7b), /**< Title UnselectColor **/
                            [UIColor redColor], /**< Underline or SlideBlock Color   **/
                            [UIColor whiteColor], /**< TopTab Background Color   **/
                            ];
    
    self.slideView = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleStateNormal WithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    [self.view addSubview:self.slideView];
    self.slideView.delegate = self;
    self.slideView.pushEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"covered_bg"]];
    imageView.frame = CGRectMake(WIDTH_SCREEN - 60, 0, 60, 38);
    [self.slideView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    //添加一个button展开tag
    self.showMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showMoreButton.frame = CGRectMake(WIDTH_SCREEN - 30, 15, 12, 12);
    [self.showMoreButton addTarget:self action:@selector(showTagViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.showMoreButton setBackgroundImage:[UIImage imageNamed:@"drop-down"] forState:UIControlStateNormal];
    [self.slideView addSubview:self.showMoreButton];
    self.showMoreButton.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTagViewButtonClick)];
    [imageView addGestureRecognizer:tap];
    
    for (int index = 0; index < [AppDelegate sysDirector].currentIndstryTree.count; index++) {
        IndustryCmd *cmd = [AppDelegate sysDirector].currentIndstryTree[index];
        if ([cmd.industryName isEqualToString:@"推荐"]) {
            [[AppDelegate sysDirector].currentIndstryTree removeObject:cmd];
        } else {
        }
    }
}

- (void)setupTagView {
    __weak typeof (self) weakSelf = self;
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor clearColor];
        view.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        view.interitemSpacing = 20;
        view.lineSpacing = 15;
        view.regularHeight = 30;
        view.regularWidth = FS(60, 73, 83);
        view.didTapTagAtIndex = ^(NSUInteger index){
            [weakSelf tagButtonClickWithIndex:index];
        };
        view;
    });
    
    //添加一个baseScrollView
    if (!scroll) {
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 41, WIDTH_SCREEN, HEIGHT_SCREEN)];
        if (HEIGHT_SCREEN > 480) {
            scroll.contentSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN*FS(1.2, 0, 0));
        } else {
            scroll.contentSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN*FS(1.3, 0, 0));
        }
        scroll.bounces = YES;
        scroll.alwaysBounceVertical = YES;
        [self.view addSubview:scroll];
        scroll.backgroundColor = kColorWithRGBA(255, 255, 255, 0.9);
    }
    [scroll addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scroll.mas_top);
        make.left.equalTo(scroll.mas_left);
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.height.mas_equalTo(HEIGHT_SCREEN).priorityLow();
    }];
    
    //Add Tags
    [titleArray enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = kColorWithHex(0x5f5a5a);
        tag.bgColor = kColorWithHex(0xececec);
        tag.cornerRadius = 3;
        tag.fontSize = FS(10, 12, 14);
        tag.padding = UIEdgeInsetsZero;
        
        [self.tagView addTag:tag];
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.mas_equalTo(39).priorityHigh();
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - Actions
- (void)showTagViewButtonClick {
    BOOL select = self.showMoreButton.selected;
    
    // 根据状态做事情
    if (select) {
        [self.tagView removeFromSuperview];
        [UIView animateWithDuration:0.35 animations:^{
            self.showMoreButton.transform = CGAffineTransformIdentity;
        }];
        scroll.hidden = YES;
    } else {
        [self setupTagView];
        [UIView animateWithDuration:0.35 animations:^{
            self.showMoreButton.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
        scroll.hidden = NO;
    }
    self.showMoreButton.selected = !self.showMoreButton.selected;
}

- (void)tagButtonClickWithIndex:(NSInteger)index {
    
    [self.slideView selectPageIndex:index];
    [self showTagViewButtonClick];
    
    IndustryCmd *cmd = [[AppDelegate sysDirector].currentIndstryTree objectAtIndex:index];
    cmd.selectCount++;
    //每次点击都要更新本地的行业分类数据
    NSData *tempSubmitOrderCmd = [NSKeyedArchiver archivedDataWithRootObject:[AppDelegate sysDirector].currentIndstryTree];
    [[NSUserDefaults standardUserDefaults] setObject:tempSubmitOrderCmd forKey:SaveIndustryCode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - NinaPagerViewDelegate
- (BOOL)deallocVCsIfUnnecessary {
    return YES;
}

- (void)ninaCurrentPageIndex:(NSString *)currentPage {

    IndustryCmd *cmd = [[AppDelegate sysDirector].currentIndstryTree objectAtIndex:currentPage.integerValue];
    //统计
    [BNAPI sys_pushTrackEventWithType:@"click_index_industry_tab" name:@"首页所有行业tab点击" value:nil rmtInId:[NSNumber numberWithInteger:cmd.industryCode.integerValue] websitid:nil imei:nil bannerId:nil Block:^(BaseCmd *model, NSError *error) {
        //do nothing
    }];
}

- (NSString *)title {
    return @"商业头条";
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
