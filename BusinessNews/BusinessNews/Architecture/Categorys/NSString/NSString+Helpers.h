//
//  NSString+Helpers.h
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-3.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECTTITLE_COUNT 20

@interface NSString (Helpers)
//判断是否是电话号码
- (BOOL)checkPhoneNumInput;
//判断是否是email
- (BOOL)isValidateEmail;
//判断是否是手机号
- (BOOL)isValidateMobile;
//判断字符是否是数字
- (BOOL)isNumber;
//判断字符是否是采购数
-(BOOL)isPurchaseNum;

//判断是否是为空或者空字符串
- (BOOL)isNilOrEmpty;
//判断是否是空字符串
- (BOOL)isEmpty;
//RC4加密
- (NSString*)TORC4:(NSString*)aKey;

//将NSInteger转成Str
NSString* stringWithNSInteger(NSInteger number);
//将Int转成Str
NSString* stringWithInteger(int number);
//将double转成Str
NSString* stringWithDouble(double number);
//将浮点转成Str
NSString* stringWithFloat(float number);

//得到本机现在用的语言
+ (NSString*)stringWithPreferredLanguage;
//得到当前的日期
+ (NSString*) stringWithCurDate;
//得到当前的时间轴
+ (NSString*) gstringWithCurLongTime;

//获取截取String并去除首尾空格
- (NSString *)getSelectTitle:(NSRange)range;

//删除首尾空格
- (NSString *)trim;
//去除空格
- (NSString *)removeSpaces;

/*移除首尾空白、制表符、回车符等*/
- (NSString *)removeSpacesAndNewLine;

//MD5
- (NSString *) md5 ;

//sha1
- (NSString*)sha1;

//用来将手机号码加密 例如13000000000加密成130****0000
- (NSString *)mobilePhoneNumberEncrypt;

//base64解密
//- (NSData *)decodeStringBase64;

////把字符串转换成对象

// 判断两个字符串是否相等 忽略大小写
- (BOOL)isEqualToCaseInsensitiveString:(NSString *)aString;

// 判断是不是包涵该字符串
- (BOOL)customContainString:(NSString *)aString;

/** 12345567  --->  12,345,567
 */
- (NSString *)RMBString;

- (NSString *)RMBString_MoneyFommat;

/**
 在RMBString_MoneyFommat的基础上，实现下面的约束：
 1.00 --> 1
 */
- (NSString *)RMBString_MoneyFommat_trailOmit;

/**
 替换非英文逗号的标点符号
 */
- (NSString *)repalcePunctuationMarkWithCommaMark;
@end
