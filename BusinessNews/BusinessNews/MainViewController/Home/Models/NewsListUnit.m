//
//  NewsLsitCmd.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsListUnit.h"

@implementation NewsListUnit

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"newsId": @"id",
             @"viewCount":@"hits",
             @"websitId":@"webSitId",
             @"contentId": @"contentid",
             @"imagePic":@"pic",
             @"industryId":@"inId"};
}

- (NSString *)getSmallImagePicString {
    if (!STR_IS_NIL(self.imagePic)) {
        NSString *newString = [NSString stringWithFormat:@"%@?imageView2/1/w/125/h/105",self.imagePic];
        return newString;
    }
    return @"";
}
@end
