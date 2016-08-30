//
//  StringTools.h
//  tranb
//
//  Created by  SmallTask on 11-9-12.
//  Copyright 2011年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Definition.h"


typedef enum
{
    shareLinkTypeInvite,
    shareLinkTypeSDR,
    shareLinkTypeRMT,
    shareLinkTypeCardInvite,
    shareLinkTypeCardShare,
    shareLinkTypeSQT,
    shareLinkTypeUserProfile,
    shareLinkTypeGroupTopic,
    shareLinkTypeMeeting,
    shareLinkTypeProduct,
    shareLinkTypeQRCode,
    shareLinkTypeStatus
    
}shareLinkType;
typedef enum
{
    shareLinkChannelAddressBook,
    shareLinkChannelWeibo,
    shareLinkChannelLinkedIn,
    shareLinkChannelQQ,
    shareLinkChannelWechatSession,
    shareLinkChannelWechatTimeline,
    shareLinkChannelMail,
    shareLinkChannelGroup
}shareLinkChannel;
@interface StringTools : NSObject {
    
}

+(NSString*)praseIconString:(NSString*)_msgstr;

//把基于GMT的时间转换为用户当地所在的时间的字符串；格式为：yyyy-MM-dd HH:mm:ss
+(NSString*)ConvertTimeToLocalTime:(NSString*)_sourceTime;

+(NSString*)FommatSqlParam:(NSString*)_paramStr;



#pragma mark - 日期&时间处理
+(NSInteger)GetCurrentYear;

+(NSInteger)GetCurrentMonth;

+(NSInteger)GetCurrentDay;

+(NSInteger)GetYear:(NSDate*)_date;

+(NSInteger)GetMonth:(NSDate*)_date;

+(NSInteger)GetDay:(NSDate*)_date;

+(NSString*)FormatPhone:(NSString*)_phone;

+(BOOL)checkStringLegal:(NSString*)aString;
+(BOOL)checkStringLegalEn:(NSString*)aString;

+ (NSString *)intervalSinceNow: (NSTimeInterval) late;

+ (NSString *)intervalSinceNowForLBS: (NSTimeInterval) late;
+ (NSString *)intervalSinceNowWithDateString: (NSString *) dateString formate:(NSString*)aFormate;
+ (NSString *)intervalWithDateString: (NSString *) dateString formate:(NSString*)aFormate;
+  (int)charNumber:(NSString*)strtemp;

+(NSString*)EnImg:(NSString*)_imgFileName;

///删除服务器端不能识别的单词
+(NSString*)RemoveBadWordForServer:(NSString*)_str;
+(NSString*)timeStateViaState:(NSInteger)aState;


//+(NSString*)GetProductPicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;
//+(NSString*)GetProductMiddlePicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;
//+(NSString*)GetProductSmallPicUrlViaProductId:(NSInteger)aProductId photoId:(NSInteger)aPhotoId uid:(NSInteger)aUid;

+(NSString*)GetProductMiddlePicViaRealUrl:(NSString*)aUrl;
//+(NSString*)GetProductSmallPicViaRealUrl:(NSString*)aUrl;
+(NSString*)GetSQTShareStringViaSocialType:(id)aSocialType;
+ (NSString *)stringTimeViaJavaString: (NSString*)JavaString;



/*对sourceStr进行处理，获取与服务器端通信使用的字符 
  处理内容：
 （1）替换null为nu11
  (2)字符串长度检查，对超出长度的字符串自动截断；
 */
+(NSString*)GetServerString:(NSString*)sourceStr limitLen:(NSInteger)_limitLen;
+(NSString*)stringTimeCurrentTimeInterval;
+(NSString*)stringTimeCurrentTimeIntervalJava;
+(NSString*)replaceStringUnLegal:(NSString*)aString;

/**检查用户输入的是否是手机号码；注册帐号时填写的手机号码，不会有+86这样的形式，但是在编辑个人信息和名片信息时，+86这样的形式是正确的；*/
+(NSString*)getStatusMiddleImageViaRealUrl:(NSString*)url;





#pragma mark - URL

+(NSString*)GetShareURLStringWithShareType:(shareLinkType)type channel:(shareLinkChannel)channel;




//去除浮点型数字后面多余的0
+ (NSString *)getStringFromCGFLoat:(double)aFloatNum;

//sha1加密
+ (NSString*)sha1:(NSString*)input;


//获取dictionary对应的Json
+ (NSString*)getJsonString:(NSDictionary*)jsonDict;

/**检查url前面有没有http://这样的前缀，
 如果没有，自动添加http://并返回；
 如果有，则原样返回
 */
+ (NSString *)autoAppendHttpPrefix:(NSString *)sourceUrl;

#pragma mark - 金额处理
/**
 获取人民币类型的字符串；
 @param source 输入内容： NSNumber 或 NSString类型；
 @param unitName 单位名称，例如：公斤、米、码等；
 
 @return 返回内容：例：￥10,000.00/米
 
 source为nil，则返回@""
 source为NSNumber的情况，按实际数值输入，小数点后保留2位
 source为NSString时，先将source转为NSNumber，然后再转换输出；
 unitName如果是nil或空串，则不显示 / 分隔符
 */
+ (NSString*)getMoneyFomatString:(id)source unitName:(NSString*)unitName;


@end

