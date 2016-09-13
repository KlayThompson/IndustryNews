//
//  SysDirector.m
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "SysDirector.h"
#import "Toast+UIView.h"
#import <AdSupport/ASIdentifierManager.h>
#import "BNAPI.h"
#import "IndustryTreeCmd.h"
#import "AppDelegate.h"
#import "Notification_Definition.h"

#define SaveIndustryCode @"IndustryTree"
#define CollectNewsList @"CollectNewsList"

static SysDirector *instance;

@implementation SysDirector


+ (SysDirector*)GetInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SysDirector alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpAPPData];
    }
    return self;
}

#pragma mark - IDFA
+ (NSString*)getIDFA{
    
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    return idfa ? idfa : @"";
    
    return @"";
}

#pragma mark - Toast
- (void)showToast:(NSString*)title{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window makeToast:title];
}

- (void)showToastinCenter:(NSString*)title{
    [self showToastinCenter:title duration:2.0f];
}

- (void)showToastinCenter:(NSString*)title duration:(CGFloat)duration{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window makeToast:title duration:duration position:@"center"];
}

- (void)showToastInBottom:(NSString*)title{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window makeToast:title duration:2 position:@"bottom"];
}

- (void)setUpAPPData {

    self.collectNewsArray = [NSMutableArray new];
    
    [self loadIndustryCodeFromServer];
}

//启动从服务器获取分类数据
- (void)loadIndustryCodeFromServer {
    
    __weak typeof (self) weakSelf = self;
    [BNAPI news_rmtInidListBlock:^(BaseCmd *model, NSError *error) {
        if (error) {
            [weakSelf showToastInBottom:TIP_NETWORK_ERROR];
            //取出本地缓存使用
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SaveIndustryCode];
            weakSelf.currentIndstryTree = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UpdateIndustryCode object:nil];
            
            NSData *dataCollect = [[NSUserDefaults standardUserDefaults] objectForKey:CollectNewsList];
            weakSelf.collectNewsArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataCollect];
        } else {
            [model errorCheckSuccess:^{
                
                if ([model isKindOfClass:[IndustryTreeCmd class]]) {
                    
                    IndustryTreeCmd *cmd = (IndustryTreeCmd *)model;
                    [weakSelf compareIndustryCodeAndPostToUpdateIndustryCode:cmd.industryTree];
                }
                
            } failed:^(NSInteger errCode) {
                [[AppDelegate sysDirector] showToastInBottom:[model errorMsg]];
            }];
        }
    }];
}

//需求地址https://tower.im/projects/dbe017efd44044619c565f3e38a48ba5/todos/42861e64c88b4c7ea258ca29de7d490b/
- (void)compareIndustryCodeAndPostToUpdateIndustryCode:(NSMutableArray<IndustryCmd*>*)industryTree {

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SaveIndustryCode];
    self.oldIndstryTree = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //判断本地是否有行业数据，没有则存贮，有则比对
    if (self.oldIndstryTree && self.oldIndstryTree.count > 0) {
        
        //1.取出old的所有含有selectCount的行业数据
        //2.判断这些数据在最新的服务端有没有返回，返回则给服务端返回来的赋值selectCount，没返回说明已经删除则不处理
        //3.结束后其他的行业数据的selectCount都是为0，直接按照服务端的顺序显示即可
        
        
        for (int i = 0; i < self.oldIndstryTree.count; i++) {
            IndustryCmd *unit = [self.oldIndstryTree objectAtIndex:i];
            if (unit.selectCount > 0) {
                
                NSInteger industryCode = unit.industryCode.integerValue;
                
                for (int i = 0; i < industryTree.count; i++) {
                    IndustryCmd *cmd = [industryTree objectAtIndex:i];
                    if (cmd.industryCode.integerValue == industryCode) {
                        cmd.selectCount = unit.selectCount;
                    }
                }
                
            } else {
                //do nothing
            }
        }
        
        //根据用户点击次数排序
        [industryTree sortUsingComparator:^NSComparisonResult(id object1, id object2) {
            IndustryCmd *unit1 = (IndustryCmd *)object1;
            IndustryCmd *unit2 = (IndustryCmd *)object2;
            
            NSInteger position1 = unit1.selectCount;
            NSInteger position2 = unit2.selectCount;
            
            if (position1 > position2) {
                return NSOrderedAscending;
            }
            else if (position1 < position2){
                
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
        
    } else {
        //存储到本地
        NSData *tempSubmitOrderCmd = [NSKeyedArchiver archivedDataWithRootObject:industryTree];
        [[NSUserDefaults standardUserDefaults] setObject:tempSubmitOrderCmd forKey:SaveIndustryCode];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (ARRAY_IS_NIL(industryTree)) {
        self.currentIndstryTree = self.oldIndstryTree;
    } else {
        self.currentIndstryTree = industryTree;
    }

    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UpdateIndustryCode object:nil];

    NSData *dataCollect = [[NSUserDefaults standardUserDefaults] objectForKey:CollectNewsList];
    self.collectNewsArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataCollect];
    SLOG(@"");
}

@end
