//
//  BaseCmd.h
//  vdangkou
//
//  Created by Smalltask on 15/3/24.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

// 用户相关以100000开头，产品相关以200000开头，订单相关以300000开头，店铺相关以400000开头
typedef NS_ENUM(NSInteger, ERROR) {
    
    ERRORCODE_SUCCESS = 0,
    
    ERRORCODE_ForbiddenUser = -2,
    
    ERRORCODE_SMS_SEND_LIMIT = 333,         // 333表示发送次数超过3次
    
    ERRORCODE_USER_NOTEXIST = 100001,       // 用户不存在，请先发送验证码
    ERRORCODE_ACTIVECODEWRONG = 100002,     // 验证码不正确
    ERRORCODE_ACTIVECODEWORNG3TIMES = 100003,// 验证码入错误次数大于3次
    ERRORCODE_USEREXIST_BINDFAILED = 100004, // 用户已存在，无法绑定
    ERRORCODE_USERPROFILENOTEXIST = 100005,  // 用户profile不存在
    
    ERRORCODE_SYS_CLASS_TRANSFORM = -1000,
    ERRORCODE_SYS_TOKEN_INVALID   = -1001,   //七牛上传图片的Token不正确
    ERRORCODE_SYS_FILE_NOT_EXSIT  = -1002,    //文件不存在
    ERRORCODE_SYS_BAD_DATA_FOMMAT = -1003,     //错误的数据格式
    ERRORCODE_SYS_NETWORK_ERROR   = -1004,      //网络错误
    ERRORCODE_SYS_APP_NEED_UPDATE = -1005,      //APP需要升级
};

@interface BaseCmd : MTLModel<MTLJSONSerializing>

//data 是用来封装具体业务消息的容器
@property(nonatomic,strong) id msgData;
//错误编号；0表示正确。其他表示各类错误
@property(nonatomic,strong) NSNumber *code;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *latestVersion;//当前最新的版本号，例如："1.20"
@property(nonatomic,strong) NSString *versionInfo;//版本更新信息；

//检查错误，执行通用的处理逻辑
- (void)errorCheckSuccess:(void(^)())success failed:(void(^)(NSInteger errCode))failed;

- (NSString *)errorMsg;

/**
 返回一个Error对象
 */
- (NSError *)errorObj;

@end
