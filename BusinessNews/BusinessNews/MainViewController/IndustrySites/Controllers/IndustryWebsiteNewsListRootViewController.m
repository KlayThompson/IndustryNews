//
//  IndustryWebsiteNewsListRootViewController.m
//  BusinessNews
//
//  Created by liufeng on 16/9/12.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryWebsiteNewsListRootViewController.h"
#import "NinaPagerView.h"
#import "Masonry.h"
#import "UIView+Size.h"
#import "SKTagView.h"
#import "IndustryCmd.h"
#import "SysTools.h"
#import "IndustryWebsiteNewsListViewController.h"

@interface IndustryWebsiteNewsListRootViewController ()<NinaPagerViewDelegate> {
    UIScrollView *scroll;
    NSMutableArray *titleArray;
    NSInteger currentIndex;
    NSArray *currentWebsiteArray;
    NSInteger currentSelectIndex;//用户点击第几个行业站点
}

@property (nonatomic, strong) UIButton *showMoreButton;
@property (nonatomic, strong) NinaPagerView *slideView;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSString *industryName;

@end

@implementation IndustryWebsiteNewsListRootViewController

- (instancetype)initWithWebsiteArray:(NSArray *)array industryName:(NSString *)name selectIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        currentWebsiteArray = array;
        _industryName = name;
        currentSelectIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;

    self.view.backgroundColor = COLOR_UI_BG;
    
    currentIndex = 0;
    
    [self setUpSubViews];
}

- (void)setUpSubViews {
    
    titleArray = [NSMutableArray new];
    NSMutableArray *vcsArray = [NSMutableArray new];
    
    for (int index = 0; index < currentWebsiteArray.count; index++) {
        WebsitesUnit *unit = currentWebsiteArray[index];

        [titleArray addObject:StringObj(unit.websiteName)];
        IndustryWebsiteNewsListViewController *view = [[IndustryWebsiteNewsListViewController alloc] initWithIndustryId:NumberObj(unit.industryId) websiteId:NumberObj(unit.websiteId)];
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
    self.slideView.pushEnabled = YES;
    self.slideView.delegate = self;
    
    [self.slideView selectPageIndex:currentSelectIndex];
    
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTagViewButtonClick)];
    [imageView addGestureRecognizer:tap];
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
//        view.regularWidth = FS(60, 73, 83);
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
        if (idx == currentIndex) {
            tag.textColor = kColorWithHex(0xffffff);
            tag.bgColor = kColorWithHex(0xd41e12);
        } else {
            tag.textColor = kColorWithHex(0x5f5a5a);
            tag.bgColor = kColorWithHex(0xececec);
        }
        tag.cornerRadius = 3;
        tag.fontSize = FS(10, 12, 14);
        tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        
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
}

#pragma mark - NinaPagerViewDelegate
- (BOOL)deallocVCsIfUnnecessary {
    return YES;
}

- (void)ninaCurrentPageIndex:(NSString *)currentPage {
    
    currentIndex = currentPage.integerValue;
    
    if (self.showMoreButton.selected) {
        [self setupTagView];
    }
}

- (NSString *)title {

    return self.industryName;
}
@end
