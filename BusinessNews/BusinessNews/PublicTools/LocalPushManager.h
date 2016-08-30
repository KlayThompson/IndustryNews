//
//  LocalPushManager.h
//  tranb
//
//  Created by 耿功发 on 15/8/12.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocalPushManager : NSObject

+ (LocalPushManager *)sharedInstance;

// Push本地通知
// 【3天】亲爱的老板，今天没有做生意啊？
- (BOOL)isLocalPush3DaysOpenAPP;
- (void)setLocalPush3DaysOpenApp;

// 【7天】500位行业人脉精选5位，只推荐给你
- (BOOL)isLocalPush7DaysOpenAPP;
- (void)setLocalPush7DaysOpenApp;

// 【3天】听说人脉打折，怎么办到的？（需要在完善信息下标注灰色字体“完善后加好友通过率将提升83%哦”）
- (BOOL)isLocalPush3DaysPersonalInfo;


#pragma mark -
/**
 生成本地推送的通知；
 用户安装未登录：每天提示一次登录；
 用户登录后，3天内未打开app，提示一次；
 用户登录后，3天内未完善个人资料，提示一次；
 用户登录后，7天内为打开APP，提示一次；
 除登录外，只要在3天或7天内打开过一次APP，以后则不再弹出提示；防止打扰用户
 */
- (void)creatLocalNotificationSchedules;
+ (void)clearAllSchedules;

@end
