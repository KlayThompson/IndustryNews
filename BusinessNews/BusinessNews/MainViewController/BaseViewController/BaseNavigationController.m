//
//  BaseNavigationController.m
//  YouPlay
//
//  Created by 小白 on 13-8-21.
//  Copyright (c) 2013年 邱新鹏. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()


@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    
//    [RMTInterFace cancelForTag:self.visibleViewController.tagWithInterFace];
    return [super popViewControllerAnimated:animated];
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{

    return [super popToViewController:viewController animated:animated];
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{

    return [super popToRootViewControllerAnimated:animated];
}

- (void)loadView{

    [super loadView];
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
