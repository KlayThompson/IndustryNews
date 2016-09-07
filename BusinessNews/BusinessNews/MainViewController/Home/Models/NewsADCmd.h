//
//  NewsADCmd.h
//  BusinessNews
//
//  Created by liufeng on 16/9/6.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseCmd.h"

@interface NewsADCmd : BaseCmd

@property (nonatomic, strong) NSNumber *industryId;
@property (nonatomic, strong) NSNumber *newsId;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *webSitId;
@property (nonatomic, strong) NSNumber *type;          //type = 0 为新闻  type = 1 为广告
@property (nonatomic, strong) NSNumber *rmtInid;
@property (nonatomic, strong) NSNumber *bannerId;


@end
