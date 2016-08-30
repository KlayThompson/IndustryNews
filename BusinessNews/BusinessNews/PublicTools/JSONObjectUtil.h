//
//  JSONObjectUtil.h
//  tranb
//
//  Created by 姚卓禹 on 15/8/12.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObjectUtil : NSObject

+ (NSString *)stringFromDict:(NSDictionary *)dict;
+ (NSDictionary *)dictFromString:(NSString *)str;

@end
