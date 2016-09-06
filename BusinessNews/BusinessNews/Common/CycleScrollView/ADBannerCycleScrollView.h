//
//  ADBannerCycleScrollView.h
//  tranb
//
//  Created by liufeng on 16/8/23.
//  Copyright © 2016年 cmf. All rights reserved.
//  广告banner 用来记录第一次进入的每一帧广告banner，然后保存到服务端

#import "CycleScrollView.h"

@interface ADBannerCycleScrollView : CycleScrollView

/**
 当每一帧广告第一次出现的时候调用（不包含第一帧，第一帧只要调用就会出现）
 **/
@property (nonatomic , copy) void (^SaveAdShowLogBlock)(NSInteger pageIndex);

@end
