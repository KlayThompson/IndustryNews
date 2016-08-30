//
//  NSString+Phone.m
//  tranb
//
//  Created by Daniel_Li on 14/10/22.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL)checkStringLegal{

    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"illegalString" ofType:@"txt"];
    NSString *stringViaText = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSString *regex =  [NSString stringWithFormat:@"%@",self];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd]  %@", regex];
    return ![pred evaluateWithObject:stringViaText];
    
}

- (BOOL)chechChineseName{
    
    if (self == nil || self.length == 0) {
        return NO;
    }
    NSString *regex =  @"^[\u4e00-\u9fa5]{2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

//1.722用户名只能为2到4个汉字
- (NSString *)transChineseNameIsValidateToMessage{

    if (self == nil || self.length == 0) {
        return nil;
    }
    
    if (self && self.length > 4) {
        return @"中文名不能超过4位汉字";
    }
    
    if (![self chechChineseName]) {
        return  @"中文名必须是中文，至少2个汉字";
    }
    
    if (![self checkStringLegal]) {
       return @"中文名包含敏感词汇，请重新输入";
    }
    
    return nil;
}


- (BOOL)checkPassword{
    if (self == nil || self.length == 0) {
        return NO;
    }
    NSString *regex = @"\\b\\w{6,32}\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)checkIsEmail{
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
- (BOOL)checkIsPhoneNum
{
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(177)|(176)|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)checkIsMoney
{
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *regex = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)transToMoney
{
    if ([self rangeOfString:@"."].location != NSNotFound) {
        NSString *regex = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0})?$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:self]) {
            return [self stringByAppendingString:@"00"];
        }
        
        regex = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1})?$";
        pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:self]) {
            return [self stringByAppendingString:@"0"];
        }
    }
    return self;
}
@end
