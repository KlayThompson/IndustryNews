//
//  NSDate+Formats.m
//  Yunyou_iphone
//
//  Created by Cai Wenshu on 11/4/13.
//  Copyright (c) 2013 Xietu. All rights reserved.
//

#import "NSDate+Formats.h"

@implementation NSDate (Formats)

- (NSString *)localizedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)localizedStringWithTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toJSONDate
{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)fromJSONDate:(NSString *)aJSONDate
{
    if (aJSONDate == nil) {
        return nil;
    }
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:aJSONDate];
}


+ (NSDate *)fromExifDate:(NSString *)aExifDate
{
    if (aExifDate == nil) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];

    return [formatter dateFromString:aExifDate];
}

- (NSString *)toExifDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    
    return [formatter stringFromDate:self];
}

+ (NSDate *)fromDateForFormatYYYYMMDD_HHMM:(NSString *)aJSONDate
{
    if (aJSONDate == nil || [aJSONDate isEqualToString:@""]) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:aJSONDate];
}


- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}


- (NSString *)stringWithFormatYYYYMMDD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatYYYYMMDD_HHMM
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatYYYYMMDD_HHMMSS
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatHHMM
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormatMMDD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MM-dd"];
    return [dateFormatter stringFromDate:self];
}



+ (NSDate *)fromDateWithYYYYMMDD:(NSString *)aJSONDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:aJSONDate];
}

- (NSInteger)numberOfDaysUntil:(NSDate *)aDate {
    
    NSDate *fromDate = [NSDate fromDateWithYYYYMMDD:[self stringWithFormatYYYYMMDD]];
    NSDate *toDate = [NSDate fromDateWithYYYYMMDD:[aDate stringWithFormatYYYYMMDD]];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    
    return [components day];
}

- (NSInteger)numberOfSecondsUntil:(NSDate *)aDate {

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitSecond fromDate:self toDate:aDate options:0];
    
    return [components second];
}


- (NSDateComponents *)dateComponentsOfHoursMinutesSeconds:(NSDate *)aDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:self toDate:aDate options:0];
    
    return components;
}


@end
