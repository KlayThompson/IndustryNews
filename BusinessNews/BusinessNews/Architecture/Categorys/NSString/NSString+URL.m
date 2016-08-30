//
//  NSString+URL.m
//  tranb
//
//  Created by yanchoujie on 7/1/2015.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import "NSString+URL.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation NSString (URL)
- (NSString *)URLString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end
