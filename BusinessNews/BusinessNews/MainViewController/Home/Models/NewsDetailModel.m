//
//  NewsDetailModel.m
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"newsId": @"id",
             @"isTop":@"isTop",
             @"content":@"content",
             @"articleName":@"articleName",
             @"imagePic": @"pic",
             @"sourceUrl":@"url",
             @"publishTime":@"publishTime",
             @"contentId":@"contentId",
             @"websitId":@"websitId"};
}
@end
