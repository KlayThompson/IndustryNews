//
//  StringTools.m
//  tranb
//
//  Created by  SmallTask on 11-9-12.
//  Copyright 2011年 cmf. All rights reserved.
//

#import "StringTools.h"
#import "SysTools.h"
#import "Publish_Definition.h"

#import "NSNumber+Helpers.h"

#import <CommonCrypto/CommonDigest.h>

@implementation StringTools


+(NSString*)stringTimeCurrentTimeIntervalJava;
{
    return [NSString stringWithFormat:@"%llu",[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] longLongValue]];
}
+(NSString*)stringTimeCurrentTimeInterval;
{
    return [NSString stringWithFormat:@"%llu",[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] longLongValue]];
}
+  (int)charNumber:(NSString*)strtemp {
    //计算长度，中文算2 英文算1
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}
+ (NSString *)intervalWithDateString: (NSString *) dateString formate:(NSString*)aFormate;
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    [df setDateFormat:@"yyyyMMdd-HH:mm:ss"];
    [df setDateFormat:aFormate];
    NSDate* dateDirectTime=[df dateFromString:dateString];
    return [NSString stringWithFormat:@"%f",[dateDirectTime timeIntervalSince1970]*1000];
}
+ (NSString *)intervalSinceNowWithDateString: (NSString *) dateString formate:(NSString*)aFormate;
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyyMMdd-HH:mm:ss"];
    [df setDateFormat:aFormate];
    NSDate* dateDirectTime=[df dateFromString:dateString];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-[dateDirectTime timeIntervalSince1970];
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), timeString];
        if (cha/60<1) {
            timeString=NSLocalizedString(@"刚刚", @"");
        }
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), timeString];
        //        if (cha/86400>4) {
        //            NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:late];
        //            NSDateFormatter *fomater=[[[NSDateFormatter alloc] init] autorelease];
        //            [fomater setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        //            timeString=[fomater stringFromDate:modifyDate];
        //        }
    }
    return timeString;
}
+ (NSString *)stringTimeViaJavaString: (NSString*)JavaString;
{
    if (!JavaString||[JavaString isEqualToString:@""]) {
        return @"";
    }
    NSTimeInterval late=[JavaString floatValue]/1000;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), timeString];
        if (cha/60<1) {
            timeString=NSLocalizedString(@"刚刚", @"");
        }
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), timeString];
        //        if (cha/86400>4) {
        //            NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:late];
        //            NSDateFormatter *fomater=[[[NSDateFormatter alloc] init] autorelease];
        //            [fomater setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        //            timeString=[fomater stringFromDate:modifyDate];
        //        }
    }
    return timeString;
}

+ (NSString *)intervalSinceNow: (NSTimeInterval) late
{
    if (late == 0) {
        return @"";
    }
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), timeString];
        if (cha/60<1) {
            timeString=NSLocalizedString(@"刚刚", @"");
        }
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), timeString];
        //        if (cha/86400>4) {
        //            NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:late];
        //            NSDateFormatter *fomater=[[[NSDateFormatter alloc] init] autorelease];
        //            [fomater setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        //            timeString=[fomater stringFromDate:modifyDate];
        //        }
    }
    return timeString;
}
+(NSString*)timeStateViaState:(NSInteger)aState;
{
    switch (aState) {
        case 1:
            return NSLocalizedString(@"今天", @"");
            break;
        case 2:
            return NSLocalizedString(@"昨天", @"");
            break;
        case 3:
            return NSLocalizedString(@"更早", @"");
            break;
        case 4:
            return NSLocalizedString(@"刚刚", @"");
            break;
        default:
            return @"";
            break;
    }
}
+ (NSString *)intervalSinceNowForLBS: (NSTimeInterval) late
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), timeString];
        if (cha/60<1) {
            timeString=NSLocalizedString(@"刚刚", @"");
        }
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), timeString];
    }
    if (cha/86400>1)
    {
        CGFloat days = cha/86400;
        if(days>7.)
            days = 7.f;
        timeString = [NSString stringWithFormat:@"%f", days];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), timeString];
        //        if (cha/86400>4) {
        //            NSDate *modifyDate=[NSDate dateWithTimeIntervalSince1970:late];
        //            NSDateFormatter *fomater=[[[NSDateFormatter alloc] init] autorelease];
        //            [fomater setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        //            timeString=[fomater stringFromDate:modifyDate];
        //        }
    }
    return timeString;
}
+(NSString*)replaceStringUnLegal:(NSString*)aString;
{
    if (!aString||[aString isEqualToString:@""]) {
        return @"";
    }
    NSString *returnString=aString;
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"illegalString" ofType:@"txt"];
    NSString *stringViaText = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSArray *array=[stringViaText componentsSeparatedByString:@"|"];
    for (int i=0; i<[array count]; i++) {
        returnString=[returnString stringByReplacingOccurrencesOfString:[array objectAtIndex:i] withString:@"*"];
    }
    
    return returnString;

}
/**
 返回YES,aString包含了非法字符串
 返回NO,aString可以使用
 */
