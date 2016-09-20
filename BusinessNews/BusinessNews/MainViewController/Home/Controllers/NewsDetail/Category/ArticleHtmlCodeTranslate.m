//  将 json 数据转换成 html 数据
//  ArticleHtmlCodeTranslate.m
//  ShangQingTong
//
//  Created by 张 寅 on 6/7/12.
//  Copyright (c) 2012 cmf. All rights reserved.
//
//h1 {font-family:Arial,FZLanTingHeiS-R-GB;
//font-family:FZLanTingHei-DB-GBK
#import "RegexKitLite.h"
#import "ArticleHtmlCodeTranslate.h"
#import "StringTools.h"
#import "Definition.h"
#import "SizeDefinition.h"

@implementation ArticleHtmlCodeTranslate
/**
 *  废弃
 *
 *  @param _str <#_str description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getHtmlByString:(NSString*)_str;
{
    NSMutableString *strReturn=[NSMutableString stringWithCapacity:1];
    [strReturn appendString:@"<style type=\"text/css\">h1 {font-size:10px;color:#666666;text-align: center;} h2{font-size: 18px;text-align: center;} </style>"];
    [strReturn appendString:@"<h2> 标题</h2><h1> 2001-2-1 来源 网易新闻</h1>"];
    NSArray  *listItems = [_str componentsMatchedByRegex:@"\\[img src=.*?\\]"];
    NSInteger lastLocation=0;

    for (int i=0; i<[listItems count]; i++) {
        NSRange rangeCurrentUrl=[_str rangeOfString:[listItems objectAtIndex:i]];
        NSRange rangeCurrentContent=NSMakeRange(lastLocation, rangeCurrentUrl.location-lastLocation);
        [_str substringWithRange:rangeCurrentContent];
        [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",[_str substringWithRange:rangeCurrentContent]]];
        if (rangeCurrentUrl.location!=0) {
            [strReturn appendString:@"<br>"];
        }
        NSString *url=[[listItems objectAtIndex:i] substringWithRange:NSMakeRange(10, rangeCurrentUrl.length-12)];
        SLOG(@"%@",url);
        [strReturn appendString:[NSString stringWithFormat:@"<img style=\"max-width: 300px;height:auto;width:expression(this.width > 300 ? \"300px\" : this.width);\" src='%@' />"
                                 ,url]];
        SLOG(@"%@",[listItems objectAtIndex:i]);
        
        lastLocation=rangeCurrentUrl.length+rangeCurrentUrl.location;
    }
    if (strReturn.length!=0) {
        [strReturn appendString:@"<br>"];
    }
    [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",
                             [_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]]];
    SLOG(@"%@",strReturn);
    return strReturn;
}
/**
 *  通过数据 标题 时间 来源构建 HTML 中文源码 中英文对齐方式不一样
 *
 *  @param _str   数据
 *  @param aTitle 标题
 *  @param aTime  时间
 *  @param aFrom  来源
 *
 *  @return HTMLcode
 */
