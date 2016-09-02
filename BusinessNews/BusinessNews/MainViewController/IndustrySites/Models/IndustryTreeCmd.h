//
//  IndustryCmd.h
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseCmd.h"
#import "IndustryCmd.h"

@interface IndustryTreeCmd : BaseCmd

@property (nonatomic, strong) NSMutableArray<IndustryCmd*> *industryTree;

@end
