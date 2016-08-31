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

+ (void)news_loadNewsContentWithNewsId:(NSNumber *)newsId
                            industryID:(NSNumber *)inid
                              websitId:(NSNumber *)websitId
                                 Block:(void(^)(id JSON, NSError *error))block {

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                newsId,@"newsid",
                                inid,@"inid",
                                websitId,@"websitId",
                                nil];
    
    [[NetworkAPIClient sharedJsonClient] requestJsonDataWithPath:@"news/loadNewsContent" withParams:parameters withMethodType:Post andBlock:^(id data, NSError *error) {
        if (error) {
            block(nil, error);
        } else {
//            BaseCmd *cmd = [BNAPI modelOfClass:[BaseCmd class] fromJSONDictionary:data error:&error];
            block(data, nil);
        }
    }];
}

@end
