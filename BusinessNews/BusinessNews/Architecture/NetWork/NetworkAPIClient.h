//
//  NetworkAPIClient.h
//  vdangkou
//
//  Created by 耿功发 on 15/3/9.
//  Copyright (c) 2015年 9tong. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
//#import "MyAccountManager.h"

typedef NS_ENUM(NSInteger, NetworkMethod) {
    Get = 0,
    Post,
    Put,
    Delete
};

@interface NetworkAPIClient : AFHTTPSessionManager

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)downloadDataWithFullPath:(NSString *)aPath
                        andBlock:(void (^)(id data, NSError *error))block;



@end
