//
//  IndustryCmd.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryCmd.h"

@implementation IndustryCmd

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"industryCode":@"code",
             @"industryName":@"name"};
}

+ (NSValueTransformer *)websitsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[WebsitesUnit class]];
}

@end

@implementation WebsitesUnit

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"websiteId":@"id",
             @"websiteName":@"name",
             @"websiteLogo":@"logo"};
}

@end