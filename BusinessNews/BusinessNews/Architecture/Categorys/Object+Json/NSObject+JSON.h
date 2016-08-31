//
//  NSObject+JSON.h
//  tranb
//
//  Created by VictorChou on 13-12-26.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (JSON)
/**
 * 服务器返回数据的json强制转 number\n
 */
-(NSNumber*)numberValue4Json;
-(NSInteger)integerValue4Json;
-(double)doubleValue4Json;
-(CGFloat)floatValue4Json;
-(long long)longLongValue4Json;
-(NSString*)stringValue4Json;
-(NSArray*)arrayValue4Json;
-(id)objectForKey4JsonForKey:(NSString*)key;
-(id)objectAtIndex4JsonAtIndex:(NSInteger)index;


-(id)objectForKey4UserdefaultForKey:(NSString*)key;

@end
