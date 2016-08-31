//
//  BaseCmd.m
//  vdangkou
//
//  Created by Smalltask on 15/3/24.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import "BaseCmd.h"
#import "AppDelegate.h"

@implementation BaseCmd

-(id)init{
    self = [super init];
    if(self){
        _message = @"";
        _code = 0;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

//检查错误，执行通用的处理逻辑
- (void)errorCheckSuccess:(void(^)())success failed:(void(^)(NSInteger errCode))failed{
    
    NSInteger errCode = [self.code integerValue];
    
    if(errCode == ERRORCODE_SUCCESS){
        /** 通信消息级别的升级目前思考不足，先不实现
        if(self.latestVersion && ![self.latestVersion isEqualToString:@""]){
            //版本要升级
            failed(ERRORCODE_SYS_APP_NEED_UPDATE);
        }else{
            success();
        }
         */
        success();
    }
//    else if (errCode == ERRORCODE_ForbiddenUser) {
//        kTipAlert(@"%@", self.errorMsg);
//        failed(errCode);
//    }
    
    else{
        //执行通用的处理逻辑
        if(errCode==-1 && [[self.errorMsg lowercaseString] rangeOfString:@"token"].location != NSNotFound){
            //token过期 暂不处理
            /*
            if ([MyAccountManager sharedManager].currentUser) {
                AppDelegate *app = APP;
                [app onAppTokenError];
            } else {
                failed([self.code integerValue]);
            }
             */
            failed(errCode);
            
        }else{
            failed(errCode);
        }
    }
}

- (NSString *)errorMsg{
    NSString *msg = [self.message TRIM];
    if(msg.length>50)
        msg = [msg substringToIndex:50];
//    return [NSString stringWithFormat:@"%@[%ld]",msg,(long)[self.code integerValue]];
    
    return [NSString stringWithFormat:@"%@",msg];
}

/**
 返回一个Error对象
 */
- (NSError *)errorObj{
    NSError *error = [NSError errorWithDomain:[self errorMsg] code:[self.code integerValue] userInfo:nil];
    return error;
}

@end
