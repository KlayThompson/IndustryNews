//
//  NetTools.h
//  tranb
//
//  Created by  SmallTask on 11-8-24.
//  Copyright 2011年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"


@interface NetTools : NSObject {
    
}

+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding;

+(NSString *)URLDEcoding:(NSString*)encodedString;

+(NSData*) GetBytesFromImage:(UIImage*)_image;

+(NSData*) GetBytesFromImage:(UIImage*)_image jpegQulity:(CGFloat)_jpegQulity;

/** 替换url中与cookie有关的参数
 @SNID,@ACTF,@CU    @CU就是uid->base64
 */
//+ (NSString *)replaceRMTcookiesParams:(NSString *)sourceUrl;

/**
 从urlStr中，提取参数为paramName的内容
 */
+ (NSString *)paramValueByParamName:(NSString *)paramName urlStr:(NSString *)urlStr;


@end
