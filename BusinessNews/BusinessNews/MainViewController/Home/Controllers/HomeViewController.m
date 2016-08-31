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
    
    NinaPagerView *test = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleStateNormal WithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    //    test.frame = CGRectMake(0, 0, WIDTH_SCREEN, 44);
    [self.view addSubview:test];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"covered_bg"]];
    imageView.frame = CGRectMake(WIDTH_SCREEN - 60, 0, 60, 34);
    [test addSubview:imageView];
    
    //添加一个button展开tag
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH_SCREEN - 30, 13, 14, 16);
    [button addTarget:self action:@selector(showTagViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"drop-down"] forState:UIControlStateNormal];
    [test addSubview:button];
}

#pragma mark - Actions
- (void)showTagViewButtonClick {
    
}

- (NSString *)title {
    return @"头条";
}

@end
