//
//  AppDelegate.m
//  BusinessNews
//
//  Created by KlayThompson on 16/8/27.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "AppDelegate.h"
#import "CRNavigationController.h"
#import "HomeViewController.h"
#import "MyCollectionViewController.h"
#import "IndustrySitesViewController.h"
#import "ColorDefinition.h"

//------SNS
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//------

@interface AppDelegate ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];// 初始化DDLog日志输出，在这里，我们仅仅希望在xCode控制台输出
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [self setUp];
    [self registerSNSForAPP];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

- (void)setUp {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.sysDirector = [SysDirector GetInstance];
    
    [self InitializationTabbar];
    
    self.window.rootViewController = self.sysTabBarController; 
}

- (void)InitializationTabbar {

    // 头条
    HomeViewController *home = [[HomeViewController alloc] init];
    
    CRNavigationController *homeViewController = [[CRNavigationController alloc] initWithRootViewController:home];
    [homeViewController setDelegate:self];
    
    UITabBarItem *homeTabbar = [[UITabBarItem alloc] initWithTitle:@"头条"
                                                             image:nil
                                                     selectedImage:nil];
    [homeTabbar setImage:[[UIImage imageNamed:@"icon_home_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeTabbar setSelectedImage:[[UIImage imageNamed:@"icon_home_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    homeViewController.tabBarItem = homeTabbar;
    
    // 行业站点
    IndustrySitesViewController *industry = [[IndustrySitesViewController alloc] init];
    
    CRNavigationController *industryViewController = [[CRNavigationController alloc] initWithRootViewController:industry];
    [industryViewController setDelegate:self];
    
    UITabBarItem *industryTabbar = [[UITabBarItem alloc] initWithTitle:@"行业站点"
                                                                 image:nil
                                                         selectedImage:nil];
    [industryTabbar setImage:[[UIImage imageNamed:@"icon_site_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [industryTabbar setSelectedImage:[[UIImage imageNamed:@"icon_Site_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    industryViewController.tabBarItem = industryTabbar;
    
    
    // 我的收藏
    MyCollectionViewController *collection = [[MyCollectionViewController alloc] init];
    
    CRNavigationController *collectionViewController = [[CRNavigationController alloc] initWithRootViewController:collection];
    [collectionViewController setDelegate:self];
    
    UITabBarItem *collectionTabbar = [[UITabBarItem alloc] initWithTitle:@"我的收藏"
                                                             image:nil
                                                     selectedImage:nil];
    [collectionTabbar setImage:[[UIImage imageNamed:@"icon_collection_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [collectionTabbar setSelectedImage:[[UIImage imageNamed:@"icon_Collection _a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    collectionViewController.tabBarItem = collectionTabbar;
    
    
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    tabbarController.viewControllers = @[homeViewController,
                                         industryViewController,
                                         collectionViewController];
    
    tabbarController.tabBar.translucent = NO;
    //设置tint颜色
    tabbarController.tabBar.tintColor = COLOR_THEME;
    
    self.sysTabBarController = tabbarController;
    self.sysTabBarController.delegate = self;
    
}

+ (SysDirector*)sysDirector {
    
    AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    return app.sysDirector;
}

#pragma mark - SNS
- (void)registerSNSForAPP {

    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

@end
