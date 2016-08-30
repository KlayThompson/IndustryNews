//
//  ErrorManager.h
//  tranb
//
//  Created by VictorChou on 13-3-14.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DOMAIN_ERROR_MANAGER @"ErrorManager"

@interface ErrorManager : NSObject

+(void)NetWorkError;
+(BOOL)isErrorWithJson:(NSDictionary*)JSON;
+(NSString*)getErrorDescription:(NSDictionary*)JSON;
+(BOOL)isErrorWithJsonWithoutAlert:(NSDictionary*)JSON;
+ (BOOL)isErrorWithJson:(NSDictionary*)JSON errorCode:(void(^)(NSInteger errorCode))block;

//生成一个未定义的错误
+(NSError*)makeUndefinedError;

//生成一个SNS重复分享的错误；
+(NSError*)makeRepeatSnsContentError:(NSString*)errorMsg;

//只用于使用ErrorManager生成的Error;
+(NSString*)GetErrorMessage:(NSError*)error;

//检查服务器端返回的Tips,Level类型的错误；
+ (BOOL)isErrorWithJsonForTipsLevelMode:(NSDictionary*)JSON
                                  blokc:(void(^)(NSInteger errorCode,NSString *errorMsg))block;

#pragma mark - @since 1.70

/**
 这里仅检查的业务逻辑的错误；
 */
+ (void)errorCheck:(NSDictionary*)JSON
      successBlock:(void(^)())successBlock
       failedBlock:(void(^)(NSInteger errCode,NSString *errMsg))failedBlock;

/**
 根据errcode返回对应的错误提示；
 */
+ (NSString *)errorMessage:(NSInteger)errorCode;

@end
