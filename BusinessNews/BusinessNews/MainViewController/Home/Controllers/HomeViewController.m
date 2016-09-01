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

@interface HomeViewController ()

@property (nonatomic, strong) SelectIndustryTagView *tagView;
@property (nonatomic, strong) UIButton *showMoreButton;
@property (nonatomic, strong) NinaPagerView *slideView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Actions
- (void)showTagViewButtonClick {

    BOOL select = self.showMoreButton.selected;
    
    // 根据状态做事情
    if (select) {
        
        [UIView animateWithDuration:0.35 animations:^{
            self.showMoreButton.transform = CGAffineTransformIdentity;
        }];
    } else {
     
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