+(BOOL)checkStringLegal:(NSString*)aString;
{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"illegalString" ofType:@"txt"];
    NSString *stringViaText = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSArray *array=[stringViaText componentsSeparatedByString:@"|"];
    for (int i=0; i<[array count]; i++) {
        NSRange range=[aString  rangeOfString:[array objectAtIndex:i]];
        if (range.length) {
            return YES;
        }
    }
    
    NSString *strs = NSLocalizedString(@"人脉通|商情通|名片通|业务笔记|人情通|群组管理员",@"");
    array=[strs componentsSeparatedByString:@"|"];
    for (int i=0; i<[array count]; i++) {
        NSRange range=[aString  rangeOfString:[array objectAtIndex:i]];
        if (range.length) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)checkStringLegalEn:(NSString*)aString;
{
    //不区分大小写，只要出现就非法内容
    NSArray *normalLegalWords = @[@"bizbook",@"www",@"corporation",@"company",@"co ",@"ltd ",@"inc ",@"incorporated "];
    NSString *tmpStr = [aString lowercaseString];
    for(int i=0;i<normalLegalWords.count;i++){
        NSRange range = [tmpStr rangeOfString:normalLegalWords[i]];
        if(range.length)
            return YES;
    }
    //必须是大写才非法的内容,单词后面必须跟一个空格；
    NSArray *upcaseLegalWords = @[@"LLC ",@"LLLP ",@"ABAG ",@"ANS ",@"A/S ",@"AS ",@"GmbH ",@"K.K. ",@"N.V. "];
    for(int i=0;i<upcaseLegalWords.count;i++){
        NSRange range = [aString rangeOfString:upcaseLegalWords[i]];
        if(range.length)
            return YES;
    }
    return NO;
}

+(NSString*)praseIconString:(NSString*)_msgstr;
{
    NSString *strArray[1][2] = {
        {@"\\ue415",@"\ue415"}
    };
    
    NSString *str = _msgstr;
    for(int i=0;i<1;i++)
    {
        str = [str stringByReplacingOccurrencesOfString:strArray[i][0] withString:strArray[i][1]];
    }
    return str;
    
}


+(NSString*)ConvertTimeToLocalTime:(NSString*)_sourceTime;
{
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:gmt];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss zzzz"];
    NSDate *currentDate = [df dateFromString:_sourceTime];
    
    [df setTimeZone:defaultTimeZone];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df stringFromDate:currentDate];
}

+(NSString*)FommatSqlParam:(NSString*)_paramStr;
{
    if(!_paramStr)
        return @"";
    NSString *okStr = [_paramStr stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return okStr;
}

+(NSString*)FormatPhone:(NSString*)_phone;
{
    if(!_phone)
        return @"";
    NSString *phoneStr = [_phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    //phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"'" withString:@""];
    return phoneStr;
}






+(NSInteger)GetCurrentYear;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nowDate = [NSDate date];
    //NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    NSInteger cyear = [comps year];
    return cyear;
}

+(NSInteger)GetCurrentMonth;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nowDate = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    NSInteger cmonth = [comps month];
    
    return cmonth;
}

