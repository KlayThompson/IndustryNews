//
//  TTShareHelper.h
//  BusinessNews
//
//  Created by KlayThompson on 16/9/7.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "NewsDetailModel.h"
#import "BaseViewController.h"

@interface TTShareHelper : NSObject

+ (TTShareHelper *)shareHelper;

- (void)shareArticleWith:(NewsDetailModel *)model
              industryId:(NSNumber *)industryId
               shareType:(NSString *)type
   currentViewController:(BaseViewController *)currentVC;

@end
