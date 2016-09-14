//
//  NewsADCmd.m
//  BusinessNews
//
//  Created by liufeng on 16/9/6.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsADCmd.h"

@implementation NewsADCmd

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"industryId": @"inid",@"bannerId":@"id",@"targetUrl":@"url",@"picWidth":@"width",@"picHeight":@"height"};
}

- (CGSize)screenSize {
    if(fabs([self.picHeight floatValue])<0.00001){
        return  CGSizeMake(0, 0);
    }else{
        CGFloat dt = [self.picWidth floatValue]/[self.picHeight floatValue];
        CGFloat cy = WIDTH_SCREEN/dt;
        if(cy<=0){
            cy = 120;
        }
        return CGSizeMake(WIDTH_SCREEN, cy);
    }
    
}
@end