+(NSInteger)GetCurrentDay;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nowDate = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    NSInteger cday = [comps day];
    return cday;
}

+(NSInteger)GetYear:(NSDate*)_date;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger cyear = [comps year];
    return cyear;
}

+(NSInteger)GetMonth:(NSDate*)_date;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger cmonth = [comps month];
    return cmonth;
}

+(NSInteger)GetDay:(NSDate*)_date;
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger cday = [comps day];
    return cday;
}

+(NSString*)EnImg:(NSString*)_imgFileName;
{
    NSString *fileName = [NSString stringWithFormat:@"en_%@",_imgFileName];
    return fileName;
}

+(NSString*)RemoveBadWordForServer:(NSString*)_str;
{

    NSString *okStr = [_str lowercaseString];
    if([okStr isEqualToString:@"null"])
        return @"nu11";
    else
        return _str;
    
}
+(NSString*)GetProductMiddlePicViaRealUrl:(NSString*)aUrl;
{
    NSString *tmpUrl=[aUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"middle.jpg"];
    return tmpUrl;
}
//+(NSString*)GetProductSmallPicViaRealUrl:(NSString*)aUrl;
//{
//    NSString *tmpUrl=[aUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"small.jpg"];
//    SLOG(@"small%@",tmpUrl);
//    return tmpUrl;
//}
//+(NSString*)GetProductPicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;
//{
//    NSString *string=[NSString stringWithFormat:@"%@/PRODUCT_PIC/%ld/%ld_%ld.jpg",SERVER_PATH,(long)aUid%512,(long)aProductId,(long)aPhotoId];
//        SLOG(@"big%@",string);
//    return string;
//}
//+(NSString*)GetProductMiddlePicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;
//{
//    NSString *string=[NSString stringWithFormat:@"%@/PRODUCT_PIC/%ld/%ld_%ldmiddle.jpg",SERVER_PATH,(long)aUid%512,(long)aProductId,(long)aPhotoId];
//    return string;
//}
//+(NSString*)GetProductSmallPicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;
//{
//    NSString *string=[NSString stringWithFormat:@"%@/PRODUCT_PIC/%ld/%ld_%ldsmall.jpg",SERVER_PATH,(long)aUid%512,(long)aProductId,(long)aPhotoId];
//    SLOG(@"small%@",string);
//    return string;
//}
+(NSString*)GetSQTShareStringViaSocialType:(id)aSocialType;
{
    if (aSocialType&& [[SysTools NumberObj:aSocialType] intValue]==1) {
        return NSLocalizedString(@" 分享了文章：%@ 到新浪微博",@"");
    }
    else if (aSocialType&& [[SysTools NumberObj:aSocialType] intValue]==2)
    {
        return NSLocalizedString(@" 分享了文章：%@ 到微信",@"");
    }
    else if (aSocialType&& [[SysTools NumberObj:aSocialType] intValue]==3)
    {
        return NSLocalizedString(@" 分享了文章：%@ 到LinkedIn",@"");
    }
    else if (aSocialType&& [[SysTools NumberObj:aSocialType] intValue]==4)
    {
        return NSLocalizedString(@" 分享了文章：%@ 到QQ",@"");
    }
    else
    {
        return NSLocalizedString(@" 喜欢文章：%@ ",@"");
    }
}



/*对sourceStr进行处理，获取与服务器端通信使用的字符
 处理内容：
 （1）替换null为nu11
 (2)字符串长度检查，对超出长度的字符串自动截断；
 */
+ (NSString*)GetServerString:(NSString*)sourceStr limitLen:(NSInteger)_limitLen;
{
    NSString *targetStr = [StringTools RemoveBadWordForServer:sourceStr];
    if(sourceStr.length>_limitLen)
        targetStr = [targetStr substringToIndex:_limitLen];
    return targetStr;
}

+ (NSString*)getStatusMiddleImageViaRealUrl:(NSString*)url;
{
    return [[url stringByReplacingOccurrencesOfString:@".jpg" withString:@"middle.jpg"]
                    stringByReplacingOccurrencesOfString:@".jpeg" withString:@"middle.jpg"];
}



