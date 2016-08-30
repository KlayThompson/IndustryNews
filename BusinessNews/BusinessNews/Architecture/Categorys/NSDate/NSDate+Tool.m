//
//  NSDate+Tool.m
//  tranb
//
//  Created by yanchoujie on 26/11/2014.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import "NSDate+Tool.h"
#import "NSDate+Formats.h"

@implementation NSDate (Tool)

- (NSString *)dateStringFormat:(NSString *)aFormatString{
    
    static  NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:aFormatString];
    if (self) {
        
        return  [formatter stringFromDate:self];
    }
    return nil;
}


//时间处理
/**
 当天内显示“刚刚（5分钟内），XX分钟前，XX小时前”
 
 昨天的消息显示时间“昨天”
 
 昨天之前的消息显示时间“月月-日日”
 */
- (NSString *)getTranbFormatDateString {
    NSString *output = nil;
    
    NSTimeInterval theDiff = -self.timeIntervalSinceNow;
    
    //小于5分钟
    if (theDiff < 60 * 5) {
        output = @"刚刚";
        
    } else if (theDiff < 60 * 60) {
        int minute = (int) (theDiff / 60);
        output = [NSString stringWithFormat:@"%d分钟前", minute];
        
    } else if (theDiff < 60 * 60 * 12) {
        int hour = (int) (theDiff / (60 * 60));
        output = [NSString stringWithFormat:@"%d小时前", hour];
        
    } else if ([self numberOfDaysUntil:[NSDate date]] == 1) {
        
        output = @"昨天";
        
    } else {
        output = [self stringWithFormatMMDD];
    }
    
    return output;
}

//方法测试
//+(void)testMethods
//{
//    NSArray *array =  @[
//                        [NSDate fromJSONDate:@"2015-04-25 16:30:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:30:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 13:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 12:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 11:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 11:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-24 11:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-23 11:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-23 11:48:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:43:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:44:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:45:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:46:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:47:00"]
//                        ,[NSDate fromJSONDate:@"2015-08-25 16:48:00"]];
//    
//    
//    for (NSDate *da in array) {
//        
//        NSString *val = [da getTranbFormatDateString];
//        NSLog(@"%@---%@",[da stringWithFormatYYYYMMDD_HHMMSS],val);
//    }
//    
//    
//}
@end
