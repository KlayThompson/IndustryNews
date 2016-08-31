//
//  BNAPI.h
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCmd.h"

@interface BNAPI : NSObject

+ (instancetype)sharedManager;

+ (void)news_loadNewsContentWithNewsId:(NSNumber *)newsId
                            industryID:(NSNumber *)inid
                              websitId:(NSNumber *)websitId
                                 Block:(void(^)(id JSON, NSError *error))block;

@end
