//
//  SysDirector.h
//  BusinessNews
//
//  Created by liufeng on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndustryTreeCmd.h"
#import "NewsListUnit.h"

@interface SysDirector : NSObject


@property (nonatomic, strong) NSMutableArray<IndustryCmd*> *currentIndstryTree;
@property (nonatomic, strong) NSMutableArray<IndustryCmd*> *oldIndstryTree;
@property (nonatomic, strong) NSMutableArray<NewsListUnit*> *collectNewsArray;

+(SysDirector*)GetInstance;

+(NSString*)getIDFA;

#pragma mark - Toast
- (void)showToast:(NSString*)title;

- (void)showToastinCenter:(NSString*)title;

- (void)showToastinCenter:(NSString*)title duration:(CGFloat)duration;

- (void)showToastInBottom:(NSString*)title;

@end
