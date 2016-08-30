//
//  SysInfo.h
//  BusinessNews
//
//  Created by KlayThompson on 16/8/28.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysInfo : NSObject

+(NSError*)getErrorDescriptionViaErrorCode:(NSInteger)aErrorCode;


@end
