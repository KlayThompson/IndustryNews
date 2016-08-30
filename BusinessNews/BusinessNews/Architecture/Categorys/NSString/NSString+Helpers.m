//
//  NSString+Helpers.m
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-3.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import "NSString+Helpers.h"
#import "CommonCrypto/CommonDigest.h"



@implementation NSString (Helpers)

//判断是否是电话号码
-(BOOL)checkPhoneNumInput{
    NSString *regex =@"(13[0-9]|0[1-9]|0[1-9][0-9]|0[1-9][0-9][0-9]|15[0-9]|18[02356789]|17[0-9])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:self];
}
//判断是否是email
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//判断是否是手机号
-(BOOL)isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//判断字符是否是数字
-(BOOL)isNumber{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}
//判断字符是否是采购数
-(BOOL)isPurchaseNum{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}
//判断是否是为空或者空字符串
-(BOOL)isNilOrEmpty{
    return (self==(NSString *)[NSNull null] || !self || [self isEmpty] );
}

//判断是否是空字符串
-(BOOL)isEmpty{
    return [self isEqualToString:@""];
}

- (NSString*)TORC4:(NSString*)aKey
{
    
    NSMutableArray *iS = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *iK = [[NSMutableArray alloc] initWithCapacity:256];
    
    for (int i= 0; i<256; i++) {
        [iS addObject:[NSNumber numberWithInt:i]];
    }
    
    int j=1;
    
    for (short i=0; i<256; i++) {
        
        UniChar c = [aKey characterAtIndex:i%aKey.length];
        
        [iK addObject:[NSNumber numberWithChar:c]];
    }
    
    j=0;
    
    for (int i=0; i<255; i++) {
        int is = [[iS objectAtIndex:i] intValue];
        UniChar ik = (UniChar)[[iK objectAtIndex:i] charValue];
        
        j = (j + is + ik)%256;
        NSNumber *temp = [iS objectAtIndex:i];
        [iS replaceObjectAtIndex:i withObject:[iS objectAtIndex:j]];
        [iS replaceObjectAtIndex:j withObject:temp];
        
    }
    
    int i=0;
    j=0;
    
    NSString *result = self;
    
    for (short x=0; x<[self length]; x++) {
        i = (i+1)%256;
        
        int is = [[iS objectAtIndex:i] intValue];
        j = (j+is)%256;
        
        int is_i = [[iS objectAtIndex:i] intValue];
        int is_j = [[iS objectAtIndex:j] intValue];
        
        int t = (is_i+is_j) % 256;
        int iY = [[iS objectAtIndex:t] intValue];
        
        UniChar ch = (UniChar)[self characterAtIndex:x];
        UniChar ch_y = ch^iY;
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(x, 1) withString:[NSString stringWithCharacters:&ch_y length:1]];
    }
    iS=nil;
    iK=nil;
    return result;
}

//将NSInteger转成Str
NSString* stringWithNSInteger(NSInteger number){
    
    return [NSString stringWithFormat:@"%ld",(long)number];
}


//将Int转成Str
NSString* stringWithInteger(int number){
    
    return [NSString stringWithFormat:@"%d",number];
}
//将double转成Str
NSString* stringWithDouble(double number){
    return [NSString stringWithFormat:@"%lf",number];
}
NSString* stringWithFloat(float number){
    return [NSString stringWithFormat:@"%f",number];
}



/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)stringWithPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}
/**
 得到当前的日期
 */
+(NSString*) stringWithCurDate
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}

/**
 得到当前的时间轴
 */
+(NSString*) gstringWithCurLongTime
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[curDate timeIntervalSince1970]];
    return timeSp;
}

