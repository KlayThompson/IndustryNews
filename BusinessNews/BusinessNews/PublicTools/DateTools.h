//
//  DateTools.h
//  tranb
//
//  Created by SmallTask on 12-8-30.
//  Copyright (c) 2012年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"

@interface DateTools : NSObject


+(NSString*)GetMonthStr:(NSInteger)_month;

//获取完整的月份拼写
+(NSString*)GetMonthStrComplet:(NSInteger)_month;

///获取星期几
+(NSString*)GetWeekdayStr:(NSString*)_dateStr;

///根据java的时间戳返回
+(NSString*)GetTimeFromJavaTimeStamp:(NSString*)_javaTimeStamp;


+(NSString*)GetWeekdayStrViaWeekday:(NSInteger)weekday;

+(NSString*)GetTimeFromdate:(NSDate*)date format:(NSString*)fromat;

+(long long int)GetCurrentTimeNumber;
+(NSTimeInterval)TimeIntervalVia:(NSString*)dateStr;


+(NSString*)GetDayViaDate:(NSDate*)date;
+(NSString*)getMonthViaDate:(NSDate*)date;
+(NSString*)GetWeekViaDate:(NSDate*)date;
+(NSString*)GetJavaTimeIntervalStringViaObjectTimeIntervalString:(NSString*)objTimeString;
+(NSString*)GetTimeStringFromJavaTimeStampForComments:(NSString*)_javaTimeStamp;
+(NSString*)GetTimeStringFromJavaTimeStamp:(NSString*)_javaTimeStamp;

+(NSString*)Getyyyy_MM_ddWithDate:(NSNumber*)_javaTimeStamp;

///获取当前时间到用户注册时间的天数；假设用户在2014.12.22注册，今天是2014.12.25,则函数返回：4;(22,23,24,25)
+(NSInteger)GetDaysFromUserRegistTime:(NSString*)javaTimeStamp;

@end
