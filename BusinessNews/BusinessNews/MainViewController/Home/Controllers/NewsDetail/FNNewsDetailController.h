//
//  FNNewsDetailController.h
//  FourNews
//
//  Created by admin on 16/3/31.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailModel.h"
#import "NewsListUnit.h"

@interface FNNewsDetailController : UIViewController

@property (nonatomic, strong) NewsDetailModel *detailItem;

@property (nonatomic, strong) NewsListUnit *listItem;


@end
