//
//  ActivityViewController.m
//  HuaRongDao
//
//  Created by duhui on 16/8/11.
//  Copyright © 2016年 hrdapp. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = COLOR_UI_BG;
    
    self.title = @"商业头条";
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title {
    return @"头条";
}

@end
