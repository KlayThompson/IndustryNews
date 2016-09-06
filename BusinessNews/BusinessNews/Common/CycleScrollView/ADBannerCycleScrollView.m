//
//  ADBannerCycleScrollView.m
//  tranb
//
//  Created by liufeng on 16/8/23.
//  Copyright © 2016年 cmf. All rights reserved.
//  广告banner 用来记录第一次进入的每一帧广告banner，然后保存到服务端

#import "ADBannerCycleScrollView.h"

@interface ADBannerCycleScrollView()

@property (nonatomic , strong) NSMutableDictionary *pageIndexDictonary;

@end

@implementation ADBannerCycleScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        _pageIndexDictonary = [NSMutableDictionary new];
    }
    
    return self;
}

- (void) firstTimeShowAd:(NSInteger)pageIndex {

    NSString *key = [NSString stringWithFormat:@"%ld", (long)pageIndex];
    
    if ([self.pageIndexDictonary objectForKey:key]) {
        
    } else {
        if ([key isEqualToString:@"0"]) {
            
        } else {
            [self.pageIndexDictonary setValue:key forKey:key];
            if (self.SaveAdShowLogBlock) {
                self.SaveAdShowLogBlock(pageIndex);
            }
        }
    }
}

@end
