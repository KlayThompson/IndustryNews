//
//  SysTools.m
//  tranb
//
//  Created by SmallTask on 12-6-5.
//  Copyright (c) 2012年 cmf. All rights reserved.
//

#import "SysTools.h"
//#import "tranbAppDelegate.h"
#import <EventKit/EventKit.h>
#import "JSONObjectUtil.h"


@implementation SysTools




#pragma mark
+(void)ShowNetWorkError:(id)_delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(TIP_NETWORK_ERROR, @"")
                                                    delegate:_delegate cancelButtonTitle:NSLocalizedString(@"确定", @"")otherButtonTitles: nil];
    [alert show];
}
+(BOOL)isUseNormalChannelWithPercent:(NSInteger)percent;
{
    NSTimeInterval timeSince1970=[[NSDate date] timeIntervalSince1970];
    long long int time1=timeSince1970*100000;
    NSInteger time=time1%100;
//    NSLog(@"___%lld___%d____%f",time1,time,timeSince1970);
    if (time<percent) {
        return YES;
    }
    return NO;
}

//返回单位：毫秒
+(long long int)GetCurrentTimeNumber;
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]; 
    long long int uu = time*1000;//＊1000是为了与服务器端的格式一致；
//    SLOG(@"SysTools.GetCurrentTimeNumber,time:%lli",uu);
    return uu;
}

+(void)TerminateApp;
{   
//    这两种是私有的，不能通过app store.
//    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];   
//    exit(0);  
    //让项目crash.
    NSArray *a = [NSArray new];
    id b = [a objectAtIndex:100];
    NSLog(@"%@",b);
}

+(BOOL)IsIPadStyleUI;
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    else 
        return NO;
}

+(BOOL)IsIphoneStyleUI;
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        return YES;
    else
        return NO;
}

+(BOOL)IsIPad;
{
    return [[[UIDevice currentDevice] model] isEqualToString:@"iPad"];
}


+(BOOL)IsSurportCamera;
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

-(bool)checkDevice:(NSString*)name  
{  
    NSString* deviceType = [UIDevice currentDevice].model;  
    SLOG(@"deviceType = %@", deviceType);  
    
    NSRange range = [deviceType rangeOfString:name];  
    return range.location != NSNotFound;  
} 

+(NSString*)GetUserPhoneNumber;
{
    return @"";
    //return [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
}

+(NSString*)GetCurrentSysLanguage;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"]; 
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

#pragma mark -
/**
 
 判断ipad/iphone
 UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
 UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
 
 或者
 [[[UIDevice currentDevice] model] isEqualToString:@"iPad"];
 
 判断设备是否有摄像头
 [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
 
 */

+(NSString*)LogFrame:(CGRect)_frame;
{
    return [NSString stringWithFormat:@"(%f,%f)<w:%f,h:%f>",_frame.origin.x,_frame.origin.y,_frame.size.width,_frame.size.height];
}

+(NSString*)LogFontSize:(UIFont*)_font;
{
    return [NSString stringWithFormat:@"pointSize:%f,ascender:%f,descender:%f,capHeight:%f,xHeight:%f,lineHeight:%f",
            _font.pointSize,
            _font.ascender,
            _font.descender,
            _font.capHeight,
            _font.xHeight,
            _font.lineHeight];
    
}

//在控制台上打印调试信息；
+(void)LogDebugInfo:(NSString*)_log,...;
{
    long long int currentTime = [SysTools GetCurrentTimeNumber];
    NSLog(@"%lli:[%s]: %@",currentTime,__func__,_log);
}

#pragma mark -

+(void)MakeLableRightAlignment:(UILabel*)_lable;
{
    CGRect oldFrame = _lable.frame;
    _lable.textAlignment = NSTextAlignmentRight;
    _lable.numberOfLines = 0;
    [_lable sizeToFit];
    CGRect frame = _lable.frame;
    frame.size.width = oldFrame.size.width;
    _lable.frame = frame;
}







+(float)getTotalDiskSpaceInBytes 
{   
    float totalSpace = 0.0f;   
    NSError *error = nil;   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);   
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];   
    
    if (dictionary) {   
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        
        totalSpace = [fileSystemSizeInBytes floatValue];   
    } else {   
        SLOG(@"Error Obtaining File System Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalSpace;   
}  

+(float)getFreeDiskSpaceInBytes 
{   
    float totalSpace = 0.0f;   
    NSError *error = nil;   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);   
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];   
    
    if (dictionary) {   
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes floatValue];
    } else {   
        SLOG(@"Error Obtaining File System Info: Domain = %@, Code = %ld",[error domain], (long)[error code]);
    }   
    
    return totalSpace;   
} 


+(BOOL)IsAddressBookEnable;
{
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    NSInteger mainVerId = [[sysVersion substringToIndex:1] intValue];
    if(mainVerId>=6)
    {
        if(ABAddressBookGetAuthorizationStatus()==kABAuthorizationStatusAuthorized
           ||ABAddressBookGetAuthorizationStatus()==kABAuthorizationStatusNotDetermined)
            return YES;
        else
            return NO;
    }else
        return YES;
}


+(BOOL)IsEventKitEventEnable;
{
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    NSInteger mainVerId = [[sysVersion substringToIndex:1] intValue];
    if(mainVerId>=6)
    {
        EKAuthorizationStatus ekAuthStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
        if(ekAuthStatus ==kABAuthorizationStatusAuthorized||
           ekAuthStatus==kABAuthorizationStatusNotDetermined)
            return YES;
        else
            return NO;
    }else
        return YES;
}

#pragma mark - 类型检查及转换

