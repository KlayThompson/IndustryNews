//
//  BNAPI.m
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BNAPI.h"
#import "NetworkAPIClient.h"
#import "SysTools.h"
#import "SysDirector.h"
#import "NewsListModel.h"
#import "IndustryTreeCmd.h"


@implementation BNAPI

+ (instancetype)sharedManager {
    static BNAPI *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

/**
 调用本方法来解析Mantle,可自动将code，message封装到对象当中；
 优先将data中的内容还原为对像；
 如果data不是NSDictionay，则
 */
+(id)modelOfClass:(Class)class fromJSONDictionary:(NSDictionary *)dict error:(NSError **)error{
    if([dict isKindOfClass:[NSDictionary class]]){
        id data = [dict objectForKey:@"data"];
        BaseCmd *object = nil;
        if([data isKindOfClass:[NSDictionary class]]){
            object = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:data error:error];
        }else if([data isKindOfClass:[NSArray class]]){
            object = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:dict error:error];
        }else if(!data){
            object = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:[NSDictionary dictionary] error:error];
            object.msgData = data;
        }else{
            object = [MTLJSONAdapter modelOfClass:[BaseCmd class] fromJSONDictionary:dict error:error];
            object.msgData = data;
        }
        object.code = [SysTools NumberObj:[dict objectForKey:@"code"]];
        object.message = [SysTools StringObj:[dict objectForKey:@"message"]];
        return object;
    }else{
        BaseCmd *cmd = [[BaseCmd alloc] init];
        if([dict objectForKey:@"code"]){
            cmd.code = [SysTools NumberObj:[dict objectForKey:@"code"]];
        }else{
            cmd.code = @(ERRORCODE_SYS_CLASS_TRANSFORM);
            NSAssert(0, @"警告：服务器端返回的网络消息包装格式不正确！！");
        }
        
        if([dict objectForKey:@"message"]){
            cmd.message = [SysTools StringObj:[dict objectForKey:@"message"]];
        }else{
            cmd.message = @"服务器故障";
        }
        cmd.msgData = [dict objectForKey:@"data"];
        return cmd;
    }
}


#pragma mark - news
/**
 [商业头条]->[新闻]
 新闻详情
 新闻详情
 */
+ (void)news_loadNewsContentWithNewsId:(NSNumber *)newsId
                            industryID:(NSNumber *)inid
                              websitId:(NSNumber *)websitId
                                 Block:(void(^)(BaseCmd *model, NSError *error))block {
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                newsId,@"newsid",
                                inid,@"inid",
                                websitId,@"websitId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/loadNewsContent"
                                                      withParams:parameters
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[NewsDetailModel class] fromJSONDictionary:data error:&error];
                                                                
                                                                block(cmd, nil);
                                                            }
                                                        }];
}

/**
 [商业头条]->[新闻]
 新闻列表-按人脉通行业分页查询
 新闻列表-按人脉通行业分页查询
 */
+ (void)news_loadNewsByRmtIndustryWithPn:(NSNumber *)pn
                                      ps:(NSNumber *)ps
                                 rmtInId:(NSString *)rmtInId
                                   Block:(void(^)(BaseCmd *model, NSError *error))block {
    
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                pn,@"pn",
                                ps,@"ps",
                                rmtInId,@"rmtInId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/loadNewsByRmtIndustry"
                                                      withParams:parameters
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[NewsListModel class] fromJSONDictionary:data error:&error];
                                                                block(cmd, nil);
                                                            }
                                                        }];
    
}

/**
 [商业头条]->[新闻]
 新闻列表-按商情通行业和站点分页查询
 新闻列表-按商情通行业和站点分页查询
 */
+ (void)news_loadNewsBySqtIndustryWithPn:(NSNumber *)pn
                                      ps:(NSNumber *)ps
                                    inid:(NSNumber *)inid
                                webSitId:(NSNumber *)webSitId
                                   Block:(void(^)(BaseCmd *model, NSError *error))block {
    
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                pn,@"pn",
                                ps,@"ps",
                                inid,@"inid",
                                webSitId,@"webSitId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/loadNewsBySqtIndustry"
                                                      withParams:parameters
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[NewsListModel class] fromJSONDictionary:data error:&error];
                                                                block(cmd, nil);
                                                            }
                                                        }];
    
}

/**
 [商业头条]->[新闻]
 人脉通行业分类列表及对应站点
 人脉通行业分类列表及对应站点
 */
+ (void)news_rmtInidListBlock:(void(^)(BaseCmd *model, NSError *error))block {
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/rmtInidList"
                                                      withParams:nil
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[IndustryTreeCmd class] fromJSONDictionary:data error:&error];
                                                                block(cmd, nil);
                                                            }
                                                        }];
}

/**
 [商业头条]->[新闻]
 banner查询-按人脉通行业查询
 banner查询-按人脉通行业查询
 */
+ (void)news_loadTopNewsAticlesWithRmtInId:(NSNumber *)rmtInId
                                     Block:(void(^)(BaseCmd *model, NSError *error))block {
    
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                rmtInId,@"rmtInId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/loadTopNewsAticles"
                                                      withParams:parameters
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[NewsDetailModel class] fromJSONDictionary:data error:&error];
                                                                block(cmd, nil);
                                                            }
                                                        }];
    
}




#pragma mark - sys
/**
 [商业头条]->[新闻]
 事件跟踪/统计
 事件跟踪/统计
 */
+ (void)sys_pushTrackEventWithType:(NSNumber *)type
                              name:(NSNumber *)name
                             value:(NSNumber *)value
                           rmtInId:(NSNumber *)rmtInId
                          websitid:(NSNumber *)websitid
                               ifa:(NSNumber *)ifa
                              imei:(NSNumber *)imei
                          bannerId:(NSNumber *)bannerId
                             Block:(void(^)(BaseCmd *model, NSError *error))block {
    
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                type,@"type",
                                name,@"name",
                                value,@"value",
                                rmtInId,@"rmtInId",
                                websitid,@"websitid",
                                ifa,@"ifa",
                                imei,@"imei",
                                bannerId,@"bannerId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"sys/pushTrackEvent"
                                                      withParams:parameters
                                                  withMethodType:Post
                                                        andBlock:^(id data, NSError *error) {
                                                            if (error) {
                                                                block(nil, error);
                                                            } else {
                                                                BaseCmd *cmd = [[self class] modelOfClass:[NewsDetailModel class] fromJSONDictionary:data error:&error];
                                                                block(cmd, nil);
                                                            }
                                                        }];
    
}
@end
