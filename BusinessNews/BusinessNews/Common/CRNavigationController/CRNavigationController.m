//
//  CRNavigationController.m
//  CRNavigationControllerExample
//
//  Created by Corey Roberts on 9/24/13.
//  Copyright (c) 2013 SpacePyro Inc. All rights reserved.
//

#import "CRNavigationController.h"
#import "CRNavigationBar.h"
#import "Definition.h"
#import "SysTools.h"
#import "ColorDefinition.h"
//#import "CustomNavigationBar.h"

#define tag_customNavitagion_RMT    1
#define tag_customNavitagion_SQT    2

@interface CRNavigationController ()



@end

@implementation CRNavigationController

- (id)init {
    if (IOS7_SDK_AVAILABLE) {
        self = [super initWithNavigationBarClass:[CRNavigationBar class] toolbarClass:nil];
    }
    else
    {
        self=[super init];
    }
    if(self) {
        [self loadCustomer];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (IOS7_SDK_AVAILABLE) {
        self = [super initWithNavigationBarClass:[CRNavigationBar class] toolbarClass:nil];
    }
    else
    {
        self=[super initWithRootViewController:rootViewController];
    }

    if(self) {
        self.viewControllers = @[rootViewController];
        [self loadCustomer];
    }
    
    return self;
}
/*
    自定义的一些东西
 */
- (void)loadCustomer{
    if (IOS7_SDK_AVAILABLE) {
        [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19],NSFontAttributeName, nil]];
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:40./255. green:80./255. blue:140./255. alpha:1]];
        [self.navigationBar setBarTintColor:COLOR_THEME];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    {
        /**
         @since 1.723
         尝试解决 Can't add self as subview 的bug
         https://www.douban.com/note/536194761/
         */
        
        if(_currentAnimating) {
            return;
        } else if(animated) {
            _currentAnimating = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
    if (IOS7_SDK_AVAILABLE) {
        return;
    }
    if (viewController.navigationController.navigationBar.tag!=tag_customNavitagion_SQT) {
        NSInteger index = [self.viewControllers indexOfObject:viewController];
        if (index != 0 && !viewController.navigationItem.hidesBackButton) {
//            UIViewController *previousVc = [self.viewControllers objectAtIndex:index - 1];
//            viewController.navigationItem.leftBarButtonItem = [CustomNavigationBar leftBarButton4iOS6BackbuttonWithTitle:previousVc.title target:self action:@selector(goback)];
        }

    }
}

- (UIViewController *) popViewControllerAnimated:(BOOL)animated {
    {
        /**
         @since 1.723
         尝试解决 Can't add self as subview 的bug
         https://www.douban.com/note/536194761/
         */
        if(_currentAnimating) {
            return nil;
        } else if(animated) {
            _currentAnimating = YES;
        }
    }
    
    return [super popViewControllerAnimated:animated];
}

- (void)goback{
    [self popViewControllerAnimated:YES];
}


///下面的两个方法是放在tranbAppDelegate.m中来实现了
///**
// @since 1.723
// 尝试解决 Can't add self as subview 的bug
// https://www.douban.com/note/536194761/
// */
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    _currentAnimating = NO;
//}


///**
// @since 1.723 
// 尝试解决 Can't add self as subview 的bug
// https://www.douban.com/note/536194761/
// */
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    [[self transitionCoordinator] notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        if([context isCancelled]) {
//            UIViewController *fromViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
//            [self navigationController:navigationController willShowViewController:fromViewController animated:animated];
//            
//            if([self respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
//                NSTimeInterval animationCompletion = [context transitionDuration] * [context percentComplete];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (uint64_t)animationCompletion * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                    [self navigationController:navigationController didShowViewController:fromViewController animated:animated];
//                });
//            }
//        }
//    }];
//}


@end
