//
//  SysTools.h
//  tranb
//
//  Created by SmallTask on 12-6-5.
//  Copyright (c) 2012年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"
#import <UIKit/UIKit.h>

#define SSLOG(_log,...) NSLog(@"%s: %@",__func__,_log);

#define NSArrayObj(a) [SysTools NSArrayObj:a]
#define MutableArrayObj(a) [SysTools NSMutableArrayObj:a]
#define StringObj(a) [SysTools StringObj:a]

//如果number 为 nil，默认用0来填充
#define NumberObj(a) [SysTools NumberObj:a]
#define NumberObjWithDefault(a,b) [SysTools NumberObj:a defaultValue:b]
#define NSDictionaryObj(a) [SysTools NSDictionaryObj:a]

@interface SysTools : NSObject


#pragma mark -

+(void)ShowNetWorkError:(id)_delegate;
+(BOOL)isUseNormalChannelWithPercent:(NSInteger)percent;
+(long long int)GetCurrentTimeNumber;

+(void)TerminateApp;

+(BOOL)IsIPadStyleUI;

+(BOOL)IsIphoneStyleUI;

+(BOOL)IsSurportCamera;

+(BOOL)IsIPad;

+(NSString*)GetUserPhoneNumber;

+(NSString*)GetCurrentSysLanguage;

+(NSString*)LogFrame:(CGRect)_frame;

+(NSString*)LogFontSize:(UIFont*)_font;

//在控制台上打印调试信息；
+(void)LogDebugInfo:(NSString*)_log,...;

+(void)MakeLableRightAlignment:(UILabel*)_lable;

+(float)getTotalDiskSpaceInBytes;

+(float)getFreeDiskSpaceInBytes;

+(BOOL)IsAddressBookEnable;

+(BOOL)IsEventKitEventEnable;

#pragma mark - 类型检查及转换

+(NSString*)StringObj:(id)_ob;

+(NSNumber*)NumberObj:(id)_ob;

+(NSNumber*)NumberObj:(id)_ob defaultValue:(NSNumber *)defaultNumber;

+(NSArray*)NSArrayObj:(id)_ob;
+(NSArray<id>*)NSArrayObj:(id)_ob defaultValue:(id)defaultValue;

+(NSMutableArray*)NSMutableArrayObj:(id)_ob;

+(NSDictionary*)NSDictionaryObj:(id)_ob;

#pragma mark

+(BOOL)isPhoneShowWithPrivacySetting:(NSInteger)privacySetting;

+(BOOL)isMailShowWithPrivacySetting:(NSInteger)privacySetting;

//+(UIImageView*)lineImageViewWithFrame:(CGRect)frame;


+ (UIImage *)imageViaColor:(UIColor *)color;

+ (UIImage*) imageBlackToTransparent:(UIImage*) image r:(NSInteger)color_r g:(NSInteger)color_g b:(NSInteger)color_b;



//获取当前ios版本的推送类型，用于判断推送功能是否打开等；
+(UIRemoteNotificationType) GetRemoteNotificationType;


//通过xibname来装载一个 View
+(id)createViewFromXib:(NSString*)xibName;

//生成一个全局唯一的随机数
+ (NSString *)getUniqueStrByUUID;





@end
