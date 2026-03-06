//
//  UIColor+SDColor.h
//  SPianoOC
//
//  Created by Nick on 3/5/26.
//

 
#import <UIKit/UIKit.h>

@interface UIColor (JSDColor)
/// 使用 16 进制数字创建颜色，例如 0xFF0000 创建红色
///
/// @param hex 16 进制无符号32位整数
///
/// @return 颜色
+ (instancetype)sd_colorWithHex:(uint32_t)hex;

/// 生成随机颜色
///
/// @return 随机颜色
+ (instancetype)sd_randomColor;

/// 使用 R / G / B 数值创建颜色
///
/// @param red   red
/// @param green green
/// @param blue  blue
///
/// @return 颜色
+ (instancetype)sd_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

/**
 获取图片主色调

 @param image 图片
 @return 图片的主颜色
 */
+ (UIColor*)sd_mostColor:(UIImage*)image;
@end
