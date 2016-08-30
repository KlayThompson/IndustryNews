//
//  LocalPushManager.m
//  tranb
//
//  Created by 耿功发 on 15/8/12.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import "LocalPushManager.h"
#import <UIKit/UIKit.h>


@implementation LocalPushManager

+ (LocalPushManager *)sharedInstance {
    static LocalPushManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LocalPushManager alloc] init];
    });
    return _sharedInstance;
}

// Push本地通知
// 【3天】亲爱的老板，今天没有做生意啊？
- (BOOL)isLocalPush3DaysOpenAPP {
    return [USER boolForKey:@"3DaysOpenApp"] ? : NO;
}

- (void)setLocalPush3DaysOpenApp {
    [USER setBool:YES forKey:@"3DaysOpenApp"];
    [USER synchronize];
}

// 【7天】500位行业人脉精选5位，只推荐给你
- (BOOL)isLocalPush7DaysOpenAPP {
    return [USER boolForKey:@"7DaysOpenApp"] ? : NO;
}

- (void)setLocalPush7DaysOpenApp {
    [USER setBool:YES forKey:@"7DaysOpenApp"];
    [USER synchronize];
}

// 【3天】听说人脉打折，怎么办到的？（需要在完善信息下标注灰色字体“完善后加好友通过率将提升83%哦”）
- (BOOL)isLocalPush3DaysPersonalInfo {
    return [USER boolForKey:@"3DaysPersonalInfo"] ? : NO;
}




#pragma mark - 
/**
 生成本地推送的通知；
 用户安装未登录：每天提示一次登录；
 用户登录后，3天内未打开app，提示一次；
 用户登录后，3天内未完善个人资料，提示一次；
 用户登录后，7天内未打开APP，提示一次；
 除登录外，只要在3天或7天内打开过一次APP，以后则不再弹出提示；防止打扰用户
 */
- (void)creatLocalNotificationSchedules {
    //取消所有本地推送
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    if(DEBUG_VERSION){
        [LocalPushManager clearAllSchedules];
    }
    
//    NSDate *now=[NSDate new];
    
//    if([SysInfo GetSignInState]){
//        
//        
//    }else{
//        
//    }
}

+ (void)clearAllSchedules {
    [USER removeObjectForKey:@"3DaysOpenApp"];
    [USER removeObjectForKey:@"7DaysOpenApp"];
    [USER removeObjectForKey:@"3DaysPersonalInfo"];
    [USER synchronize];
}

@end