+(NSString*)StringObj:(id)_ob;
{
    if(!_ob)
        return @"";
    else if([_ob isEqual:[NSNull null]])
        return @"";
    else if([_ob isKindOfClass:[NSNumber class]])
        return [_ob stringValue];
    else if([_ob isKindOfClass:[NSString class]])
        return _ob;
    else
        return @"undifined object type";
}

+(NSNumber*)NumberObj:(id)_ob {
    
    return [SysTools NumberObj:_ob defaultValue:@0];
}

+(NSNumber*)NumberObj:(id)_ob defaultValue:(NSNumber *)defaultNumber {
    if(!_ob){
        
        return defaultNumber;
        
    }else if([_ob isEqual:[NSNull null]]){
        
        return defaultNumber;
        
    }else if([_ob isKindOfClass:[NSNumber class]]) {
        
        return _ob;
    
    }else if([_ob isKindOfClass:[NSString class]]) {
        
        NSNumber *num = nil;
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        if ([f numberFromString:_ob]) {
            
            num = [NSNumber numberWithDouble:[_ob doubleValue]];
            
        } else {
            num = defaultNumber;
        }
      
        return num;
    }else
        return defaultNumber;
    
}


+(NSArray*)NSArrayObj:(id)_ob{
    if(!_ob){
        return [NSArray new];
    }else if([_ob isKindOfClass:[NSMutableArray class]]){
        return [NSArray arrayWithArray:_ob];
    }else if([_ob isKindOfClass:[NSArray class]]){
        return _ob;
    }else if([_ob isKindOfClass:[NSString class]]){
        NSString *tmpStr = _ob;
        if([tmpStr isEqualToString:@""]){
            return [NSArray new];
        }else{
            return [NSArray arrayWithObject:_ob];
        }
    }else if([_ob isKindOfClass:[NSNumber class]]){
        return [NSArray arrayWithObject:_ob];
    }else {
        return [NSArray new];
    }
}

+(NSArray*)NSArrayObj:(id)_ob defaultValue:(id)defaultValue{
    if(!_ob){
        return defaultValue;
    }else if([_ob isKindOfClass:[NSMutableArray class]]){
        return [NSArray arrayWithArray:_ob];
    }else if([_ob isKindOfClass:[NSArray class]]){
        return _ob;
    }else if([_ob isKindOfClass:[NSString class]]){
        NSString *tmpStr = _ob;
        if([tmpStr isEqualToString:@""]){
            return defaultValue;
        }else{
            return [NSArray arrayWithObject:_ob];
        }
    }else if([_ob isKindOfClass:[NSNumber class]]){
        return [NSArray arrayWithObject:_ob];
    }else {
        return defaultValue;
    }
}

+(NSMutableArray*)NSMutableArrayObj:(id)_ob;
{
    if(!_ob){
        
        return [NSMutableArray new];
        
    }else if([_ob isKindOfClass:[NSMutableArray class]]){
        
        return _ob;
        
    }else if([_ob isKindOfClass:[NSArray class]]){
        
        return [_ob mutableCopy];
        
    }else if([_ob isKindOfClass:[NSString class]]){
        
        NSString *tmpStr = _ob;
        if([tmpStr isEqualToString:@""]){
            return [NSMutableArray new];
        }else{
            return [NSMutableArray arrayWithObject:_ob];
        }
        
    }else if([_ob isKindOfClass:[NSNumber class]]){
        
        return [NSMutableArray arrayWithObject:_ob];
        
    }else {
        
        return [NSMutableArray new];
        
    }

}

+(NSDictionary*)NSDictionaryObj:(id)_ob
{
    if(!_ob){
        
        return [NSDictionary new];
        
    }else if([_ob isKindOfClass:[NSDictionary class]]){
        
        return _ob;
        
    }else if([_ob isKindOfClass:[NSMutableDictionary class]]){
        
        return _ob;
        
    }else if([_ob isKindOfClass:[NSString class]] || [_ob isKindOfClass:[NSMutableString class]]){
        
        return [JSONObjectUtil dictFromString:_ob]?:[NSDictionary new];
        
    }
    else {
        
        return [NSDictionary new];
        
    }
    
}



#pragma mark

+(BOOL)isPhoneShowWithPrivacySetting:(NSInteger)privacySetting;
{
    if ((((privacySetting>>1)%2)==0)) {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isMailShowWithPrivacySetting:(NSInteger)privacySetting;
{
    if ((((privacySetting>>0)%2)==0)) {
        return YES;
    }
    else
    {
        return NO;
    }
}
//+(UIImageView*)lineImageViewWithFrame:(CGRect)frame;
//{
//    UIImage *imgCellline = [UIImage imageNamed:NSLocalizedString(@"list_line.png",@"")];
//    imgCellline = [imgCellline stretchableImageWithLeftCapWidth:4.0f topCapHeight:0];
//    
//    UIImageView* imageViewCellline = [[UIImageView alloc] initWithImage:imgCellline];
//    imageViewCellline.frame = frame;
//    return imageViewCellline;
//}

+ (UIImage *)imageViaColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage*)imageBlackToTransparent:(UIImage*) image r:(NSInteger)color_r g:(NSInteger)color_g b:(NSInteger)color_b;
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        else
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = color_r; //0~255
            ptr[2] = color_g;
            ptr[1] = color_b;
            
        }
        
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}

void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}


//获取当前ios版本的推送类型，用于判断推送功能是否打开等；
+(UIRemoteNotificationType) GetRemoteNotificationType;
{
    UIRemoteNotificationType types;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
    }
    else
    {
        types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    return types;
}

//生成一个全局唯一的随机数
+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
    
}



+(id)createViewFromXib:(NSString*)xibName
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil];
    
    id uv = [nib objectAtIndex:0];
    return uv;
}

#pragma mark - 调用设备能力


@end
