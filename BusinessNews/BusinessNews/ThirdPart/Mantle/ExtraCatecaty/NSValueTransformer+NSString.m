//
//  NSValueTransformer+NSString.m
//  RMT_iphone
//
//  Created by VictorChou on 14-8-6.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import "NSValueTransformer+NSString.h"
#import "Mantle.h"

NSString * const TMDStringValueTransformerName = @"TMDStringValueTransformerName";

@implementation NSValueTransformer (NSString)

+ (void)load {
    @autoreleasepool {
        MTLValueTransformer *stringValueTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^(id value) {
            if ([value isKindOfClass:[NSNumber class]]) {
                return [(NSNumber*)value stringValue];
            } else {
                return (NSString*)value;
            }
        } reverseBlock:^(NSString *value) {
            return value;
        }];
        
        [NSValueTransformer setValueTransformer:stringValueTransformer forName:TMDStringValueTransformerName];
    }
}
@end