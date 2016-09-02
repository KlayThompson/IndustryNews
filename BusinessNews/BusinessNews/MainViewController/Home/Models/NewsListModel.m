//
//  NewsListModel.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsListModel.h"
#import "NewsListUnit.h"

@implementation NewsListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"newsList":@"links"};
}

+ (NSValueTransformer *)newsListJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NewsListUnit class]];
}


@end
