//
//  HJBNavigationController.m
//  HJBASCnew
//
//  Created by luanxu on 16/3/3.
//  Copyright © 2016年 com.huarongdao. All rights reserved.
//

#import "MainNavigationController.h"
@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }

    return self;
}
#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
#pragma mark - CustomDelegate

#pragma mark - eventResponse
#pragma mark - publicMethod
#pragma mark - private methods
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //恢复手势后退
    self.interactivePopGestureRecognizer.delegate = nil;
    [super pushViewController:viewController animated:animated];
}

//修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
  
        return UIStatusBarStyleLightContent;
}
#pragma mark - gettersAndSetters

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
