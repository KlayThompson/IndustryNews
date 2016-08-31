//
//  UIImage+ImageNamed.m
//  tranb
//
//  Created by VictorChou on 13-4-1.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import "UIImage+ImageNamed.h"
#import "Definition.h"
#import <ImageIO/ImageIO.h>

#define MAX_IMAGEDATA_ATTACHMENT_LEN 400000.0   // max attachment data length 400K
#define kDefaultMaxPixelSize_1024 1024
#define kDefaultMaxPixelSize_800 800
#define kDefaultMaxPixelSize_640 640

@implementation UIImage (ImageNamed)

+ (UIImage *)imageNamedMatch:(NSString *)name;
{
    if (IS_IPHONE_5) {
        name=[name stringByReplacingOccurrencesOfString:@"." withString:@"-568h."];
    }
    return [self imageNamed:name];
}


-(UIImage *)compressedImageToUpload
{
    if (self) {
        
        float compressedLevel = 0.6;
        
        NSData *defaultD = UIImageJPEGRepresentation(self, 1.0);
        
        //                  //缩略大小
        UIImage *thumbnailImage = [self thumbnailForData:defaultD maxPixelSize:kDefaultMaxPixelSize_1024];
        NSData *compressedData = UIImageJPEGRepresentation(thumbnailImage, compressedLevel);
//        DDLogCInfo(@"图片压缩大小为为:%d",kDefaultMaxPixelSize_1024);
        
        if (compressedData.length > MAX_IMAGEDATA_ATTACHMENT_LEN) {
            thumbnailImage = [self thumbnailForData:defaultD maxPixelSize:kDefaultMaxPixelSize_800];
            compressedData = UIImageJPEGRepresentation(thumbnailImage, compressedLevel);
//            DDLogCInfo(@"图片压缩大小为为:%d",kDefaultMaxPixelSize_800);
        }
        
        if (compressedData.length > MAX_IMAGEDATA_ATTACHMENT_LEN) {
            thumbnailImage = [self thumbnailForData:defaultD maxPixelSize:kDefaultMaxPixelSize_640];
            compressedData = UIImageJPEGRepresentation(thumbnailImage, compressedLevel);
//            DDLogCInfo(@"图片压缩大小为为:%d",kDefaultMaxPixelSize_640);
        }
        
        
        while (compressedData.length > MAX_IMAGEDATA_ATTACHMENT_LEN && compressedLevel > 0) {
            compressedLevel = compressedLevel - 0.1;
            compressedData = UIImageJPEGRepresentation(thumbnailImage, compressedLevel);
        }
//        DDLogCInfo(@"图片压缩质量为:%f",compressedLevel);
        //YY-1063 压缩图片为100K以内
        //    NSData *compressedData = [image compressedDataMaxLength:MAX_IMAGEDATA_ATTACHMENT_LEN];
        UIImage *returnImage = [UIImage imageWithData:compressedData];
        
        return returnImage;
        
    } else {
        return nil;
    }
}

- (UIImage *)thumbnailForData:(NSData *)data maxPixelSize:(NSUInteger)size {
    NSParameterAssert(data != nil);
    NSParameterAssert(size > 0);
    
    
    UIImage *tempImage = [UIImage imageWithData:data];
    CFDataRef imgData;
    CGDataProviderRef provider;
    
    imgData = (__bridge CFDataRef)data;
    provider = CGDataProviderCreateWithCFData (imgData);
    
    //    CFRelease(imgData);
    
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInteger:size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef scale:tempImage.scale orientation:tempImage.imageOrientation];
    
    CFRelease(imageRef);
    
    return toReturn;
}

//修复方向
- (UIImage *)fixOrientationOfImage:(UIImage *)image {
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