//获取截取String并去除首尾空格
- (NSString *)getSelectTitle:(NSRange)range {
//    NSString *tempStr=[[self substringWithRange:range] removeWhitespaceAndNewline];
//    NSString *tempStr2=tempStr.length<SELECTTITLE_COUNT?tempStr:[tempStr substringWithRange:NSMakeRange(0, SELECTTITLE_COUNT)];
//    tempStr=nil;
    return @"";
}
//删除首尾空格
- (NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去除空格
- (NSString *)removeSpaces{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/*移除首尾空白、制表符、回车符等*/
- (NSString *)removeSpacesAndNewLine {
    NSString *tmpStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return tmpStr;
}

//MD5
- (NSString *) md5{

    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//

    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X", result[i]];
    }
    return ret;
}

//sha1
- (NSString*)sha1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

//用来将手机号码加密 例如13000000000加密成130****0000
- (NSString *)mobilePhoneNumberEncrypt {
    if ([self isValidateMobile]) {
        NSMutableString *mStr = [NSMutableString stringWithString:self];
        [mStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return [NSString stringWithString:mStr];
    }else{
    }
    
    return @"";
}
//base64解密
//- (NSData *)decodeStringBase64{
//    return [GTMBase64 decodeString:self];
//}

// 判断两个字符串是否相等 忽略大小写
- (BOOL)isEqualToCaseInsensitiveString:(NSString *)aString{

    if (self) {
        NSComparisonResult result = [self compare:aString options:NSCaseInsensitiveSearch];
        switch (result) {
            case NSOrderedSame:
            {
                return YES;
            }
                break;
                
            default:{
                return NO;
            }
                break;
        }
    }
    return NO;
}

// 判断是不是包涵该字符串
- (BOOL)customContainString:(NSString *)aString{

    if (aString) {
        return ([self rangeOfString:aString].location != NSNotFound);
    }
    return NO;
}

/** 
 12345567  --->  12,345,567
 12345678.12345678 --> 12,345,678.12,345,678
 */
- (NSString *)RMBString{
    
    if (self) {
        NSArray *array = [self componentsSeparatedByString:@"."];
        if (array && array.count > 0) {
            __block NSMutableArray *stringArray = [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(NSString  *objString, NSUInteger idx, BOOL *stop) {
                NSString *st = [objString dealWithFloatRMBString];
                if (st) {
                      [stringArray addObject:st];
                }
            }];
            return [stringArray componentsJoinedByString:@"."];
        } else {
            return nil;
        }
    }
    
    return nil;
}

- (NSString *)RMBString:(NSString*)str{
    
    if (self) {
        NSArray *array = [str componentsSeparatedByString:@"."];
        if (array && array.count > 0) {
            __block NSMutableArray *stringArray = [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(NSString  *objString, NSUInteger idx, BOOL *stop) {
                NSString *st = [objString dealWithFloatRMBString];
                if (st) {
                    [stringArray addObject:st];
                }
            }];
            return [stringArray componentsJoinedByString:@"."];
        } else {
            return nil;
        }
    }
    
    return nil;
}

- (NSString *)RMBString_MoneyFommat
{
    if(self){
        double num = [self doubleValue];
        NSString *priceStr = @"";
        if([self rangeOfString:@"."].location==NSNotFound){
            return [self RMBString];
        }else{
            priceStr = [NSString stringWithFormat:@"%.2f",num];
            return [priceStr RMBString];
        }
    }
    return @"";
}

- (NSString *)dealWithFloatRMBString{
    
    if (self) {
        
        NSString *targetString = [NSString stringWithString:self];
        NSUInteger stringLength = targetString.length;
        NSInteger num = floorf(stringLength/3.0f);
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger i = 0; i < num; i++) {
            [ranges insertObject:NSStringFromRange(NSMakeRange(stringLength - 3*(i+1), 3)) atIndex:0];
        }
        
        if (stringLength > num*3) {
            NSRange range = NSMakeRange(0, stringLength - num*3);
            [ranges insertObject:NSStringFromRange(range) atIndex:0];
        } else {
            
        }
        
        __block NSMutableArray *subStrings = [NSMutableArray array];
        [ranges enumerateObjectsUsingBlock:^(NSString *rangeString, NSUInteger idx, BOOL *stop) {
            NSRange range = NSRangeFromString(rangeString);
            [subStrings addObject:[targetString substringWithRange:range]];
        }];
        
        return [subStrings componentsJoinedByString:@","];
        
    }
    return nil;
}

/**
 1.00  --> 1
 1.2   --> 1.2
 1.20  --> 1.2
 1.234 --> 1.23
 1.245 --> 1.25
 0.00  --> 0
 0.01  --> 0.01
 */
- (NSString *)RMBString_MoneyFommat_trailOmit
{
    if(self){
        /*
        NSString *str = [self RMBString_MoneyFommat];
        NSRange range = [str rangeOfString:@"."];
        if(range.location != NSNotFound && range.location == (str.length - 3)){
            //小数点后面最多有两个零，所以只要检查两遍就可以了
            for(int i=0;i<3;i++){
                NSString *tstr = [str substringFromIndex:str.length-1];
                if([tstr isEqualToString:@"0"] || [tstr isEqualToString:@"."]){
                    str = [str substringToIndex:str.length - 1];
                }
            }
        }
        return str;
         */
        double d = [self doubleValue];
        NSString *str = [NSString stringWithFormat:@"%.2f",d];
        
        NSRange range = [str rangeOfString:@"."];
        if(range.location!=NSNotFound){

            NSInteger remainCount = str.length - range.location-1;
            if(remainCount==2){
                NSString *aChar = [str substringWithRange:NSMakeRange(range.location+2, 1)];
                if([aChar isEqualToString:@"0"]){
                    str = [str substringToIndex:str.length-1];
                    aChar = [str substringWithRange:NSMakeRange(range.location+1, 1)];
                    if([aChar isEqualToString:@"0"]){
                        //连小数点一起去掉
                        str = [str substringToIndex:str.length-2];
                    }
                }
            }else if(remainCount==1){
                NSString *aChar = [str substringWithRange:NSMakeRange(range.location+1, 1)];
                if([aChar isEqualToString:@"0"]){
                    //连小数点一起去掉
                    str = [str substringToIndex:str.length-2];
                }
            }
        }
        str = [self RMBString:str];
        return str;
    }
    return @"";
}

/**
 替换非英文逗号的标点符号
 */
- (NSString *)repalcePunctuationMarkWithCommaMark {
    
    NSArray *punctuationMarkArr = @[@"，",@"、",@"。",@" ",@" ",@"；",@";",@"."];
    for (int index = 0; index < punctuationMarkArr.count; index++) {
        NSString *str = [punctuationMarkArr objectAtIndex:index];
        
        if ([self rangeOfString:str].location != NSNotFound) {
            return [self stringByReplacingOccurrencesOfString:str withString:@","];
        }
    }
    return self;
}

@end
