//
//  BSQRUtil.m
//  LocalQRcode
//
//  Created by Cindy on 2017/11/8.
//  Copyright © 2017年 单丶依. All rights reserved.
//

#import "BSQRUtil.h"

@implementation BSQRUtil

#pragma mark - 绘制一张普通的二维码
+ (UIImage *)createDefaultQRCodeWithString:(NSString *)string imageWidth:(CGFloat)imageWidth {
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *informData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:informData forKeyPath:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    return [self drawImageFormCIImage:outputImage withSize:imageWidth];
}

#pragma mark - 绘制一张带logo的二维码
+ (UIImage *)createLogoQRCodeWithString:(NSString *)string logoImageName:(NSString *)logoImageName logoScale:(CGFloat)logoScale {
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *qrImageData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:qrImageData forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    UIImage *qrImage = [UIImage imageWithCIImage:outputImage];
    
    // 添加中间logo
    //开启绘图
    UIGraphicsBeginImageContext(qrImage.size);
    //画logo
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    //把logo加到二维码上
    UIImage *icon = [UIImage imageNamed:logoImageName];
    CGFloat imageW = qrImage.size.width * logoScale;
    CGFloat imageH = qrImage.size.height * logoScale;
    CGFloat imageX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imageY = (qrImage.size.height - imageH) * 0.5;
    [icon drawInRect:CGRectMake(imageX, imageY, imageW, imageH)];
    UIImage *finish = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finish;
}

//#pragma mark - 绘制一张彩色的二维码
//+ (UIImage *)createColorQRCodeWithString:(NSString *)string backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor {
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodefilter"];
//    [filter setDefaults];
//    NSData *qrImageData = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [filter setValue:qrImageData forKey:@"information"];
//    CIImage *outputImage = [filter outputImage];
//    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
//    
//    CIFilter * color_filter = [CIFilter filterWithName:@"CIFalseColor"];
//    [color_filter setDefaults];
//    [color_filter setValue:outputImage forKey:@"inputImage"];
//    [color_filter setValue:backgroundColor forKey:@"inputColor0"];
//    [color_filter setValue:mainColor forKey:@"inputColor1"];
//    CIImage *colorImage = [color_filter outputImage];
//    
//    return [UIImage imageWithCIImage:colorImage];
//}

#pragma mark - CIImage转UIimage
+ (UIImage *)drawImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    
    CGRect rect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(rect), size/CGRectGetHeight(rect));
    size_t width = CGRectGetWidth(rect) * scale;
    size_t height = CGRectGetHeight(rect) * scale;
    CGColorSpaceRef sr = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, sr, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:rect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, rect, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
