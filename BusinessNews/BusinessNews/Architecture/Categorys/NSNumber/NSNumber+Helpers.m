//
//  NSNumber+Helpers.m
//  vdangkou
//
//  Created by Smalltask on 15/3/21.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import "NSNumber+Helpers.h"
#import "NSString+Helpers.h"

@implementation NSNumber (Helpers)


/**
 返回紧凑格式的带千分位分隔符的字符串(不支持负数)
 例如：
 12345678901 --> 科学计数法：12.34E9
 1234567890 --> 12.34亿
 123456789  --> 1.23亿
 12345678   --> 1.23千万
 1234567    --> 123.46万
 123456     --> 12.35万
 12345      --> 1.23万
 1234       --> 1,234
 123        --> 123
 
 1000000    --> 100万  (省略小数点后面的0)
 */
- (NSString *)moneyStringCompact{
    if(self){

        //小数只保留到2两位
        NSString *str = [NSString stringWithFormat:@"%.2f",[self doubleValue]];
        
        if([self compare:@(1000)] == NSOrderedAscending){
            //例如：123
            return [str RMBString_MoneyFommat_trailOmit];
            
        } else if([self compare:@(10000)] == NSOrderedAscending){
            //例如：1234 --> 1,234
            return [str RMBString_MoneyFommat_trailOmit];
            
        } else if([self compare:@(100000)] == NSOrderedAscending){
            // 12345      --> 1.23万
            NSString *ostr = [[self insertPointAtPosition:1 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@万",ostr];
            
        } else if([self compare:@(1000000)] == NSOrderedAscending){
            //  123456     --> 12.35万
            NSString *ostr =  [[self insertPointAtPosition:2 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@万",ostr];
            
        } else if([self compare:@(10000000)] == NSOrderedAscending){
            //  1234567    --> 123.46万
            NSString *ostr =  [[self insertPointAtPosition:3 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@万",ostr];
            
        } else if([self compare:@(100000000)] == NSOrderedAscending){
            //  12345678   --> 1.23千万
            NSString *ostr = [[self insertPointAtPosition:1 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@千万",ostr];
            
        } else if([self compare:@(1000000000)] == NSOrderedAscending){
            // 123456789  --> 1.23亿
            NSString *ostr = [[self insertPointAtPosition:1 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@亿",ostr];
            
        } else if([self compare:@(10000000000)] == NSOrderedAscending) {
            // 1234567890  --> 12.3亿
            NSString *ostr = [[self insertPointAtPosition:2 str:str] RMBString_MoneyFommat_trailOmit];
            return [NSString stringWithFormat:@"%@亿",ostr];
        } else if([self compare:@0] == NSOrderedDescending) {
            // 12345678901xxxxx --> 使用科学计数法
            NSString *ostr = [[self insertPointAtPosition:2 str:str] RMBString_MoneyFommat_trailOmit];
            NSInteger e = [self stringValue].length - 2;
            return [NSString stringWithFormat:@"%@E%ld",ostr,(long)e];
        } else {
            NSAssert(0, @"不支持的精度:%@",self);
        }
        
    }
    return @"";
}

/**
 在position的位置添加一个小数点 .  position位置的内容及后续内容往后移
 */
- (NSString*)insertPointAtPosition:(NSInteger)position str:(NSString*)str{
    
    if(!str){
        return @"";
    }
    if(position < 0){
        position = 0;
    }else if(position >= str.length){
        position = str.length;
    }
    
    NSMutableString *mstr = [NSMutableString new];
    
    for(int i=0;i<str.length;i++){
        if(i == position){
            [mstr appendString:@"."];
        }
        NSRange range;
        range.location = i;
        range.length = 1;
        [mstr appendString:[str substringWithRange:range]];
    }
    return mstr;
    
}

@end
