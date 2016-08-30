//
//  NSNumber+Helpers.h
//  vdangkou
//
//  Created by Smalltask on 15/3/21.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Helpers)

/**
 返回紧凑格式的带千分位分隔符的字符串
 例如：
 1234567890 --> 12.34亿
 123456789  --> 1.23亿
 12345678   --> 1.23千万
 1234567    --> 123.46万
 123456     --> 12.35万
 12345      --> 1.23万
 1234       --> 1,234
 123        --> 123
 */
- (NSString *)moneyStringCompact;

@end
