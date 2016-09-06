//
//  NewsADModel.m
//  BusinessNews
//
//  Created by liufeng on 16/9/6.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsADModel.h"

@implementation NewsADModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"newsADList":@"links"};
}

+ (NSValueTransformer *)newsADListJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NewsADCmd class]];
}

@end
