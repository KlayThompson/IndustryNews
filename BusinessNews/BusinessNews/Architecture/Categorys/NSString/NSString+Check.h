//
//  NSString+Phone.h
//  tranb
//
//  Created by Daniel_Li on 14/10/22.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
/**
 *  长度少于2个汉字的中文
 */
- (BOOL)chechChineseName;
- (BOOL)checkPassword;
- (BOOL)checkIsEmail;
- (BOOL)checkIsPhoneNum;
- (BOOL)checkIsMoney;
- (NSString *)transToMoney;
/**
 *  检测非法字符 
 */
- (BOOL)checkStringLegal;

- (NSString *)transChineseNameIsValidateToMessage;

@end
