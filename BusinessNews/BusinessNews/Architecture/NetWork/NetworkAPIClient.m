//
//  NetworkAPIClient.m
//  vdangkou
//
//  Created by 耿功发 on 15/3/9.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import "NetworkAPIClient.h"
#import "NSString+EmojiExtension.h"
#import "Publish_Definition.h"
#import "SysDirector.h"

@implementation NetworkAPIClient

+ (NetworkAPIClient *)sharedJsonClient {
    static NetworkAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetworkAPIClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_PATH]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",nil];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block{
    
    if([aPath rangeOfString:@"?"].location == NSNotFound){
        //m=1:表示iOS客户端
        aPath = [NSString stringWithFormat:@"%@?v=%@&m=1&ifa=%@&from=",aPath,kVersion_BNT,[SysDirector getIDFA]];
    }else{
        aPath = [NSString stringWithFormat:@"%@&v=%@&m=1&from=",aPath,kVersion_BNT];
    }
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //过滤 emoji表情
    NSMutableDictionary *parametersWithoutEmoji=[NSMutableDictionary dictionaryWithCapacity:1];
    for (NSString *key in [params allKeys]) {
        if ([params objectForKey:key]&&[[params objectForKey:key] isKindOfClass:[NSString class]]) {
            [parametersWithoutEmoji setObject:[[params objectForKey:key] removeEmoji] forKey:key];
        }
        else
        {
            [parametersWithoutEmoji setObject:[params objectForKey:key] forKey:key];
        }
    }
    
//    NSString *token = [[MyAccountManager sharedManager] getToken];
//    if (token && ![token isEqualToString:@""]) {
//        [parametersWithoutEmoji setObject:token forKey:@"token"];
//    }
    //添加版本号
    
    
    if(DEBUG_VERSION){
        //打印请求内容，使用GET方式打印，便于在浏览器中调试或发给server端同学调试
        NSMutableString *paraStr = [NSMutableString stringWithString:@"&"];
        if([parametersWithoutEmoji isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = (NSDictionary*)parametersWithoutEmoji;
            for(NSString *keystr in dict){
                [paraStr appendFormat:@"%@=%@&",keystr,[parametersWithoutEmoji objectForKey:keystr]];
            }
        }
        SLOG(@"\n>>>\n%@%@\n",[[NSURL URLWithString:aPath relativeToURL:self.baseURL] absoluteString]  ,paraStr);
    }
    
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            
            [self GET:aPath parameters:parametersWithoutEmoji progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SLOG(@"\n[Resp]:\n%@:\n", responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                SLOG(@"\n[Resp Error]:\n%@", error);
                block(nil, error);
            }];
            
            break;}
        case Post:{
            
            [self POST:aPath parameters:parametersWithoutEmoji progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SLOG(@"\n[获取的数据]:\n%@ \n", responseObject);
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                SLOG(@"\n[Resp Error]:\n%@", error);
                block(nil, error);
            }];
            
            break;}
        case Put:{
            [self PUT:aPath parameters:parametersWithoutEmoji success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SLOG(@"\n[Resp]:\n%@:\n", responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                SLOG(@"\n[Resp Error]:\n%@", error);
                block(nil, error);
            }];
            
            break;}
        case Delete:{
            [self DELETE:aPath parameters:parametersWithoutEmoji success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SLOG(@"\n[Resp]:\n%@:\n", responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                SLOG(@"\n[Resp Error]:\n%@", error);
                block(nil, error);
            }];
            
            break;}
        default:
            break;
    }
}

- (void)downloadDataWithFullPath:(NSString *)aPath
                       andBlock:(void (^)(id data, NSError *error))block{
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    SLOG(@"%@",aPath);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue setMaxConcurrentOperationCount:6];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:20];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"application/octet-stream"];
    

    
    NSURL *urlString = [NSURL URLWithString:aPath];
    [manager GET:urlString.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SLOG(@"JSON:%@",responseObject);
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SLOG(@"Error:%@",error);
        block(nil, error);
    }];

    
    
}


@end
