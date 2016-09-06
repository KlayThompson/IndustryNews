//
//  NewsDetailViewController.h
//  BusinessNews
//
//  Created by KlayThompson on 16/9/5.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsDetailModel.h"

@interface NewsDetailViewController : BaseViewController


- (instancetype)initWithNewsDetailModel:(NewsDetailModel *)model newsListUnit:(NewsListUnit *)unit;

@end
