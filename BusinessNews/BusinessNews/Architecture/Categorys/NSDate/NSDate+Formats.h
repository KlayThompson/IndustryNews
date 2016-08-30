//
//  NSDate+Formats.h
//  Yunyou_iphone
//
//  Created by Cai Wenshu on 11/4/13.
//  Copyright (c) 2013 Xietu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formats)

+ (NSDate *)fromJSONDate:(NSString *)aJSONDate;
+ (NSDate *)fromExifDate:(NSString *)aExifDate;
- (NSString *)toExifDate;
+ (NSDate *)fromDateForFormatYYYYMMDD_HHMM:(NSString *)aJSONDate;
- (NSString *)localizedString;
- (NSString *)localizedStringWithTime;
- (NSString *)toJSONDate;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithFormatYYYYMMDD;
- (NSString *)stringWithFormatYYYYMMDD_HHMM;
- (NSString *)stringWithFormatHHMM;
- (NSString *)stringWithFormatYYYYMMDD_HHMMSS;
- (NSString *)stringWithFormatMMDD;
+ (NSDate *)fromDateWithYYYYMMDD:(NSString *)aJSONDate;
- (NSInteger)numberOfDaysUntil:(NSDate *)aDate;
- (NSInteger)numberOfSecondsUntil:(NSDate *)aDate;

//小时,分钟，秒的区分
- (NSDateComponents *)dateComponentsOfHoursMinutesSeconds:(NSDate *)aDate;

@end