//+(NSString*)stringRemove6NumberWithString:(NSString*)rawString;
//{
//    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(([0-9]+):){6}" options:0 error:NULL];
//    NSString* resultString = [regex stringByReplacingMatchesInString:rawString options:0 range:NSMakeRange(0, [rawString length]) withTemplate:@""];
//    return resultString;
//}
//+(NSString*)stringRemove6EnWithString:(NSString*)rawString;
//{
//    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(([A-Za-z]+):){6}" options:0 error:NULL];
//    NSString* resultString = [regex stringByReplacingMatchesInString:rawString options:0 range:NSMakeRange(0, [rawString length]) withTemplate:@""];
//    return resultString;
//}







+(NSString*)GetShareURLStringWithShareType:(shareLinkType)type channel:(shareLinkChannel)channel;
{
//    http://www.9tong.com/down/user/mail/
    NSMutableString *stringShareLink=[NSMutableString stringWithFormat:@"http://%@/down/",H_SERVER_PATH_URL];
    NSDictionary *dictType=[NSDictionary dictionaryWithObjectsAndKeys:
                            @"invite",[NSNumber numberWithInteger:shareLinkTypeInvite],
                            @"sgq",[NSNumber numberWithInteger:shareLinkTypeSDR],
                            @"srmt",[NSNumber numberWithInteger:shareLinkTypeRMT],
                            @"minvite",[NSNumber numberWithInteger:shareLinkTypeCardInvite],
                            @"sm",[NSNumber numberWithInteger:shareLinkTypeCardShare],
                            @"sqt",[NSNumber numberWithInteger:shareLinkTypeSQT],
                            @"user",[NSNumber numberWithInteger:shareLinkTypeUserProfile],
                            @"group",[NSNumber numberWithInteger:shareLinkTypeGroupTopic],
                            @"meeting",[NSNumber numberWithInteger:shareLinkTypeMeeting],
                            @"product",[NSNumber numberWithInteger:shareLinkTypeProduct],
                            @"status",[NSNumber numberWithInteger:shareLinkTypeStatus],
                            @"qrcode",[NSNumber numberWithInteger:shareLinkTypeQRCode],
                            nil];
    if ([dictType objectForKey:[NSNumber numberWithInteger:type]]) {
        [stringShareLink appendString:[dictType objectForKey:[NSNumber numberWithInteger:type]]];
        [stringShareLink appendString:@"/"];
    }
    NSDictionary *dictChannel=[NSDictionary dictionaryWithObjectsAndKeys:
                               @"bk",[NSNumber numberWithInteger:shareLinkChannelAddressBook],
                               @"sina",[NSNumber numberWithInteger:shareLinkChannelWeibo],
                               @"lin",[NSNumber numberWithInteger:shareLinkChannelLinkedIn],
                               @"qq",[NSNumber numberWithInteger:shareLinkChannelQQ],
                               @"wx",[NSNumber numberWithInteger:shareLinkChannelWechatSession],
                               @"wxq",[NSNumber numberWithInteger:shareLinkChannelWechatTimeline],
                               @"mail",[NSNumber numberWithInteger:shareLinkChannelMail],
                                @"group",[NSNumber numberWithInteger:shareLinkChannelGroup],
                            nil];
    if ([dictChannel objectForKey:[NSNumber numberWithInteger:channel]]) {
        [stringShareLink appendString:[dictChannel objectForKey:[NSNumber numberWithInteger:channel]]];
        [stringShareLink appendString:@"/"];
    }
    return stringShareLink;
}







+ (NSString *)getStringFromCGFLoat:(double)aFloatNum{
    NSString *str = [NSString stringWithFormat:@"%f",aFloatNum];
    NSInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

+ (NSString*)sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}



+ (NSString*)getJsonString:(NSDictionary*)jsonDict
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&err];
    if (jsonData && jsonData.length>0 && !err){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return @"";
    }
    
    
}

/**检查url前面有没有http://这样的前缀，
 如果没有，自动添加http://并返回；
 如果有，则原样返回
 */
