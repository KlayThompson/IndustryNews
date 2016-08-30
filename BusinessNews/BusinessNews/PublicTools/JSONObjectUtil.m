//
//  JSONObjectUtil.m
//  tranb
//
//  Created by 姚卓禹 on 15/8/12.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import "JSONObjectUtil.h"

@implementation JSONObjectUtil


+ (NSString *)stringFromDict:(NSDictionary *)dict{
    if (DICT_IS_NIL(dict)) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)dictFromString:(NSString *)str{
    if (STR_IS_NIL(str)) {
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
}


@end
