//
//  NetTools.m
//  tranb
//
//  Created by  SmallTask on 11-8-24.
//  Copyright 2011年 cmf. All rights reserved.
//

#import "NetTools.h"



@implementation NetTools

+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding 
{
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    int len = (int)[escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}

+(NSString *)URLDEcoding:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

+(NSData*) GetBytesFromImage:(UIImage*)_image;
{
    NSMutableData * newPacket = [NSMutableData dataWithCapacity:(1)];
    NSData *tmp = UIImageJPEGRepresentation(_image,JPEGQULITY);
    [newPacket appendData:tmp];
    return newPacket;
}

+(NSData*) GetBytesFromImage:(UIImage*)_image jpegQulity:(CGFloat)_jpegQulity;
{
    NSMutableData * newPacket = [NSMutableData dataWithCapacity:(1)];
    NSData *tmp = UIImageJPEGRepresentation(_image,_jpegQulity);
    [newPacket appendData:tmp];
    return newPacket;
}


/**
 从urlStr中，提取参数为paramName的内容
 如果没有找到，则返回空串
 */
+ (NSString *)paramValueByParamName:(NSString *)paramName urlStr:(NSString *)urlStr {
    if(STR_IS_NIL(urlStr)){
        return @"";
    }
    NSString *urlStrLower = [urlStr lowercaseString];
    NSRange range = [urlStrLower rangeOfString:[paramName lowercaseString]];
    if(range.location == NSNotFound){
        return @"";
    }
    NSString *subStr = [urlStr substringFromIndex:range.location + range.length];
    range = [subStr rangeOfString:@"="];
    if(range.location == NSNotFound){
        return @"";
    }
    subStr = [subStr substringFromIndex:range.location + range.length];
    NSRange rangeEnd = [subStr rangeOfString:@"&"];
    if(rangeEnd.location == NSNotFound){
        return subStr;
    }else{
        subStr = [subStr substringWithRange:NSMakeRange(0, rangeEnd.location)];
        return subStr;
    }
    
}


@end
