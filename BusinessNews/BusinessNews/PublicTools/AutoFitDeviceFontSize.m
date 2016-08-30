//
//  AutoFitDeviceFontSize.m
//  tranb
//
//  Created by Smalltask on 16/4/18.
//  Copyright © 2016年 cmf. All rights reserved.
//

#import "AutoFitDeviceFontSize.h"
#import "SizeDefinition.h"

@implementation AutoFitDeviceFontSize


#pragma mark - 字体处理相关
/**
 根据当前屏幕宽度及传入的字号，得到最佳的字号的尺寸；处于安全考虑,大于1000的值，会被忽略；
 调用方法：[autoFontSize:13,14,15,nil]
 所有的参数必须为CGFloat类型，必须，不然会出现灵异bug；因为可变参数是直接读内存的。
 13:iPhone5下使用的字号，第一个参数
 14:iPHone6下使用的字号，第二个参数
 15:iPhone6P下使用的字号，第三个参数
 注意：如果省略第3个参数，则在iPhone6p时，返回第2个参数的值；如果第2个参数也被省略，则返回第1个参数的值；
 */
+ (CGFloat)autoFitDeviceFontSize:(CGFloat)fontSize,...{
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,fontSize);//va_start 得到第一个可变参数地址,
    CGFloat arg;
    if (fontSize) {
        //将第一个参数添加到array
        id prev = @(fontSize);
        [argsArray addObject:prev];
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        while( (arg = va_arg(params,double)) )
        {
            if ( arg && arg>0 && arg<1000){
                [argsArray addObject:@(arg)];
            }
        }
        //置空
        va_end(params);
        //这里循环 将看到所有参数
//        for (NSNumber *num in argsArray) {
//            NSLog(@"%zd", [num floatValue]);
//        }
        
        NSInteger width = WIDTH_SCREEN;
        if(width == 320){
            return fontSize;
        }else if(width == 375){
            if(argsArray.count>1){
                return [[argsArray objectAtIndex:1] integerValue];
            }else{
                return fontSize;
            }
        }else {
            if(argsArray.count>2){
                return [[argsArray objectAtIndex:2] integerValue];
            }else if(argsArray.count>1){
                return [[argsArray objectAtIndex:1] integerValue];
            }else{
                return fontSize;
            }
        }
        
    }else{
        NSAssert(0,@"");
    }
    return 0;
}

+ (CGFloat)autoFontSize:(CGFloat)i5 i6:(CGFloat)i6 i6p:(CGFloat)i6p {
    NSInteger width = WIDTH_SCREEN;
    if(width == 320){
        return i5;
    }else if(width == 375){
        return i6;
    }else {
        return i6p;
    }
}



@end
