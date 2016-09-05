//
//  ArticleHtmlCodeTranslate.h
//  ShangQingTong
//
//  Created by 张 寅 on 6/7/12.
//  Copyright (c) 2012 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleHtmlCodeTranslate : NSObject
+(NSString*)getHtmlByString:(NSString*)_str;
+(NSString*)getHtmlByStringContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
+(NSString*)getNoWidthHtmlByStringContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
+(NSString*)getHtmlByStringENContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
+(NSString*)getGroupShareStringViaContent:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
@end
