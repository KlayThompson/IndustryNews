//
//  NewsADModel.h
//  BusinessNews
//
//  Created by liufeng on 16/9/6.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseCmd.h"
#import "NewsADCmd.h"

@interface NewsADModel : BaseCmd

@property (nonatomic, strong) NSMutableArray<NewsADCmd *> *newsADList;

@end
