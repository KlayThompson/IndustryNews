//
//  BNAPI.h
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCmd.h"
#import "NewsDetailModel.h"

@interface BNAPI : NSObject

+ (instancetype)sharedManager;


#pragma mark - news
/**
 [商业头条]->[新闻]
 新闻详情
 新闻详情
 */
+ (void)news_loadNewsContentWithNewsId:(NSNumber *)newsId
                            industryID:(NSNumber *)inid
                              websitId:(NSNumber *)websitId
                                 Block:(void(^)(BaseCmd *model, NSError *error))block;

/**
 [商业头条]->[新闻]
 新闻列表-按人脉通行业分页查询
 新闻列表-按人脉通行业分页查询
 */
+ (void)news_loadNewsByRmtIndustryWithPn:(NSNumber *)pn
                                      ps:(NSNumber *)ps
                                 rmtInId:(NSString *)rmtInId
                                   Block:(void(^)(BaseCmd *model, NSError *error))block;

/**
 [商业头条]->[新闻]
 新闻列表-按商情通行业和站点分页查询
 新闻列表-按商情通行业和站点分页查询
 */
+ (void)news_loadNewsBySqtIndustryWithPn:(NSNumber *)pn
                                      ps:(NSNumber *)ps
                                    inid:(NSNumber *)inid
                                webSitId:(NSNumber *)webSitId
                                   Block:(void(^)(BaseCmd *model, NSError *error))block;

/**
 [商业头条]->[新闻]
 人脉通行业分类列表及对应站点
 人脉通行业分类列表及对应站点
 */
+ (void)news_rmtInidListBlock:(void(^)(BaseCmd *model, NSError *error))block;

/**
 [商业头条]->[新闻]
 banner查询-按人脉通行业查询
 banner查询-按人脉通行业查询
 */
+ (void)news_loadTopNewsAticlesWithRmtInId:(NSString *)rmtInId
                                     Block:(void(^)(BaseCmd *model, NSError *error))block;


#pragma mark - sys
/**
 [商业头条]->[新闻]
 事件跟踪/统计
 事件跟踪/统计
 */
+ (void)sys_pushTrackEventWithType:(NSString *)type
                              name:(NSString *)name
                             value:(NSNumber *)value
                           rmtInId:(NSNumber *)rmtInId
                          websitid:(NSNumber *)websitid
                              imei:(NSNumber *)imei
                          bannerId:(NSNumber *)bannerId
                             Block:(void(^)(BaseCmd *model, NSError *error))block;
@end
