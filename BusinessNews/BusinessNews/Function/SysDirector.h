//
//  SysDirector.h
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysDirector : NSObject

+(SysDirector*)GetInstance;

#pragma mark - Toast
- (void)showToast:(NSString*)title;

- (void)showToastinCenter:(NSString*)title;

- (void)showToastinCenter:(NSString*)title duration:(CGFloat)duration;

- (void)showToastInBottom:(NSString*)title;

@end
