//
//  SysInfo.m
//  BusinessNews
//
//  Created by KlayThompson on 16/8/28.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "SysInfo.h"

@implementation SysInfo

+(NSError*)getErrorDescriptionViaErrorCode:(NSInteger)aErrorCode;
{
    if (aErrorCode==1080100) {
        return [NSError errorWithDomain:NSLocalizedString(@"超过用户的商品最大拥有数", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1080400)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数不正确", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1080401)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"超过最大上传数", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1080300)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数不正确", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1080301)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数不正确", @"") code:aErrorCode userInfo:nil];
    }else if (aErrorCode==1090100)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数不正确", @"") code:aErrorCode userInfo:nil];
    }else if (aErrorCode==1015200)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"名片文件不能为空", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1015201)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"申请改名，但中文名不能为空", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090001)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数未通过验证", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090002)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"无权操作", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090003)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"超过最大数", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090004)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"群组不存在", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090005)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"活动不存在", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090006)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"话题不存在", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090007)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"已过期", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090008)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"已加入或已申请", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090009)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"你经是管理员，请勿重复申请", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090010)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"邮箱格式错误", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1090011)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"手机格式错误", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1010001)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"必须输入正确的邮箱！", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1010002)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"你的手机或邮箱已被绑定，请重新输入。", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1010003)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"动态不存在", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1100001)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数未通过验证", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1100002)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"请填写公司邮箱，不支持第三方公共邮箱进行认证", @"") code:aErrorCode userInfo:nil];
    }
    //    else if(aErrorCode==1100003)
    //    {
    ////        return [NSError errorWithDomain:NSLocalizedString(@"已经验证过", @"") code:aErrorCode userInfo:nil];
    //        return nil;
    //    }
    else if(aErrorCode==1100004)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"链接有误", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1120001)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数未通过验证", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1020001)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"参数未通过验证", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1020002)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"同步失败，请重新授权", @"") code:aErrorCode userInfo:nil];
    }
    else if(aErrorCode==1100005){
        /*
         1100005：
         表示该邮箱已经被其他用户使用申请过
         只要其他用户使用这个邮箱进行公司认证，而且邮箱已经激活了，就会出现这个编码
         就不允许别人再拿这个邮箱去申请了
         */
        //        return [NSError errorWithDomain:NSLocalizedString(@"该邮箱已经被使用过", @"") code:aErrorCode userInfo:nil];
        return  nil;
    }else if (aErrorCode==0)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"未定义", @"") code:aErrorCode userInfo:nil];
    }
    else if (aErrorCode==1)
    {
        return [NSError errorWithDomain:NSLocalizedString(@"操作失败", @"") code:aErrorCode userInfo:nil];
    }
    else
        return nil;
}

@end
