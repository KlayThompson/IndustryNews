//
//  NSData+WBEncode.h
//  tranb
//
//  Created by yanchoujie on 8/3/2015.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WBEncode)

- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
//- (NSString *)base64EncodedString;

@end