+ (NSString *)autoAppendHttpPrefix:(NSString *)sourceUrl {
    if(STR_IS_NIL(sourceUrl)){
        return sourceUrl;
    }else if([sourceUrl.lowercaseString hasPrefix:@"http://"]){
        return sourceUrl;
    }else if([sourceUrl.lowercaseString hasPrefix:@"https://"]){
        return sourceUrl;
    }else if([sourceUrl.lowercaseString rangeOfString:@"://"].location != NSNotFound){
        return sourceUrl;
    }else{
        //自动补充http://前缀
        return [NSString stringWithFormat:@"http://%@",sourceUrl];
    }
}

#pragma mark - 金额处理
/**
 获取人民币类型的字符串；
 @param source 输入内容： NSNumber 或 NSString类型；
 @param unitName 单位名称，例如：公斤、米、码等；
 
 @return 返回内容：例：￥10,000.00/米
 
 source为nil，则返回@""
 source为NSNumber的情况，按实际数值输入，小数点后保留2位
 source为NSString时，先将source转为NSNumber，然后再转换输出；
 unitName如果是nil或空串，则不显示 / 分隔符
 
 测试结果：
 ---->start!
 1234567890 --> ￥ 1,234,567,890.00/公斤
 123 --> ￥ 123.00/公斤
 1 --> ￥ 1.00/公斤
 1.1234567890 --> ￥ 1.12/公斤
 1234567890.1234567890 --> ￥ 1,234,567,890.12/公斤
 .01 --> ￥ 0.01/公斤
 .001 --> ￥ 0.00/公斤
 .0001 --> ￥ 0.00/公斤
 1234567890.5555 --> ￥ 1,234,567,890.56/公斤
 1234567890.44444 --> ￥ 1,234,567,890.44/公斤
 abcdefg --> ￥ 0.00/公斤
 --> ￥ 0.00/公斤
 a1b2c3d4.a1b2c3d4 --> ￥ 0.00/公斤
 1.2.3.4.5.6 --> ￥ 0.00/公斤
 1234567890.1234567890.1234567890 --> ￥ 0.00/公斤
 
 */
+ (NSString*)getMoneyFomatString:(id)source unitName:(NSString*)unitName{
    if(!source){
        return @"";
    }
    if([source isKindOfClass:[NSNumber class]]){
        return [StringTools getMoneyFomatStringWithNumber:source unitName:unitName];
    }else if([source isKindOfClass:[NSString class]]){
        NSNumber *number = [SysTools NumberObj:source];
        return [StringTools getMoneyFomatStringWithNumber:number unitName:unitName];
    }else{
        NSAssert(0,@"未实现的方法");
        return source;
    }
    
}

+ (NSString*)getMoneyFomatStringWithNumber:(NSNumber*)source unitName:(NSString*)unitName{
    if(!source){
        return @"";
    }
    /* V1.700 zhy
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"#,##0.00"];
    NSString *convertNumber = [formatter stringFromNumber:source];
    NSMutableString *result = [NSMutableString stringWithFormat:@"￥%@",convertNumber];
    if(unitName && ![unitName isEqualToString:@""]){
        [result appendString:@"/"];
        [result appendString:unitName];
    }
    return result;
     */
    NSString *priceStr = [source moneyStringCompact];
    NSMutableString *result = [NSMutableString stringWithFormat:@"￥%@元",priceStr];
    if(!STR_IS_NIL(unitName)){
        [result appendString:@"/"];
        [result appendString:unitName];
    }
    return result;
}

+(NSDictionary*)formatDateAndWeek:(NSString*)_dateStr byFormat:(NSString*)_format toFormat:(NSString*)_2format;
{
    NSDate *tempDate;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyyMMdd-HHmmss"];
    [formatter setDateFormat:_format];
    tempDate=[formatter dateFromString:_dateStr];
    [formatter setDateFormat:@"EEEE"];
    NSString *weekStr=[formatter stringFromDate:tempDate];
    [formatter setDateFormat:_2format];
    NSString *formatStr=[formatter stringFromDate:tempDate];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:weekStr,@"week",formatStr,@"date", nil];
    
    return dic;
}

@end
