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
#import "MyCollectionViewController.h"
#import "SelectIndustryTagView.h"
#import "UIView+Size.h"
#import "SKTagView.h"

@interface HomeViewController ()

@property (nonatomic, strong) SelectIndustryTagView *tagBgView;
@property (nonatomic, strong) UIButton *showMoreButton;
@property (nonatomic, strong) NinaPagerView *slideView;
@property (nonatomic, strong) SKTagView *tagView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_UI_BG;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUpSubViews];
    
}


- (void)setUpSubViews {

    NSArray *titleArray = @[
                            @"全部",
                            @"服装服饰",
                            @"微商",
                            @"汽车配件",
                            @"新浪新闻",
                            @"电子设备",
                            @"互联网",
                            @"金融投资",
                            @"美发造型"
                            ];
    NSMutableArray *vcsArray = [NSMutableArray new];
    
    for (int index = 0; index < titleArray.count; index ++) {
        
        MyCollectionViewController *view = [[MyCollectionViewController alloc] init];
        
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
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"covered_bg"]];
    imageView.frame = CGRectMake(WIDTH_SCREEN - 60, 0, 60, 34);
    [self.slideView addSubview:imageView];
    
    //添加一个button展开tag
    self.showMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showMoreButton.frame = CGRectMake(WIDTH_SCREEN - 30, 13, 14, 16);
    [self.showMoreButton addTarget:self action:@selector(showTagViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.button setImage:[UIImage imageNamed:@"drop-down"] forState:UIControlStateNormal];
    [self.showMoreButton setBackgroundImage:[UIImage imageNamed:@"drop-down"] forState:UIControlStateNormal];
    [self.slideView addSubview:self.showMoreButton];
}

- (void)buildIndustryTagView {

    
    
    [self setupTagView];
}

- (void)setupTagView
{
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = kColorWithRGBA(255, 255, 255, 0.95);
        view.padding = UIEdgeInsetsMake(10, 25, 10, 25);
        view.interitemSpacing = 8;
        view.lineSpacing = 10;
        view.regularHeight = 30;
        view.didTapTagAtIndex = ^(NSUInteger index){
            NSLog(@"Tap");
        };
        view;
    });
    [self.view addSubview:self.tagView];
    UIView *superView = self.view;
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.leading.equalTo(superView);
        make.trailing.equalTo(superView);
    }];
    
    
    //Add Tags
    [@[@"微商", @"服装面料", @"金融投资", @"互联网金融", @"农副产品", @"房地产投资", @"汽车制造"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = kColorWithHex(0x5f5a5a);
        tag.bgColor = kColorWithHex(0xececec);
        tag.cornerRadius = 3;
        tag.fontSize = 15;
        tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        
        [self.tagView addTag:tag];
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.mas_equalTo(39);
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
    } else {
        [self buildIndustryTagView];

        [UIView animateWithDuration:0.35 animations:^{
            self.showMoreButton.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    }
    self.showMoreButton.selected = !self.showMoreButton.selected;
}

- (NSString *)title {
    return @"头条";
}

@end
