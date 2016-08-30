//
//  NSString+WBEncode.m
//  tranb
//
//  Created by yanchoujie on 8/3/2015.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import "NSString+WBEncode.h"
#import "NSData+WBEncode.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//#import "GTMBase64.h"

@implementation NSString (WBEncode)

- (NSString *)MD5EncodedString
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5EncodedString];
}

- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] HMACSHA1EncodedDataWithKey:key];
}

//- (NSString *) base64EncodedString
//{
//    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
//}

- (NSString *)URLEncodedString
{
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding));
}


@end
