//
//  NewsListModel.h
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//


#import "NewsListUnit.h"
#import "Mantle.h"
#import "BaseCmd.h"

@interface NewsListModel : BaseCmd<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *industryId;         
@property (nonatomic, strong) NSMutableArray<NewsListUnit*> *newsList;


@end