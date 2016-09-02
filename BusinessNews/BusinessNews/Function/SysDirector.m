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
        [self loadIndustryCodeFromServer];
    }
    return self;
}

#pragma mark - IDFA
+ (NSString*)getIDFA{
    // V1.680审核被拒
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

- (void)loadIndustryCodeFromServer {
    
    __weak typeof (self) weakSelf = self;
    [BNAPI news_rmtInidListBlock:^(BaseCmd *model, NSError *error) {
        [model errorCheckSuccess:^{
            
            if ([model isKindOfClass:[IndustryTreeCmd class]]) {
                
                IndustryTreeCmd *cmd = (IndustryTreeCmd *)model;
                weakSelf.currentIndstryTree = cmd.industryTree;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UpdateIndustryCode object:nil];
            }
            
        } failed:^(NSInteger errCode) {
            [[AppDelegate sysDirector] showToastInBottom:[model errorMsg]];
        }];
    }];
}
@end
