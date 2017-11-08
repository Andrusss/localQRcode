//
//  BSQRUtil.h
//  LocalQRcode
//
//  Created by Cindy on 2017/11/8.
//  Copyright © 2017年 单丶依. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface BSQRUtil : NSObject

/**
 生成普通的二维码

 @param string 二维码数据信息
 @param imageWidth 二维码宽度(也是高度)
 @return 生成的二维码
 */
+ (UIImage *)createDefaultQRCodeWithString:(NSString *)string imageWidth:(CGFloat)imageWidth;

/**
 生成带logo的二维码

 @param string 二维码数据信息
 @param logoImageName logo
 @param logoScale logo缩放比例，0-1
 @return 生成的二维码
 */
+ (UIImage *)createLogoQRCodeWithString:(NSString *)string logoImageName:(NSString *)logoImageName logoScale:(CGFloat)logoScale;

///**
// 生成彩色二维码
//
// @param string 二维码数据信息
// @param backgroundColor 二维码颜色
// @param mainColor 主色调
// @return 生成的二维码
// */
//+ (UIImage *)createColorQRCodeWithString:(NSString *)string backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
