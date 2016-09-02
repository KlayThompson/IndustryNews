//
//  IndustryCmd.h
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseCmd.h"

@interface IndustryCmd : BaseCmd

@property (nonatomic, strong) NSNumber *industryCode;
@property (nonatomic, strong) NSNumber *industryName;

@property (nonatomic, strong) NSMutableArray *websits;


@end

@interface WebsitesUnit : BaseCmd

@property (nonatomic, strong) NSNumber *websiteId;
@property (nonatomic, strong) NSNumber *industryId;
@property (nonatomic, strong) NSString *websiteLogo;
@property (nonatomic, strong) NSString *websiteName;
@property (nonatomic, strong) NSString *pinyin; //??

@end