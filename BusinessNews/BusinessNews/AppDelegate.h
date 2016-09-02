//
//  AppDelegate.h
//  BusinessNews
//
//  Created by KlayThompson on 16/8/27.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysDirector.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *sysTabBarController;
@property (nonatomic,strong) SysDirector *sysDirector;

+ (SysDirector*)sysDirector;

@end

