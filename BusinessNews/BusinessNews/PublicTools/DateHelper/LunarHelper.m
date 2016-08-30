//
//  LunarHelper.m
//  TestCheckIn
//
//  Created by andylee1988 on 11-12-17.
//  Copyright (c) 2011年 andylee1988 All rights reserved.//


#import "LunarHelper.h"

int lunarDaysOfMonth[] ={
    0xd4a8, 0xd4a0, 0xda50, 0x5aa8, 0x56a0, 0xaad8, 0x25d0, 0x92d0, 0xc958, 0xa950, // 2001-2010
    0xb4a0, 0xb550, 0xb550, 0x55a8, 0x4ba0, 0xa5b0, 0x52b8, 0x52b0, 0xa930, 0x74a8, // 2011-2020
    0x6aa0, 0xad50, 0x4da8, 0x4b60, 0x9570, 0xa4e0, 0xd260, 0xe930, 0xd530, 0x5aa0, // 2021-2030
    0x6b50, 0x96d0, 0x4ae8, 0x4ad0, 0xa4d0, 0xd258, 0xd250, 0xd520, 0xdaa0, 0xb5a0, // 2031-2040
    0x56d0, 0x4ad8, 0x49b0, 0xa4b8, 0xa4b0, 0xaa50, 0xb528, 0x6d20, 0xada0, 0x55b0  // 2041-2050
};

int lunarLeapYear[] ={
    0x40, 0x02, 0x07, 0x00, 0x50, // 2001-2010
    0x04, 0x09, 0x00, 0x60, 0x04, // 2011-2020
    0x00, 0x20, 0x60, 0x05, 0x00, // 2021-2030
    0x30, 0xb0, 0x06, 0x00, 0x50, // 2031-2040
    0x02, 0x07, 0x00, 0x50, 0x03  // 2041-2050
};

@implementation LunarHelper
// 返回农历lunarLeapYear年的闰月月份，如没有则返回0
- (int)getLeapMoth:(int)intLunarYear {
    int intLeap = lunarLeapYear[(intLunarYear - 2001) >> 1];
    return (((intLunarYear - 2001) & 1) == 0) ? (intLeap >> 4):(intLeap & 0x0f);
}

// 返回农历lunarLeapYear年lunarDaysOfMonth月的天数，结果是一个长整数
// 如果lunarDaysOfMonth不是闰月， 高字为0，低字为该月的天数
// 如果lunarDaysOfMonth是闰月， 高字为后一个月的天数，低字为前一个月的天数

- (int)lunarMonthDays:(int)intLunarYear month:(int)intLunarMonth {
    int intHigh;
    int intLow;
    int intBit;
    intHigh = 0;
    intLow = 29;
    intBit = 16 - intLunarMonth;
    int intLeapMoth = [self getLeapMoth:intLunarYear];
    if (intLunarMonth > intLeapMoth && intLeapMoth > 0) {
        intBit -- ;
    }
    if ((lunarDaysOfMonth[intLunarYear - 2001] & (1 << intBit)) > 0) {
        intLow ++;
    }
    
    if (intLunarMonth == intLeapMoth) {
        intHigh = ((lunarDaysOfMonth[intLunarYear - 2001] & (1 << (intBit-1))) > 0) ?  30 : 29;
    }
    
    return intLow + (intHigh << 16);
}

// 返回农历lunarYear年的总天数
- (int)lunarYearDays:(int)intLunarYear {
    int intTmp;
    int intDays = 0;
    for (int i = 1; i <= 12; i++) {
        intTmp = [self lunarMonthDays:intLunarYear month:i];
        intDays = intDays + ((intTmp >> 16) & 0xffff); //取高位
        intDays = intDays + (intTmp & 0xffff); //取低位
    }
    
    return intDays;
}

// 将农历lunarYear年格式化成天干地支记年法表示的字符串
- (NSString*)formatLunarYear:(int)intLunarYear {
    NSString *strText1 = @"甲乙丙丁戊己庚辛壬癸";
    NSString *strText2 = @"子丑寅卯辰巳午未申酉戌亥";
    NSString *strYear;
    strYear = [strText1 substringWithRange:NSMakeRange((intLunarYear - 4) % 10, 1)];
    NSString *strTemp = [strText2 substringWithRange:NSMakeRange((intLunarYear - 4) % 12, 1)];
    strYear = [NSString stringWithFormat:@"%@%@年",strYear,strTemp];
    return strYear;
}



