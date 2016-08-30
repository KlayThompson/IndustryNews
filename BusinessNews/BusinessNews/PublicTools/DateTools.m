//
//  DateTools.m
//  tranb
//
//  Created by SmallTask on 12-8-30.
//  Copyright (c) 2012年 cmf. All rights reserved.
//

#import "DateTools.h"

@implementation DateTools

-(void)Calculate
{
    /**关闭,暂时没有用处
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    
    // 年月日获得
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) 
                        fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    SLOG(@"year: %d month: %d, day: %d", year, month, day);
    
    
    //当前的时分秒获得
    comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                        fromDate:date];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    SLOG(@"hour: %d minute: %d second: %d", hour, minute, second);
    
    // 周几和星期几获得
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
    SLOG(@"week: %d weekday: %d weekday ordinal: %d", week, weekday, weekdayOrdinal);
     */
}

/**
 * _month:[1..12]
 */
+(NSString*)GetMonthStr:(NSInteger)_month;
{
    _month--;
    if(IsChineseVersion)
    {
        NSString *monthStr[12] = {@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"};
        return monthStr[_month];
    }else if(IsEnglishVersion)
    {
        NSString *monthStr[12] = {@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec"};
        return monthStr[_month];
    }else if(IsJapanVersion)
    {
        NSString *monthStr[12] = {@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec"};
        return monthStr[_month];
    }else 
        return @"";
}

/**
 * _month:0..11
 */
+(NSString*)GetMonthStrComplet:(NSInteger)_month;
{
    _month--;
    if(IsChineseVersion)
    {
        NSString *monthStr[12] = {@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"};
        return monthStr[_month];
    }else if(IsEnglishVersion)
    {
        NSString *monthStr[12] = {@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"};
        return monthStr[_month];
    }else if(IsJapanVersion)
    {
        NSString *monthStr[12] = {@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec"};
        return monthStr[_month];
    }else 
        return @"";
}
+(NSString*)GetDayViaDate:(NSDate*)date;
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:date];
}
+(NSString*)getMonthViaDate:(NSDate*)date;
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSInteger _month=[[formatter stringFromDate:date] intValue];
    _month--;
    if(IsChineseVersion)
    {
        NSString *monthStr[12] = {@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"};
        return monthStr[_month];
    }else if(IsEnglishVersion)
    {
        NSString *monthStr[12] = {@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"};
        return monthStr[_month];
    }else if(IsJapanVersion)
    {
        NSString *monthStr[12] = {@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec"};
        return monthStr[_month];
    }else
        return @"";
}
+(NSString*)GetWeekViaDate:(NSDate*)date;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit) fromDate:date];
    NSInteger _day = [comps weekday] - 1; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    if(IsChineseVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else if(IsEnglishVersion)
    {
        NSString *dayStr[7] = {@"Sun.",@"Mon.",@"Tue.",@"Wed.",@"Thu.",@"Fri.",@"Sat."};
        return dayStr[_day];
    }else if(IsJapanVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else
        return @"";
}
+(NSString*)GetWeekdayStr:(NSString*)_dateStr;
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSDate *startDate=[formatter dateFromString:_dateStr];
    //    [formatter setDateFormat:@"EEEE"];    
    //    NSString *weekStr=[formatter stringFromDate:startDate];
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit) fromDate:startDate];
    
    NSInteger _day = [comps weekday] - 1; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    if(IsChineseVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else if(IsEnglishVersion)
    {
        NSString *dayStr[7] = {@"Sun.",@"Mon.",@"Tue.",@"Wed.",@"Thu.",@"Fri.",@"Sat."};
        return dayStr[_day];
    }else if(IsJapanVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else 
        return @"";
}
+(NSString*)GetWeekdayStrViaWeekday:(NSInteger)weekday;
{
    NSInteger _day = weekday - 1; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    if(IsChineseVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else if(IsEnglishVersion)
    {
        NSString *dayStr[7] = {@"Sun.",@"Mon.",@"Tue.",@"Wed.",@"Thu.",@"Fri.",@"Sat."};
        return dayStr[_day];
    }else if(IsJapanVersion)
    {
        NSString *dayStr[7] = {@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"};
        return dayStr[_day];
    }else
        return @"";
}

///根据java的时间戳返回
+(NSString*)GetTimeFromJavaTimeStamp:(NSString*)_javaTimeStamp;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_javaTimeStamp doubleValue]]];
    return time;
}
+(NSString*)GetTimeFromdate:(NSDate*)date format:(NSString*)fromat;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromat];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

/**
 返回与java服务器格式一致的时间格式；
 重要：在屏幕上回显时，记的要/1000，不然时间就变成未来的某个时间了
 */
+(long long int)GetCurrentTimeNumber;
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int uu = time*1000;//＊1000是为了与服务器端的格式一致；
    //    SLOG(@"SysTools.GetCurrentTimeNumber,time:%lli",uu);
    return uu;
}
+(NSString*)GetJavaTimeIntervalStringViaObjectTimeIntervalString:(NSString*)objTimeString;
{
    long long int uu = [objTimeString doubleValue]*1000;//＊1000是为了与服务器端的格式一致；
    return [NSString stringWithFormat:@"%lld",uu];
}
+(NSTimeInterval)TimeIntervalVia:(NSString*)dateStr;
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSDate *startDate=[formatter dateFromString:dateStr];
    return [startDate timeIntervalSince1970];
}

/** 
 将服务器端返回的时间戳转换成服务器端返回的时间字符串的格式；
 
 _javaTimeStamp内容的形式:1392098750795
 返回数据的形式：20140211-06:05:50
 
 */
+(NSString*)GetTimeStringFromJavaTimeStampForComments:(NSString*)_javaTimeStamp;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd-HH:mm:ss"];
    NSString *time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_javaTimeStamp doubleValue]/1000]];
  
    return time;
}

+(NSString*)GetTimeStringFromJavaTimeStamp:(NSString*)_javaTimeStamp;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_javaTimeStamp doubleValue]/1000]];
    
    return time;
}

+(NSString*)Getyyyy_MM_ddWithDate:(NSNumber*)_javaTimeStamp;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_javaTimeStamp doubleValue]/1000]];
  
    return time;
}

///获取当前时间到用户注册时间的天数；假设用户在2014.12.22注册，今天是2014.12.25,则函数返回：4;(22,23,24,25)
///如果当前时间小于注册时间，返回0
+(NSInteger)GetDaysFromUserRegistTime:(NSString*)javaTimeStamp{
    long long int registTime = [javaTimeStamp longLongValue];
    long long int currentTime = [DateTools GetCurrentTimeNumber];
    //timeSpan的单位是豪秒
    long long int timeSpan = currentTime - registTime;
    if(timeSpan>0){
        NSInteger days = timeSpan/(1000*60*60*24);
        SLOG(@"时间差days:%ld",(long)days);
        return days;
    }else
        return 0;
}

@end