+(NSString*)getHtmlByStringContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
{
    NSArray *arrayWebSiteName=@[@"techcrunch",@"economist",@"fastcompany",@"techinasia",@"business insider"];
    if ([arrayWebSiteName containsObject:[aFrom TRIM]]) {
        return [[self class] getHtmlByStringENContact:_str title:aTitle time:aTime from:aFrom];
    }
//    NSDictionary *dicDate=[StringTools formatDateAndWeek:aTime byFormat:@"yyyyMMdd" toFormat:@"yyyy/MM/dd"];
//    NSString *time=[dicDate objectForKey:@"date"];
    
    NSTimeInterval interval=[aTime doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM-dd HH:mm"];
    NSString *time = [objDateformat stringFromDate:date];
    
    NSMutableString *strReturn=[NSMutableString stringWithCapacity:1];
    [strReturn appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
    [strReturn appendFormat:@"<style type=\"text/css\">\
     h1 {font-family:Arial;font-size:11px;font-weight:normal;color:#666666;text-align: left;} \
     p{text-align:justify;text-justify:Distribute-all-lines;line-height:25px; font-size: 14px;word-wrap: break-word; white-space: pre-line; } \
     h2{font-size: 19px;text-align: left;font-weight:748;color:#403c3c;} </style><div style=\"width:%fpx;margin: 0 auto;\">",WIDTH_SCREEN-26];
    [strReturn appendFormat:@"<h2>%@</h2><h1>%@ %@ <hr color=#d3d3d3 style=\"border:0.1 solid\" SIZE=0.1/>  </h1>",aTitle,aFrom,time];
    NSArray  *listItems = [_str componentsMatchedByRegex:@"\\[img src=.*?\\]"];
    NSInteger lastLocation=0;
    
    for (int i=0; i<[listItems count]; i++) {
        NSRange rangeCurrentUrl=[_str rangeOfString:[listItems objectAtIndex:i]];
        NSRange rangeCurrentContent=NSMakeRange(lastLocation, rangeCurrentUrl.location-lastLocation);
        [_str substringWithRange:rangeCurrentContent];
        [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",[_str substringWithRange:rangeCurrentContent]]];
        if (rangeCurrentUrl.location!=0) {
            [strReturn appendString:@"<br>"];
        }
        NSString *url=[[listItems objectAtIndex:i] substringWithRange:NSMakeRange(10, rangeCurrentUrl.length-12)];
//        SLOG(@"%@",url);
        [strReturn appendString:[NSString stringWithFormat:@"<a href='pic:%@'>\
                                 <img style=\"max-width: 294px;height:auto;width:expression(this.width > 294 ? \"294px\" : this.width);\" src='%@' />\
                                 </a>"
                                 ,url,url]];
//        SLOG(@"%@",[listItems objectAtIndex:i]);
        
        lastLocation=rangeCurrentUrl.length+rangeCurrentUrl.location;
    }
    if (strReturn.length!=0) {
        [strReturn appendString:@"<br>"];
    }
    [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",
                             [_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]]];
    [strReturn appendString:@"</div>"];
    SLOG(@"%@",strReturn);
    return strReturn;
}
/**
 *  通过数据 标题 时间 来源构建 HTML 英文源码 中英文对齐方式不一样
 *
 *  @param _str   数据
 *  @param aTitle 标题
 *  @param aTime  时间
 *  @param aFrom  来源
 *
 *  @return HTMLcode
 */

+(NSString*)getHtmlByStringENContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
{
    NSDictionary *dicDate=[StringTools formatDateAndWeek:aTime byFormat:@"yyyyMMdd" toFormat:@"yyyy/MM/dd"];
    NSString *time=[dicDate objectForKey:@"date"];
    
    NSMutableString *strReturn=[NSMutableString stringWithCapacity:1];
    [strReturn appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
    [strReturn appendString:@"<style type=\"text/css\">\
     h1 {font-family:Arial;font-size:14px;font-weight:normal;color:#666666;text-align: left;} \
     p{line-height:25px; font-size: 16px;word-wrap: break-word; white-space: pre-line; } \
     h2{font-size: 18px;text-align: left;font-weight:bold;} </style><div style=\"width:294px;margin: 0 auto;\">"];
    [strReturn appendFormat:@"<h2>%@</h2><h1>%@   来源：%@</h1>",aTitle,time,aFrom];
    NSArray  *listItems = [_str componentsMatchedByRegex:@"\\[img src=.*?\\]"];
    NSInteger lastLocation=0;
    
    for (int i=0; i<[listItems count]; i++) {
        NSRange rangeCurrentUrl=[_str rangeOfString:[listItems objectAtIndex:i]];
        NSRange rangeCurrentContent=NSMakeRange(lastLocation, rangeCurrentUrl.location-lastLocation);
        [_str substringWithRange:rangeCurrentContent];
        [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",[_str substringWithRange:rangeCurrentContent]]];
        if (rangeCurrentUrl.location!=0) {
            [strReturn appendString:@"<br>"];
        }
        NSString *url=[[listItems objectAtIndex:i] substringWithRange:NSMakeRange(10, rangeCurrentUrl.length-12)];
        //        SLOG(@"%@",url);
        [strReturn appendString:[NSString stringWithFormat:@"<a href='pic:%@'>\
                                 <img style=\"max-width: 294px;height:auto;width:expression(this.width > 294 ? \"294px\" : this.width);\" src='%@' />\
                                 </a>"
                                 ,url,url]];
        //        SLOG(@"%@",[listItems objectAtIndex:i]);
        
        lastLocation=rangeCurrentUrl.length+rangeCurrentUrl.location;
    }
    if (strReturn.length!=0) {
        [strReturn appendString:@"<br>"];
    }
    [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",
                             [_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]]];
    [strReturn appendString:@"</div>"];
    SLOG(@"%@",strReturn);
    return strReturn;
}
/**
 *  获取群组分享的文案 去除图片 纯文本
 *
 *  @param _str   <#_str description#>
 *  @param aTitle <#aTitle description#>
 *  @param aTime  <#aTime description#>
 *  @param aFrom  <#aFrom description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getGroupShareStringViaContent:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
{
    NSDictionary *dicDate=[StringTools formatDateAndWeek:aTime byFormat:@"yyyyMMdd" toFormat:@"yyyy/MM/dd"];
    NSString *time=[dicDate objectForKey:@"date"];
    
    NSMutableString *strReturn=[NSMutableString stringWithCapacity:1];
    [strReturn appendFormat:@"%@\n%@\n来源：%@\n",aTitle,time,aFrom];
    NSArray  *listItems = [_str componentsMatchedByRegex:@"\\[img src=.*?\\]"];
    NSInteger lastLocation=0;
    for (int i=0; i<[listItems count]; i++) {
        NSRange rangeCurrentUrl=[_str rangeOfString:[listItems objectAtIndex:i]];
        NSRange rangeCurrentContent=NSMakeRange(lastLocation, rangeCurrentUrl.location-lastLocation);
        [strReturn appendString:[_str substringWithRange:rangeCurrentContent]];
//        [_str substringWithRange:rangeCurrentContent];
//        [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",[_str substringWithRange:rangeCurrentContent]]];
//        if (rangeCurrentUrl.location!=0) {
//            [strReturn appendString:@"<br>"];
//        }
//        NSString *url=[[listItems objectAtIndex:i] substringWithRange:NSMakeRange(10, rangeCurrentUrl.length-12)];
//        [strReturn appendString:[NSString stringWithFormat:@"<a href='pic:%@'>\
//                                 <img style=\"max-width: 294px;height:auto;width:expression(this.width > 294 ? \"294px\" : this.width);\" src='%@' />\
//                                 </a>"
//                                 ,url,url]];
        lastLocation=rangeCurrentUrl.length+rangeCurrentUrl.location;
    }
    if (strReturn.length!=0) {
        [strReturn appendString:@"<br>"];
    }
    [strReturn appendString:[_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]];
    
    
//    [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",
//                             [_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]]];
//    [strReturn appendString:@"</div>"];
//    SLOG(@"%@",strReturn);
    return strReturn;
}


/**
	Emali分享 宽度不限制
	@param _str <#_str description#>
	@param aTitle <#aTitle description#>
	@param aTime <#aTime description#>
	@param aFrom <#aFrom description#>
	@returns <#return value description#>
 */
+(NSString*)getNoWidthHtmlByStringContact:(NSString*)_str title:(NSString *)aTitle time:(NSString *)aTime from:(NSString *)aFrom;
{
    NSDictionary *dicDate=[StringTools formatDateAndWeek:aTime byFormat:@"yyyyMMdd" toFormat:@"yyyy/MM/dd"];
    NSString *time=[dicDate objectForKey:@"date"];
    
    NSMutableString *strReturn=[NSMutableString stringWithCapacity:1];
    [strReturn appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
    [strReturn appendString:@"<style type=\"text/css\">\
     h1 {font-family:Arial;font-size:14px;font-weight:normal;color:#666666;text-align: left;} \
     p{text-align:justify;text-justify:Distribute-all-lines;line-height:25px; font-size: 16px;word-wrap: break-word; white-space: pre-line; } \
     h2{font-size: 18px;text-align: left;font-weight:bold;} </style><div style=\"width:auto;margin: 0 auto;\">"];
    [strReturn appendFormat:@"<h2>%@</h2><h1>%@   来源：%@</h1>",aTitle,time,aFrom];
    NSArray  *listItems = [_str componentsMatchedByRegex:@"\\[img src=.*?\\]"];
    NSInteger lastLocation=0;
    
    for (int i=0; i<[listItems count]; i++) {
        NSRange rangeCurrentUrl=[_str rangeOfString:[listItems objectAtIndex:i]];
        NSRange rangeCurrentContent=NSMakeRange(lastLocation, rangeCurrentUrl.location-lastLocation);
        [_str substringWithRange:rangeCurrentContent];
        [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",[_str substringWithRange:rangeCurrentContent]]];
        if (rangeCurrentUrl.location!=0) {
            [strReturn appendString:@"<br>"];
        }
        NSString *url=[[listItems objectAtIndex:i] substringWithRange:NSMakeRange(10, rangeCurrentUrl.length-12)];
        //        SLOG(@"%@",url);
        [strReturn appendString:[NSString stringWithFormat:@"<a href='pic:%@'>\
                                 <img style=\"max-width: auto;height:auto;width:730px;\" src='%@' />\
                                 </a>"
                                 ,url,url]];
        //        SLOG(@"%@",[listItems objectAtIndex:i]);
        
        lastLocation=rangeCurrentUrl.length+rangeCurrentUrl.location;
    }
    if (strReturn.length!=0) {
        [strReturn appendString:@"<br>"];
    }
    [strReturn appendString:[NSString stringWithFormat:@"<p>%@</p>",
                             [_str substringWithRange:NSMakeRange(lastLocation, [_str length]-lastLocation)]]];
    [strReturn appendString:@"</div>"];
    [strReturn appendString:[NSString stringWithFormat:@"\
                             <div style=\"font-size: 12px; width:730px; text-align: left; padding: 10px; line-height: 25px; background: #fff; font-family: '微软雅黑', Arial, 'Courier New';\">\
                             <p style=\"padding:10px 0 10px 0; margin: 10px 0 0 0; border-top: 1px solid #dadada;\">久通网 · 旗下产品</p>\
                             <div style=\"float: left; width: 300px;\">\
                             <img src=\"http://api.9tong.com/assets/images/ic_rmt.png\" style=\"float: left;\" />\
                             <div style=\"margin-left: 100px;\">\
                             <p style=\"padding: 0; margin: 0; font-weight: bold;\">人脉通</p>\
                             <p style=\"padding: 0; margin: 0;\">实现人脉的价值</p>\
                             <p style=\"padding: 0; margin: 5px 0 0 0;\">\
                             <a href=\"%@\" style=\"background: #848484; padding: 5px 8px; border-radius: 5px; color: #fff; text-decoration: none;\">免费下载</a>\
                             </p>\
                             </div>\
                             </div>\
                             <div style=\"float: left; width: 400px;\">\
                             <img src=\"http://api.9tong.com/assets/images/ic_news.png\" style=\"float: left;\"/>\
                             <div style=\"margin-left: 100px;\">\
                             <p style=\"padding: 0; margin: 0; font-weight: bold;\">商情通</p>\
                             <p style=\"padding: 0; margin: 0;\">商业资讯的聚合</p>\
                             <p style=\"padding: 0; margin: 5px 0 0 0;\">\
                             <a href=\"http://www.9tong.com/sqt_down.jsp\" style=\"background: #848484; padding: 5px 8px; border-radius: 5px; color: #fff; text-decoration: none;\">IOS免费下载</a>\
                             &nbsp;<a href=\"http://api.9tong.com/news_9tong.apk\" style=\"background: #848484; padding: 5px 8px; border-radius: 5px; color: #fff; text-decoration: none;\">Andriod免费下载</a>\
                             </p>\
                             </div>\
                             </div>\
                             </div>\
                             <br><br><br>",[StringTools GetShareURLStringWithShareType:shareLinkTypeSQT channel:shareLinkChannelMail]]];
    SLOG(@"%@",strReturn);
    
    return strReturn;
    
}

@end