// 将农历lunarMonth月格式化成农历表示的字符串
- (NSString*)formatLunarMonth:(int)intLunarMonth {
    NSString *strText = @"正二三四五六七八九十";
    NSString *strMonth;
    if (intLunarMonth <= 10) {
        strMonth = [strText substringWithRange:NSMakeRange(intLunarMonth - 1,1)];
    } else if (intLunarMonth == 11) {
        strMonth = @"冬";
    } else {
        strMonth = @"腊";
    }
    
    return [strMonth stringByAppendingFormat:@"月"];
}

// 将农历lunarDay日格式化成农历表示的字符串
- (NSString*)formatLunarDay:(int)intLunarDay {
    NSString *strText1 = @"初十廿三";
    NSString *strText2 = @"一二三四五六七八九十";
    NSString *strDay;
    if ((intLunarDay != 20) && intLunarDay != 30) {
        NSString *str1 = [strText1 substringWithRange:NSMakeRange((intLunarDay - 1)/10,1)];
        NSString *str2 = [strText2 substringWithRange:NSMakeRange((intLunarDay - 1)%10,1)];
        strDay = [NSString stringWithFormat:@"%@%@",str1,str2];
    } else if (intLunarDay == 20) {
        strDay = @"二十";
    } else {
        strDay = @"三十";
    }
    return strDay;
}

// 将公历日期转换为农历日期，返回农历表示的字符串
- (NSString*)getLunarDateString:(NSDate*)aDate {
    int tmp;
    int intLunarYear;
    int intLunarMonth;
    int intLunarDay;
    BOOL bLeap = NO;
    int intMinMilli = 60;
    int intHrMilli = intMinMilli * 60;
    int intDyMilli = intHrMilli * 24;
    // 从2001年1月1日算起，给定的公历日期已经过去的天数
    // 11323是1970年1月1日到2001年1月1日之间的天数，因为Date是从1970年1月1日作为起点的
//    NSLog(@"%f 天",[aDate timeIntervalSince1970]/intDyMilli);
    int intSpanDays = (int)([aDate timeIntervalSince1970]/intDyMilli) - 11323;
    // 公历2001年1月24日为农历2001年正月初一，差23天
    if (intSpanDays < 23) {
        intLunarYear = 2000;
        intLunarMonth = 12;
        intLunarDay = intSpanDays + 7;
    }
    else {
        // 从农历2001年正月初一算起
        intSpanDays = intSpanDays - 23;
        intLunarYear = 2001;
        intLunarMonth = 1;
        intLunarDay = 1;
        // 计算农历年
        tmp = [self lunarYearDays:intLunarYear];
        while (intSpanDays >= tmp) {
            intSpanDays -= tmp;
            intLunarYear++ ;
            tmp = [self lunarYearDays:intLunarYear];
        }
        
        // 计算农历月
        tmp = [self lunarMonthDays:intLunarYear month:intLunarMonth] & 0xffff; //取低字
        while (intSpanDays >= tmp) {
            intSpanDays -= tmp;
            //该年该月闰月
            if (intLunarMonth == [self getLeapMoth:intLunarYear]) {
                tmp = [self lunarMonthDays:intLunarYear month:intLunarMonth] >> 16; //取高字
                if (intSpanDays < tmp) {
                    bLeap = (tmp > 0) ? YES:NO;//闰月的后个月？
                    break;
                }
                
                intSpanDays = intSpanDays - tmp;
            }
            
            intLunarMonth++;
            tmp = [self lunarMonthDays:intLunarYear month:intLunarMonth] & 0xffff;//取低字
        }
        intLunarDay += intSpanDays;
    }
    
    NSString *strResult1 = [self formatLunarYear:intLunarYear];
    NSString *strResult2 = bLeap ? @"闰" : @"";
    NSString *strResult3 = [self formatLunarMonth:intLunarMonth];
    NSString *strResult4 = [self formatLunarDay:intLunarDay];
    return [NSString stringWithFormat:@"%@%@%@%@",strResult1,strResult2,strResult3,strResult4];
}

@end