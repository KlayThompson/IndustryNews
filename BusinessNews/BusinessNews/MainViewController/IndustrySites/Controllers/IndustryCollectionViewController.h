//
//  IndustryCollectionViewController.h
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseViewController.h"
#import "IndustryTreeCmd.h"

@interface IndustryCollectionViewController : BaseViewController


- (instancetype)initWithIndustryCmd:(IndustryCmd *)industryCmd industryName:(NSString *)name;

@end
