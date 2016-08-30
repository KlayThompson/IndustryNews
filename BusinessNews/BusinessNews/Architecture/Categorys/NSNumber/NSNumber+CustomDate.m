//
//  NSNumber+CustomDate.m
//  tranb
//
//  Created by ByronYan on 14-12-3.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import "NSNumber+CustomDate.h"
#import "NSDate+Tool.h"

@implementation NSNumber (CustomDate)

- (NSString *)dateStringWithFormat:(NSString *)aFormatString{

    if (self) {
        NSTimeInterval timeInterval = self.doubleValue;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return [date dateStringFormat:aFormatString];
    }
    return nil;
}
- (NSString *)dateStringFilter1000WithFormat:(NSString *)aFormatString{

    if (self) {
        NSTimeInterval timeInterval = self.doubleValue/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return [date dateStringFormat:aFormatString];
    }
    return nil;
}

@end
