//
//  NSObject+JSON.m
//  tranb
//
//  Created by VictorChou on 13-12-26.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import "NSObject+JSON.h"
#import "Definition.h"
@implementation NSObject (JSON)
static NSNumberFormatter *numberFormatter;
-(NSNumber*)numberValue4Json;
{
    if (!numberFormatter) {
        numberFormatter=[[NSNumberFormatter alloc] init];
    }
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)self;
    }
    else if ([self isKindOfClass:[NSString class]]&&[numberFormatter numberFromString:(NSString*)self])
    {
        return [numberFormatter numberFromString:(NSString*)self];
    }
    else
    {
        //SLOG(@"numberValue4Json Json 解析异常");
//        NSAssert(0, @"-(NSNumber*)jsonNumber; 解析异常");
        return [NSNumber numberWithInt:0];
    }
}
-(NSInteger)integerValue4Json;
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [[self numberValue4Json] integerValue];
    }
    
    return [[self stringValue4Json] integerValue];
}
-(double)doubleValue4Json;
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [[self numberValue4Json] doubleValue];
    }
    
    return [[self stringValue4Json] doubleValue];
}
-(CGFloat)floatValue4Json;
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [[self numberValue4Json] floatValue];
    }
    return [[self stringValue4Json] floatValue];
}
-(long long)longLongValue4Json;
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [[self numberValue4Json] longLongValue];
    }
    return [[self stringValue4Json] longLongValue];
}
-(NSString*)stringValue4Json;
{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString*)self;
    }
    else if([self isKindOfClass:[NSNumber class]])
    {
//        //SLOG(@"stringValue4Json Json 解析异常");
//        NSAssert(0, @"-(NSString*)stringValue4Json; 解析异常");
        return [(NSNumber*)self stringValue];
    }
    else
    {
        //SLOG(@"stringValue4Json Json 解析异常");
//        NSAssert(0, @"-(NSString*)stringValue4Json; 解析异常");
        return @"";
    }
}
-(NSArray*)arrayValue4Json;
{
    if ([self isKindOfClass:[NSArray class]]) {
        return (NSArray*)self;
    }
    else
    {
        //SLOG(@"arrayValue4Json Json 解析异常");
//        NSAssert(0, @"-(NSArray*)arrayValue4Json; 解析异常");
        return [NSArray array];
    }
}
-(id)objectForKey4UserdefaultForKey:(NSString*)key;
{
    
    if ([self isKindOfClass:[NSUserDefaults class]]) {
        if ([(NSUserDefaults *)self objectForKey:key]) {
            return [(NSUserDefaults *)self objectForKey:key];
        }
        else
        {
            //SLOG(@"objectForKey4JsonForKey Json 解析异常");
            //            NSAssert(0, @"-(NSObject*)objectForKey4JsonForKey; 解析异常");
            return @"";
        }
    }
    return @"";
}
-(id)objectForKey4JsonForKey:(NSString*)key;
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self objectForKey:key]) {
            return [(NSDictionary *)self objectForKey:key];
        }
        else
        {
            //SLOG(@"objectForKey4JsonForKey Json 解析异常");
//            NSAssert(0, @"-(NSObject*)objectForKey4JsonForKey; 解析异常");
            return @"";
        }
    }
    return @"";
}
-(id)objectAtIndex4JsonAtIndex:(NSInteger)index;
{
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count]>index) {
            return [(NSArray *)self objectAtIndex:index];
        }
        else
        {
            //SLOG(@"objectAtIndex4JsonAtIndex Json 解析异常");
//            NSAssert(0, @"-(NSObject*)jsonObjectAtIndex; 解析异常");
            return @"";
        }
    }
    return @"";
}
@end
