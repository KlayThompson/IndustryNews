//
//  IndustryCmd.m
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryTreeCmd.h"

@implementation IndustryTreeCmd

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return nil;
}

+ (NSValueTransformer *)industryTreeJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[IndustryCmd class]];
}
@end
