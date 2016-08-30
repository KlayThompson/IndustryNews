//
//  NSNumber+CustomDate.h
//  tranb
//
//  Created by ByronYan on 14-12-3.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CustomDate)

- (NSString *)dateStringWithFormat:(NSString *)aFormatString;
- (NSString *)dateStringFilter1000WithFormat:(NSString *)aFormatString;

@end
