//
//  ErrorManager.m
//  tranb
//
//  Created by VictorChou on 13-3-14.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import "ErrorManager.h"
#import "SysTools.h"
//#import "tranbAppDelegate.h"
#import "SysInfo.h"
#import "NSObject+JSON.h"
@implementation ErrorManager
+(void)NetWorkError;
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络异常", @"") message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", @"") otherButtonTitles:nil, nil];
    [alert show];
}

+(BOOL)isErrorWithJson:(NSDictionary*)JSON;
{
    if((!JSON)
       ||(![JSON isKindOfClass:[NSDictionary class]])
       ||(![JSON objectForKey:@"Result"]))
        return NO;
    
    if (![[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]) {
        return NO;
    }
    NSInteger messageCode=[[SysTools NumberObj:[[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]] intValue];
    if (messageCode==2) {
        return NO;
    }
    else
    {
//        NSError *error=[SysInfo getErrorDescriptionViaErrorCode:messageCode];
////        if (error&&error.code!=1090008) {
//        if (messageCode == 1080100) {
//            [[tranbAppDelegate sysDirector] showMemberAlertWithString:NSLocalizedString(@"成为高级会员,发布多个商品", @"") cancelButton:nil];
//        }
//        else if (error) {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:error.domain
//                                                          message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", @"") otherButtonTitles:nil, nil];
//            [alert show];
//           
//        }
//        if(messageCode == 1100003 || messageCode==1100005)
//            return YES;//公司邮箱已经验证过
//        
        return YES;
    }
}
+(NSString*)getErrorDescription:(NSDictionary*)JSON;
{
    if((!JSON)
       ||(![JSON isKindOfClass:[NSDictionary class]])
       ||(![JSON objectForKey:@"Result"]))
        return NSLocalizedString(@"未知错误", @"");
    
    if (![[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]) {
        return NSLocalizedString(@"未知错误", @"");
    }
    NSInteger messageCode=[[SysTools NumberObj:[[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]] intValue];
    if (messageCode==2) {
        return NSLocalizedString(@"未知错误", @"");
    }
    else
    {
        NSError *error=[SysInfo getErrorDescriptionViaErrorCode:messageCode];
        if (error) {
            return error.domain;
        }
        return NSLocalizedString(@"未知错误", @"");
    }
}
+(BOOL)isErrorWithJsonWithoutAlert:(NSDictionary*)JSON;
{
    if (![[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]) {
        return NO;
    }
    NSInteger messageCode=[[SysTools NumberObj:[[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]] intValue];
    if (messageCode==2) {
        return NO;
    }
    else
    {
        NSError *error=[SysInfo getErrorDescriptionViaErrorCode:messageCode];
        if (error) {
            
        }
        return YES;
    }
}

+ (BOOL)isErrorWithJson:(NSDictionary*)JSON errorCode:(void(^)(NSInteger errorCode))block
{
    NSNumber *resultCode = [[[JSON objectForKey:@"Result"] objectForKey:@"ResCode"] numberValue4Json];
    if([resultCode integerValue]>0){
        block([resultCode integerValue]);
        return  YES;
    }
    
    if (![[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]) {
        return NO;
    }
    NSInteger messageCode=[[SysTools NumberObj:[[JSON objectForKey:@"Result"] objectForKey:@"messageCode"]] intValue];
    if (messageCode==2) {
        block(messageCode);
        return NO;
    }
    else
    {
        block(messageCode);
        return YES;
    }
}


//生成一个未定义的错误
+(NSError*)makeUndefinedError;
{
    return [NSError errorWithDomain:DOMAIN_ERROR_MANAGER code:ERR_UNDEFINED userInfo:nil];
}

//生成一个SNS重复分享的错误；
+(NSError*)makeRepeatSnsContentError:(NSString*)errorMsg;
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMsg forKey:@"message"];
    NSError *error = [NSError errorWithDomain:DOMAIN_ERROR_MANAGER code:ERR_REPEAT_SNS_CONTENT userInfo:userInfo];
    return error;
}

//只用于使用ErrorManager生成的Error;
+(NSString*)GetErrorMessage:(NSError*)error;
{
    if(error && error.userInfo){
        NSString *message = [SysTools StringObj:[error.userInfo objectForKey:@"message"]];
        if([message isEqualToString:@""]){
            message = [SysTools StringObj:[error localizedDescription]];
        }
        return message;
    }else
        return @"";
}


+ (BOOL)isErrorWithJsonForTipsLevelMode:(NSDictionary*)JSON
                                  blokc:(void(^)(NSInteger errorCode,NSString *errorMsg))block
{
    if(![JSON isKindOfClass:[NSDictionary class]]){
        block(ERR_UNDEFINED,@"数据格式不正确");
        return YES;
    }
    id msgObj = [JSON objectForKey:@"Message"];
    if(!DICT_IS_NIL(msgObj)){
        NSString *level = StringObj([msgObj objectForKey:@"Level"]);
        NSString *Tips = StringObj([msgObj objectForKey:@"Tips"]);
        if(level && [[level lowercaseString] isEqualToString:@"error"]){
            block(ERR_NETWORK,Tips);
            return YES;
        }
    }else if(!STR_IS_NIL(msgObj)){
        NSString *result = StringObj(msgObj);
        if([result isEqualToString:@"SUCCESS"]){
            block(ERR_SUCCESS,nil);
            return NO;
        }
    }
    block(ERR_SUCCESS,nil);
    return NO;
    
}

#pragma mark - @since 1.70

/**
 这里仅检查的业务逻辑的错误；
 */
+ (void)errorCheck:(NSDictionary*)JSON
      successBlock:(void(^)())successBlock
       failedBlock:(void(^)(NSInteger errCode,NSString *errMsg))failedBlock {
    
    if (JSON) {
        NSNumber *codeNum = [[JSON objectForKey:@"Result"] objectForKey:@"code"];
        if(!codeNum){
            codeNum = [[JSON objectForKey:@"Result"] objectForKey:@"messageCode"];
        }
        if (codeNum) {
            NSInteger errCode = [codeNum integerValue];
            if(errCode == ERR_SUCCESS) {
                if(successBlock){
                    successBlock();
                }
            } else {
                //尝试从json中获取errorMessage
                NSString *errorMsg = [[JSON objectForKey:@"Result"] objectForKey:@"message"];
                if(!errorMsg){
                    errorMsg = [ErrorManager errorMessage:errCode];
                }
                if(failedBlock){
                    failedBlock(errCode,errorMsg);
                }
            }
        } else {
            NSAssert(0, @"服务器返回了不规范的响应结果！");
            if(failedBlock){
                failedBlock(ERR_UNDEFINED,[ErrorManager errorMessage:ERR_UNDEFINED]);
            }
        }
    }else{
        if(failedBlock){
            failedBlock(ERR_UNDEFINED,[ErrorManager errorMessage:ERR_UNDEFINED]);
        }
    }
    
}

+ (NSString *)errorMessage:(NSInteger)errorCode {
    switch (errorCode) {
        case ERR_UNDEFINED:
            return @"为定义错误";
            
        default:
            break;
    }
    return @"";
}

@end
