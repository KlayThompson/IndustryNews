//
//  SysDirector.m
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "SysDirector.h"
#import "Toast+UIView.h"

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

@end
